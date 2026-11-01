"""Offline Finecolour generator checks: python -B tool/data/test_generate_finecolour.py."""

import copy
import importlib.util
from pathlib import Path
import tempfile
import unittest
from unittest.mock import MagicMock, patch

HERE = Path(__file__).resolve().parent
SPEC = importlib.util.spec_from_file_location("generate_finecolour", HERE / "generate_finecolour.py")
generator = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(generator)
SNAPSHOT = HERE / "baseline/finecolour_colors_source.js"


class FinecolourGeneratorTest(unittest.TestCase):
    def setUp(self):
        self.source = SNAPSHOT.read_text(encoding="utf-8")
        self.rows = generator.parse_source(self.source)

    def test_pinned_source_regenerates_committed_json_byte_for_byte(self):
        colors = generator.build(self.rows)
        self.assertEqual(len(colors), 480)
        self.assertEqual(len({c["code"] for c in colors}), 480)
        self.assertEqual(generator.render(colors).encode("utf-8"),
                         generator.DEFAULT_OUT.read_bytes())
        self.assertEqual(colors[0], {"code": "0", "name": "Colorless Blender",
                                    "hex": "ffffff", "sets": [],
                                    "lines": ["EF100", "EF101", "EF102", "EF103"]})
        self.assertEqual(next(c for c in colors if c["code"] == "BV321")["lines"],
                         next(r for r in self.rows if r["code"] == "BV321")["lines"])

    def test_only_marker_space_is_imported(self):
        # Other spaces may share codes or have no English name at all.
        self.assertTrue(any(r["space"] == "fineliner" for r in self.rows))
        self.assertTrue(any(r["space"] == "acrylic" for r in self.rows))
        markers = [r for r in self.rows if r["space"] == "marker"]
        self.assertEqual(generator.build(self.rows), generator.build(markers))

    def test_refuses_non_json_javascript(self):
        for source in ["[]", "window.FINECOLOUR_COLORS = [undefined];",
                       "window.FINECOLOUR_COLORS = [{code:'X'}];",
                       "window.FINECOLOUR_COLORS = [1,];",
                       "window.FINECOLOUR_COLORS = [NaN];",
                       "window.FINECOLOUR_COLORS = []; alert('no');",
                       "window.FINECOLOUR_COLORS = [];\nwindow.FINECOLOUR_COLORS = [];"]:
            with self.subTest(source=source), self.assertRaises(ValueError):
                generator.parse_source(source)

    def test_refuses_invalid_marker_data(self):
        markers = [r for r in self.rows if r["space"] == "marker"]
        cases = [markers[:-1], {}, [None]]
        for key, value in [("code", "0"), ("code", " "), ("name", " "),
                           ("name", None), ("hex", "#12345g"), ("hex", None),
                           ("lines", ["EF300"]), ("lines", []),
                           ("lines", ["EF102", "EF102"])]:
            rows = copy.deepcopy(markers)
            rows[1][key] = value
            cases.append(rows)
        for rows in cases:
            with self.subTest(kind=type(rows).__name__), self.assertRaises(ValueError):
                generator.build(rows)

    def test_offline_rebuild_and_check_do_not_overwrite_on_failure(self):
        with tempfile.TemporaryDirectory(prefix="inklab-finecolour-") as directory:
            output = Path(directory) / "generated.json"
            args = ["--from-file", str(SNAPSHOT), "--out", str(output)]
            self.assertEqual(generator.main(args), 0)
            self.assertEqual(output.read_bytes(), generator.DEFAULT_OUT.read_bytes())
            self.assertEqual(generator.main(args + ["--check"]), 0)
            output.write_text("unchanged", encoding="utf-8")
            self.assertEqual(generator.main(args + ["--check"]), 1)
            self.assertEqual(output.read_text(), "unchanged")

    def test_download_is_restricted_to_the_pinned_url(self):
        rejected = [generator.SOURCE_URL.replace(generator.SOURCE_COMMIT, "main"),
                    generator.SOURCE_URL.replace("https:", "http:"),
                    generator.SOURCE_URL.replace("raw.githubusercontent.com", "example.com"),
                    generator.SOURCE_URL.replace("finecolour-color/", "finecolour-color-evil/")]
        handler = generator.PinnedRedirectHandler()
        for url in rejected:
            with self.subTest(url=url), self.assertRaises(ValueError):
                handler.redirect_request(None, None, 302, "Found", {}, url)
        with tempfile.TemporaryDirectory(prefix="inklab-finecolour-download-") as directory:
            output = Path(directory) / "generated.json"
            for url in [generator.SOURCE_URL, *rejected]:
                output.write_text("unchanged", encoding="utf-8")
                response = MagicMock()
                response.__enter__.return_value = response
                response.geturl.return_value = url
                response.read.return_value = self.source.encode("utf-8")
                opener = MagicMock()
                opener.open.return_value = response
                with patch.object(generator.urllib.request, "build_opener", return_value=opener):
                    self.assertEqual(generator.main(["--out", str(output)]),
                                     0 if url == generator.SOURCE_URL else 1)
                opener.open.assert_called_once_with(generator.SOURCE_URL, timeout=30)
                if url != generator.SOURCE_URL:
                    response.read.assert_not_called()
                    self.assertEqual(output.read_text(), "unchanged")


if __name__ == "__main__":
    unittest.main()
