"""Offline validation of the Ohuhu generator.

Run with python -B tool/data/test_generate_ohuhu.py.

The generator's sources are community Google Sheets with no explicit licence
(see "Licence notes" in tool/data/README.md), so their text is not bundled
here. This file checks everything that can be checked without the sheets: the
pure helpers, the layout guard and the download host restriction. The
snapshot-based regeneration is present but skipped, with the reason, until the
licence is clarified.
"""

import importlib.util
from pathlib import Path
import unittest

HERE = Path(__file__).resolve().parent
SPEC = importlib.util.spec_from_file_location("generate_ohuhu", HERE / "generate_ohuhu.py")
generator = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(generator)


class OhuhuGeneratorHelpersTest(unittest.TestCase):
    def test_natural_compare_matches_the_dart_port(self):
        # Port of naturalCodeComparator: digit runs compare as numbers, ties
        # fall back to the caller (plain string order in the generator).
        self.assertLess(generator.natural_compare("R1", "R2"), 0)
        self.assertGreater(generator.natural_compare("R10", "R2"), 0)
        self.assertLess(generator.natural_compare("BV4", "BV10"), 0)
        self.assertEqual(generator.natural_compare("BV04", "BV4"), 0)
        self.assertEqual(generator.natural_compare("BV4", "BV04"), 0)
        self.assertEqual(generator.natural_compare("a", "A"), 0)
        # A shorter token list sorts first when every shared token is equal.
        self.assertLess(generator.natural_compare("R", "R2"), 0)

    def test_clean_text_collapses_whitespace_and_drops_footnotes(self):
        self.assertEqual(generator.clean_text("  Foo   Bar  "), "Foo Bar")
        self.assertEqual(generator.clean_text("Antwerp*"), "Antwerp")
        self.assertEqual(generator.clean_text("Delicate **"), "Delicate")
        self.assertEqual(generator.clean_text("A\nB"), "A B")
        self.assertEqual(generator.clean_text(""), "")
        self.assertEqual(generator.clean_text(None), "")

    def test_sanitize_hex_accepts_only_six_hex_digits(self):
        self.assertEqual(generator.sanitize_hex("#ABCDEF"), "abcdef")
        self.assertEqual(generator.sanitize_hex(" 123456 "), "123456")
        for bad in ("", "  ", "#", "12345", "1234567", "zzzzzz", None):
            self.assertEqual(generator.sanitize_hex(bad), "", msg=repr(bad))

    def test_cell_and_hex_lookup(self):
        self.assertEqual(generator.cell(["a", "b"], 1), "b")
        self.assertEqual(generator.cell(["a"], 5), "")
        rows = [
            ["Code", "", "", "", "", "", "", "", "Hex"],
            ["R1", "", "", "", "", "", "", "", "#FF0000"],
            ["", "", "", "", "", "", "", "", "#000000"],
            ["R2", "", "", "", "", "", "", "", "not a hex"],
        ]
        self.assertEqual(generator.build_hex_lookup(rows), {"R1": "ff0000"})

    def test_verify_layout_accepts_the_fixed_layout_and_fails_when_moved(self):
        rows = self._layout_rows()
        log = []
        generator.verify_layout(rows, log)  # must not raise

        moved = self._layout_rows()
        moved[generator.HEADER_ROW_LABEL][generator.COL_NEW_CODE] = "codes"
        with self.assertRaises(SystemExit):
            generator.verify_layout(moved, [])

        moved = self._layout_rows()
        moved[generator.HEADER_ROW_LABEL][generator.SET_DEFS[0][2]] = "nope"
        with self.assertRaises(SystemExit):
            generator.verify_layout(moved, [])

        with self.assertRaises(SystemExit):
            generator.verify_layout([["only"], ["one row"]], [])

    def test_download_refuses_hosts_outside_google_sheets(self):
        for url in (
            generator.SHEET_CSV_URL,
            generator.HEX_CSV_URL,
            "https://docs.googleusercontent.com/x.csv",
            "https://sub.googleusercontent.com/x.csv",
        ):
            self.assertIsNone(generator._check_host(url), msg=url)
        for url in (
            "http://docs.google.com/x.csv",
            "https://example.com/x.csv",
            "https://docs.google.com.evil.test/x.csv",
            "https://docsgoogle.com/x.csv",
        ):
            with self.assertRaises(ValueError, msg=url):
                generator._check_host(url)

    @staticmethod
    def _layout_rows():
        width = generator.COL_HEX + 1
        group = [""] * width
        label = [""] * width
        label[generator.COL_NEW_CODE] = "new codes"
        label[generator.COL_NEW_NAME] = "new names"
        label[generator.COL_OAHU_CODE] = "o code"
        label[generator.COL_HONOLULU_CODE] = "h code"
        label[generator.COL_KAALA_CODE] = "k code"
        label[generator.COL_HEX] = "hex code"
        for _set_id, _line, col, label_text, fragment, _count, _blender in generator.SET_DEFS:
            label[col] = label_text
            group[col] = fragment
        return [group, label, [""] * width]

    @unittest.skip(
        "Ohuhu sources are community Google Sheets with no explicit licence "
        "(tool/data/README.md, 'Licence notes'): their text and formatting are "
        "not bundled. Add a pinned CSV snapshot here only if an owner grants a "
        "licence; until then the committed file is checked by the layout guard, "
        "the helpers above and test/core/ohuhu_catalog_test.dart."
    )
    def test_pinned_snapshot_regenerates_the_committed_json(self):
        # When a licensed snapshot exists (tool/data/baseline/), load it with
        # generator.load_inputs / parse_csv and assert:
        #   render(build(sheet, hex)) == committed assets/data/ohuhu_colors.json
        self.fail("No licensed snapshot to regenerate from")


if __name__ == "__main__":
    unittest.main()
