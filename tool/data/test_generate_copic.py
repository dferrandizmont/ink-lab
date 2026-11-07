"""Offline validation of the Copic generator. Run with python -B tool/data/test_generate_copic.py."""

import copy
import importlib.util
import json
from pathlib import Path
import tempfile
import unittest
from unittest.mock import patch, MagicMock

HERE = Path(__file__).resolve().parent
SPEC = importlib.util.spec_from_file_location("generate_copic", HERE / "generate_copic.py")
generator = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(generator)

# The full upstream colors.json at the commit pinned by
# generate_copic.SOURCE_COMMIT, kept offline. It keeps all eight upstream
# fields; the generator imports only number, name and the official hex and
# ignores the rest (extractedColor among them, which the test proves). The MIT
# licence of meodai/copic-colors allows bundling it: the file ships alongside
# its LICENSE (baseline/copic_colors_source.LICENSE; see NOTICE.md).
SNAPSHOT = HERE / "baseline" / "copic_colors_source.json"


class CopicGeneratorTest(unittest.TestCase):
    def setUp(self):
        self.catalogue = json.loads(generator.DEFAULT_OUT.read_text(encoding="utf-8"))
        self.rows = json.loads(SNAPSHOT.read_text(encoding="utf-8"))
        self.membership = generator.line_membership()

    def test_pinned_snapshot_regenerates_the_committed_json(self):
        # The whole point: the pinned source, through the generator, must
        # reproduce the committed file byte for byte, with no network.
        self.assertEqual(len(self.rows), generator.EXPECTED_COUNT)
        self.assertEqual(generator.build(self.rows, self.membership), self.catalogue)
        self.assertEqual(
            generator.render(generator.build(self.rows, self.membership)).encode("utf-8"),
            generator.DEFAULT_OUT.read_bytes())

    def test_output_and_official_hex(self):
        self.assertEqual(generator.build(self.rows, self.membership), self.catalogue)
        self.assertEqual(len({c["code"] for c in self.catalogue}), 358)
        self.assertEqual(generator.build(self.rows, self.membership)[0], {
            "code": "0", "name": "Colorless Blender", "hex": "ffffff", "sets": [],
            "lines": ["sketch", "ciao", "classic"]})
        # Without membership the records are the plain Sketch ones.
        self.assertNotIn("lines", generator.build(self.rows)[0])
        self.assertEqual(generator.render(self.catalogue).encode("utf-8"),
                         generator.DEFAULT_OUT.read_bytes())

    def test_lines_are_sketch_plus_ciao_and_classic_membership(self):
        by_code = {c["code"]: c for c in self.catalogue}
        count = lambda line: sum(line in c["lines"] for c in self.catalogue)
        self.assertEqual((count("sketch"), count("ciao"), count("classic")), (358, 180, 214))
        self.assertTrue(all(c["lines"][0] == "sketch" for c in self.catalogue))
        # Ids and everything but lines are what they were before lines existed.
        self.assertEqual(by_code["BV04"]["lines"], ["sketch", "ciao", "classic"])
        self.assertEqual(by_code["FB"]["lines"], ["sketch"])  # fluorescent: Sketch only
        self.assertEqual(self.membership.keys(), {"ciao", "classic"})
        self.assertLessEqual(self.membership["ciao"], set(by_code))
        self.assertLessEqual(self.membership["classic"], set(by_code))

    def test_refuses_membership_that_is_not_a_sketch_code(self):
        membership = {line: set(codes) for line, codes in self.membership.items()}
        membership["ciao"].add("NOPE")
        with self.assertRaises(ValueError):
            generator.build(self.rows, membership)
        membership = {line: set(codes) for line, codes in self.membership.items()}
        membership["classic"].pop()
        with self.assertRaises(ValueError):
            generator.build(self.rows, membership)

    def test_refuses_invalid_inputs(self):
        cases = [self.rows[:-1], {}]
        for key, value in [("number", self.rows[0]["number"]), ("number", " "),
                           ("name", " "), ("hex", "#xyzxyz"), ("hex", None)]:
            rows = copy.deepcopy(self.rows)
            rows[1][key] = value
            cases.append(rows)
        no_blender = copy.deepcopy(self.rows)
        no_blender[0]["number"] = "999"
        cases.append(no_blender)
        for rows in cases:
            with self.subTest(rows=type(rows).__name__):
                with self.assertRaises(ValueError):
                    generator.build(rows)

    def test_normalizes_and_ignores_extracted_color(self):
        self.rows[1].update(number=" zz1 ", name=" Test ", hex="#ABCDEF")
        self.assertEqual(generator.build(self.rows)[1], {
            "code": "ZZ1", "name": "Test", "hex": "abcdef", "sets": []})

    def test_check_and_offline_rebuild(self):
        with tempfile.TemporaryDirectory(prefix="inklab-copic-test-") as directory:
            source = Path(directory) / "colors.json"
            output = Path(directory) / "generated.json"
            source.write_text(json.dumps(self.rows), encoding="utf-8")
            args = ["--from-file", str(source), "--out", str(output)]
            self.assertEqual(generator.main(args), 0)
            self.assertEqual(output.read_bytes(), generator.DEFAULT_OUT.read_bytes())
            self.assertEqual(generator.main(args + ["--check"]), 0)
            output.write_text("[]", encoding="utf-8")
            self.assertEqual(generator.main(args + ["--check"]), 1)
            self.assertEqual(output.read_text(encoding="utf-8"), "[]")

    def test_download_accepts_only_the_copic_source_prefix(self):
        with tempfile.TemporaryDirectory(prefix="inklab-copic-redirect-") as directory:
            output = Path(directory) / "generated.json"
            for url, allowed in [
                (generator.SOURCE_URL, True),
                ("https://raw.githubusercontent.com/meodai/copic-colors/main/colors.json", True),
                ("http://raw.githubusercontent.com/meodai/copic-colors/colors.json", False),
                ("https://example.com/colors.json", False),
                ("https://raw.githubusercontent.com/meodai/other/colors.json", False),
                ("https://raw.githubusercontent.com/meodai/copic-colors-evil/colors.json", False),
                ("https://raw.githubusercontent.com.evil.test/meodai/copic-colors/colors.json", False),
            ]:
                with self.subTest(url=url):
                    output.write_text("unchanged", encoding="utf-8")
                    response = MagicMock()
                    response.__enter__.return_value = response
                    response.geturl.return_value = url
                    response.read.return_value = json.dumps(self.rows).encode("utf-8")
                    with patch.object(generator.urllib.request, "urlopen", return_value=response) as open_url:
                        self.assertEqual(generator.main(["--out", str(output)]), 0 if allowed else 1)
                    open_url.assert_called_once_with(generator.SOURCE_URL, timeout=30)
                    if allowed:
                        self.assertEqual(output.read_bytes(), generator.DEFAULT_OUT.read_bytes())
                    else:
                        response.read.assert_not_called()
                        self.assertEqual(output.read_text(encoding="utf-8"), "unchanged")


if __name__ == "__main__":
    unittest.main()
