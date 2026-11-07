"""Offline regression tests for the merged Spectrum Noir catalogue (stdlib only)."""

import copy
import importlib.util
import json
from pathlib import Path
import tempfile
import unittest

HERE = Path(__file__).resolve().parent
SPEC = importlib.util.spec_from_file_location(
    "generate_spectrum_noir", HERE / "generate_spectrum_noir.py")
generator = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(generator)


def load(path):
    return json.loads(Path(path).read_text(encoding="utf-8"))


class SpectrumNoirMergeTest(unittest.TestCase):
    def setUp(self):
        self.illustrator = load(generator.DEFAULT_ILLUSTRATOR)
        self.triblend = load(generator.DEFAULT_TRIBLEND)
        self.mm = generator._markermatch()
        self.rows = self.mm.load_rows(generator.DEFAULT_SOURCE)
        self.classic = generator.classic_codes(self.rows)

    def test_committed_catalogue_is_reproduced_byte_for_byte(self):
        committed = generator.DEFAULT_OUT.read_bytes()
        self.assertEqual(generator.render(generator.generate()).encode("utf-8"), committed)
        self.assertNotIn(b"\r", committed)

    def test_line_counts_and_membership(self):
        colors = generator.generate()
        by_code = {c["code"]: c for c in colors}
        self.assertEqual(len(colors), 216)
        self.assertEqual(len(by_code), 216)
        count = lambda line: sum(line in c["lines"] for c in colors)
        self.assertEqual((count("classic"), count("illustrator"), count("triblend")),
                         (168, 216, 144))
        # The Illustrator range is the classic one plus 48 colours.
        self.assertEqual(sum("classic" not in c["lines"] for c in colors), 48)
        for color in colors:
            self.assertEqual(color["sets"], [])
            self.assertEqual(color["lines"], [l for l in generator.LINE_ORDER
                                              if l in color["lines"]])

    def test_aliases_and_the_code_missing_from_the_import(self):
        self.assertEqual(len(self.classic), 168)
        self.assertNotIn("BLENDER", self.classic)
        self.assertNotIn("TRUEBLACK", self.classic)
        by_code = {c["code"]: c for c in generator.generate()}
        for code in ("BL", "TB", "BT6"):
            self.assertIn("classic", by_code[code]["lines"])
        # BT6 has a malformed hex in MarkerMatchDB; the chart has it.
        self.assertEqual(by_code["BT6"]["hex"], "0aa9c5")
        self.assertEqual(by_code["BT6"]["name"], "Peacock Blue")

    def test_chart_hex_and_names_win_over_markermatch(self):
        by_code = {c["code"]: c for c in generator.generate()}
        mm = {r["code"].strip().upper(): r for r in self.rows
              if r["line"] == "spectrumMarkers"}
        self.assertEqual(by_code["EB1"]["hex"], next(
            c["hex"] for c in self.illustrator if c["code"] == "EB1"))
        self.assertNotEqual(by_code["EB1"]["hex"], mm["EB1"]["hex"].lower())
        self.assertNotEqual(by_code["EB1"]["name"], "EB1")  # MarkerMatchDB had codes only

    def test_triblend_tones_use_the_illustrator_value(self):
        by_code = {c["code"]: c for c in generator.generate()}
        tone = next(c for c in self.triblend if c["code"] == "FS7")
        chart = next(c for c in self.illustrator if c["code"] == "FS7")
        self.assertNotEqual(tone["hex"], chart["hex"])
        self.assertEqual(by_code["FS7"]["hex"], chart["hex"])
        self.assertEqual({c["code"] for c in self.triblend},
                         {code for code, c in by_code.items() if "triblend" in c["lines"]})

    def test_cross_checks_fail_loudly(self):
        bad = copy.deepcopy(self.triblend)
        bad[0]["code"] = "NOPE1"
        with self.assertRaises(ValueError):
            generator.build(self.illustrator, bad, self.classic)
        with self.assertRaises(ValueError):
            generator.build(self.illustrator, self.triblend, self.classic + ["NOPE2"])
        with self.assertRaises(ValueError):
            generator.build(self.illustrator, self.triblend, self.classic[:-1])
        dup = copy.deepcopy(self.illustrator) + [self.illustrator[0]]
        with self.assertRaises(ValueError):
            generator.build(dup, self.triblend, self.classic)
        broken = copy.deepcopy(self.illustrator)
        broken[0]["hex"] = "zzzzzz"
        with self.assertRaises(ValueError):
            generator.build(broken, self.triblend, self.classic)

    def test_cli_writes_and_checks(self):
        with tempfile.TemporaryDirectory(prefix="inklab-sn-merge-") as folder:
            out = Path(folder) / "spectrum_noir_colors.json"
            self.assertEqual(generator.main(["--out", str(out), "--check"]), 1)
            self.assertEqual(generator.main(["--out", str(out)]), 0)
            self.assertEqual(out.read_bytes(), generator.DEFAULT_OUT.read_bytes())
            self.assertEqual(generator.main(["--out", str(out), "--check"]), 0)


if __name__ == "__main__":
    unittest.main()
