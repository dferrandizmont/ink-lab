"""Offline MarkerMatchDB regression tests (Python 3.9+, stdlib only)."""

import copy
import hashlib
import importlib.util
from pathlib import Path
import tempfile
import unittest
from unittest.mock import MagicMock, patch

HERE = Path(__file__).resolve().parent
SPEC = importlib.util.spec_from_file_location("generate_markermatch", HERE / "generate_markermatch.py")
generator = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(generator)
SNAPSHOT = HERE / "baseline/markermatch_source.csv"


class MarkerMatchGeneratorTest(unittest.TestCase):
    def setUp(self):
        self.source = SNAPSHOT.read_text(encoding="utf-8-sig")
        self.rows = generator.read_rows(self.source)

    def test_pinned_full_snapshot_reproduces_committed_bytes(self):
        self.assertRegex(generator.SOURCE_COMMIT, r"^[0-9a-f]{40}$")
        self.assertEqual(len(self.rows), 2804)
        dropped = []
        catalogues = generator.build(self.rows, dropped.append)
        self.assertEqual(set(dropped), {
            "Dropped rows 8512 and 8578 (touchTwinMarker, PB72): conflicting names/hex",
            "Dropped rows 8112 and 8178 (touchTwinBrush, PB72): conflicting names/hex",
        })
        self.assertEqual(list(catalogues), list(generator.EXPECTED_COUNTS))
        for brand, colors in catalogues.items():
            self.assertEqual(len(colors), generator.EXPECTED_COUNTS[brand])
            self.assertEqual(len({c["code"] for c in colors}), len(colors))
            self.assertEqual(generator.render(colors).encode("utf-8"),
                             (generator.DEFAULT_OUT / (brand + "_colors.json")).read_bytes())
            for color in colors:
                self.assertRegex(color["hex"], r"^[0-9a-f]{6}$")
                self.assertTrue(color["name"].strip())
                self.assertEqual(color["sets"], [])
        self.assertTrue(all(c["lines"] == ["touchTwinMarker", "touchTwinBrush"]
                            for c in catalogues["touch_twin"]))
        self.assertTrue(all(c["oldCode"] == c["code"].replace("PM", "PB", 1)
                            and " " not in c["code"] and c["code"].startswith("PM")
                            for c in catalogues["prismacolor"]))
        self.assertNotIn("PB72", {c["code"] for c in catalogues["touch_twin"]})
        # Spectrum Noir is not generated from this source (its hex is wrong).
        self.assertNotIn("spectrum_noir", catalogues)
        self.assertEqual(
            {brand: len(colors) for brand, colors in catalogues.items()},
            {"touch_twin": 202, "promarker": 148, "promarker_brush": 72,
             "prismacolor": 200, "blick_brush": 96, "artists_loft": 56})

    def test_promarker_brush_is_its_own_brand_because_the_ranges_do_not_line_up(self):
        catalogues = generator.build(self.rows, lambda _: None)
        promarker = {c["code"]: c for c in catalogues["promarker"]}
        brush = {c["code"]: c for c in catalogues["promarker_brush"]}
        self.assertEqual(len(set(brush) - set(promarker)), 15)
        disagree = [code for code in brush if code in promarker and
                    (brush[code]["name"], brush[code]["hex"]) !=
                    (promarker[code]["name"], promarker[code]["hex"])]
        self.assertEqual(len(disagree), 8)  # Y828 and the CG/WG greys

    def test_line_codes_are_membership_only(self):
        self.assertEqual(len(generator.line_codes(self.rows, "copicCiao")), 180)
        self.assertEqual(len(generator.line_codes(self.rows, "copicClassic")), 214)
        spectrum = generator.line_codes(self.rows, "spectrumMarkers")
        self.assertEqual(len(spectrum), 168)
        self.assertIn("BT6", spectrum)  # malformed hex, still a member
        with self.assertRaises(ValueError):
            generator.line_codes(self.rows + [next(
                r for r in self.rows if r["line"] == "copicCiao")], "copicCiao")

    def test_snapshot_keeps_the_upstream_bytes(self):
        raw = SNAPSHOT.read_bytes()
        self.assertIn(b"\r\n", raw)  # upstream uses CRLF; .gitattributes sets -text
        self.assertEqual(
            hashlib.sha256(raw).hexdigest(),
            "e86dad2984a6def850d4e7082253346522e21986adba2ecfa94b432e89656353")

    def test_rejects_duplicates_missing_names_counts_and_disagreeing_variants(self):
        for line, key, value in [("touchTwinBrush", "hex", "123456"),
                                 ("prismaPB", "name", "Different"),
                                 ("winsorPromarker", "name", " "),
                                 ("winsorPromarker", "name", None),
                                 ("winsorPromarker", "code", " "),
                                 ("winsorPromarker", "hex", "bad")]:
            rows = copy.deepcopy(self.rows)
            next(r for r in rows if r["line"] == line)[key] = value
            with self.subTest(line=line, key=key):
                with self.assertRaises(ValueError):
                    generator.build(rows, lambda _: None)
        with self.assertRaises(ValueError):
            generator.build(self.rows + [next(r for r in self.rows if r["line"] == "winsorPromarker")])
        with self.assertRaises(ValueError):
            generator.build([], lambda _: None)
        with self.assertRaises(ValueError):
            generator.read_rows("code,name,hex\n1,red,ff0000\n")

    def test_ignores_unselected_lines_and_normalizes_hex(self):
        rows = copy.deepcopy(self.rows)
        next(r for r in rows if r["line"] == "winsorPromarker")["hex"] = " #ABCDEF "
        next(r for r in rows if r["line"] == "tombrowDualBrush")["name"] = ""
        colors = generator.build(rows, lambda _: None)
        self.assertEqual(colors["promarker"][0]["hex"], "abcdef")

    def test_offline_cli_check_does_not_write_and_detects_any_changed_file(self):
        with tempfile.TemporaryDirectory(prefix="inklab-markermatch-") as folder:
            args = ["--from-file", str(SNAPSHOT), "--out", folder]
            self.assertEqual(generator.main(args), 0)
            for brand in generator.EXPECTED_COUNTS:
                name = brand + "_colors.json"
                self.assertEqual((Path(folder) / name).read_bytes(),
                                 (generator.DEFAULT_OUT / name).read_bytes())
            self.assertEqual(generator.main(args + ["--check"]), 0)
            output = Path(folder) / "promarker_colors.json"
            output.write_bytes(b"[]")
            self.assertEqual(generator.main(args + ["--check"]), 1)
            self.assertEqual(output.read_bytes(), b"[]")

    def test_download_is_pinned_and_rejects_other_urls(self):
        with tempfile.TemporaryDirectory(prefix="inklab-markermatch-download-") as folder:
            for url, expected in [(generator.SOURCE_URL, 0),
                                  ("https://example.com/MarkerMatchDB.csv", 1),
                                  (generator.SOURCE_URL.replace(generator.SOURCE_COMMIT, "master"), 1)]:
                response = MagicMock()
                response.__enter__.return_value = response
                response.geturl.return_value = url
                response.read.return_value = self.source.encode("utf-8")
                opener = MagicMock()
                opener.open.return_value = response
                with patch.object(generator.urllib.request, "build_opener", return_value=opener):
                    self.assertEqual(generator.main(["--out", folder]), expected)
                opener.open.assert_called_once_with(generator.SOURCE_URL, timeout=30)
                if expected:
                    response.read.assert_not_called()
        handler = generator.PinnedSourceOnly()
        for url in ["http://raw.githubusercontent.com/GrumpyCockatiel/MarkerMatchDB/x.csv",
                    "https://example.com/x.csv"]:
            with self.assertRaises(ValueError):
                handler.redirect_request(None, None, 302, "", {}, url)


if __name__ == "__main__":
    unittest.main()
