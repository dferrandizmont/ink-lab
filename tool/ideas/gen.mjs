// Usage: node gen.mjs <repo>
//
// The Ideas content (content.mjs) is written in English and Spanish only, so
// this script regenerates the ideas* and palette* keys of app_en.arb and
// app_es.arb and nothing else. It never touches app_de/fr/pt/it.arb, which are
// translated by hand: after a change of content, a new, renamed or removed key
// is reported at the end (exit code 1) and test/l10n/arb_parity_test.dart
// fails until the four ARBs have the same keys as app_en.arb.
import fs from 'node:fs';
import path from 'node:path';
import { presets, roles, ui, uiParams, palette } from './content.mjs';

const repo = process.argv[2];
if (!repo || !process.argv.includes('--force')) {
  console.error('Refusing to run: read the warning at the top of this file, then pass <repo> --force.');
  process.exit(2);
}
const pascal = (s) => s.split(/[_\s-]+/).map((w) => w[0].toUpperCase() + w.slice(1)).join('');
const dartStr = (s) => "'" + s.replace(/\\/g, '\\\\').replace(/'/g, "\\'").replace(/\$/g, '\\$') + "'";

// ---- sanity
const roleNames = new Set(Object.keys(roles));
const ids = new Set();
for (const p of presets) {
  if (ids.has(p.id)) throw new Error('dup ' + p.id);
  ids.add(p.id);
  if (p.steps.length < 4 || p.steps.length > 6) throw new Error('steps ' + p.id);
  for (const [r] of p.steps) if (r !== null && !roleNames.has(r)) throw new Error(`role ${r} in ${p.id}`);
}

// ---- ARB
function contentEntries(lang) {
  const out = [];
  for (const p of presets) {
    const k = 'ideas' + pascal(p.id);
    const t = p[lang];
    out.push([k + 'Title', t.title], [k + 'Summary', t.summary], [k + 'Practice', t.practice],
      [k + 'Subject', t.subject], [k + 'Tip', t.tip]);
    p.steps.forEach((s, i) => out.push([`${k}Step${i + 1}`, lang === 'en' ? s[1] : s[2]]));
  }
  for (const [role, [en, es, ren, res]] of Object.entries(roles)) {
    out.push(['ideasRole' + pascal(role), lang === 'en' ? en : es]);
    out.push(['ideasReason' + pascal(role), lang === 'en' ? ren : res]);
  }
  return out;
}

function updateArb(lang) {
  const file = path.join(repo, 'lib/l10n', `app_${lang}.arb`);
  const src = JSON.parse(fs.readFileSync(file, 'utf8'));
  const entries = Object.entries(src).filter(([k]) => !/^@?idea[A-Z]/.test(k));
  const map = new Map(entries);
  const order = entries.map(([k]) => k);
  const ideasNew = [];
  const paletteNew = [];
  const set = (bucket, key, value, meta) => {
    if (map.has(key)) map.set(key, value); else bucket.push(key), map.set(key, value);
    if (lang === 'en' && meta) { if (!map.has('@' + key)) bucket.push('@' + key); map.set('@' + key, meta); }
  };
  for (const [k, v] of Object.entries(ui)) {
    if (v === null) { map.delete(k); map.delete('@' + k); continue; }
    set(ideasNew, k, lang === 'en' ? v[0] : v[1]);
  }
  for (const [k, v] of Object.entries(uiParams)) set(ideasNew, k, v[lang], { placeholders: v.placeholders });
  for (const [k, v] of contentEntries(lang)) set(ideasNew, k, v);
  for (const [k, v] of Object.entries(palette)) {
    if (Array.isArray(v)) set(paletteNew, k, lang === 'en' ? v[0] : v[1]);
    else set(paletteNew, k, v[lang], { placeholders: v.placeholders });
  }
  const result = {};
  for (const k of order) {
    if (map.has(k)) result[k] = map.get(k);
    if (k === 'ideasNoMarkers') for (const n of ideasNew) result[n] = map.get(n);
    if (k === 'paletteNoSuggestions') for (const n of paletteNew) result[n] = map.get(n);
  }
  for (const n of [...ideasNew, ...paletteNew]) if (!(n in result)) throw new Error('anchor missing for ' + n);
  fs.writeFileSync(file, JSON.stringify(result, null, 2) + '\n');
}
updateArb('en');
updateArb('es');

// ---- the hand-translated ARBs are left alone; report what drifted
const handTranslated = ['de', 'fr', 'pt', 'it'];
const messageKeys = (lang) => Object.keys(JSON.parse(fs.readFileSync(path.join(repo, 'lib/l10n', `app_${lang}.arb`), 'utf8'))).filter((k) => !k.startsWith('@'));
const enKeys = new Set(messageKeys('en'));
let drifted = false;
for (const lang of handTranslated) {
  const keys = new Set(messageKeys(lang));
  const missing = [...enKeys].filter((k) => !keys.has(k));
  const extra = [...keys].filter((k) => !enKeys.has(k));
  if (missing.length || extra.length) {
    drifted = true;
    console.error(`app_${lang}.arb is out of step with app_en.arb: missing ${missing.length}, extra ${extra.length}`);
    for (const k of missing) console.error('  missing ' + k);
    for (const k of extra) console.error('  extra   ' + k);
  }
}
if (drifted) process.exitCode = 1;

// ---- catalog
const enumCat = { technique: 'technique', colorChallenge: 'colorChallenge', mood: 'mood', season: 'season' };
let cat = `part of 'ideas_engine.dart';

// GENERATED from the Ideas content source (titles, steps and roles are kept
// in step with the ideas* ARB messages). Edit both together.
const List<IdeaPreset> _ideaPresets = <IdeaPreset>[
`;
for (const p of presets) {
  cat += `  IdeaPreset(
    id: ${dartStr(p.id)},
    title: ${dartStr(p.en.title)},
    summary: ${dartStr(p.en.summary)},
    category: IdeaCategory.${enumCat[p.cat]},
    difficulty: IdeaDifficulty.${p.diff},
    minutes: ${p.min},
    materials: <IdeaMaterial>[${p.mat.map((m) => 'IdeaMaterial.' + m).join(', ')}],
    stepRoles: <String?>[
${p.steps.map(([r]) => '      ' + (r === null ? 'null' : 'IdeaRoles.' + roleConst(r)) + ',').join('\n')}
    ],
  ),
`;
}
cat += '];\n';
function roleConst(r) {
  const w = r.split(' ');
  return w[0].toLowerCase() + w.slice(1).map((x) => x[0].toUpperCase() + x.slice(1)).join('');
}
fs.writeFileSync(path.join(repo, 'lib/core/ideas_catalog.dart'), cat);

// ---- l10n lookup
let d = `// GENERATED with the ideas* ARB messages: localised text of the Ideas
// presets, roles and labels. Keep in step with lib/core/ideas_catalog.dart.
import '../core/ideas_engine.dart';
import 'app_localizations.dart';

extension IdeasTextLocalizations on AppLocalizations {
`;
const field = (name, ret, fallback) => {
  d += `  ${ret} ${name}(String id) => switch (id) {\n`;
  return (suffix) => {
    for (const p of presets) d += `    ${dartStr(p.id)} => ideas${pascal(p.id)}${suffix},\n`;
    d += `    _ => ${fallback},\n  };\n\n`;
  };
};
field('ideaTitleText', 'String?', 'null')('Title');
field('ideaSummaryText', 'String?', 'null')('Summary');
field('ideaPracticeText', 'String', "''")('Practice');
field('ideaSubjectText', 'String', "''")('Subject');
field('ideaTipText', 'String', "''")('Tip');
d += `  /// The steps of the idea [id], one per entry of its \`stepRoles\`.\n`;
d += `  List<String> ideaStepsText(String id) => switch (id) {\n`;
for (const p of presets) {
  const k = 'ideas' + pascal(p.id);
  d += `    ${dartStr(p.id)} => <String>[\n${p.steps.map((_, i) => `      ${k}Step${i + 1},`).join('\n')}\n    ],\n`;
}
d += `    _ => const <String>[],\n  };\n\n`;
d += `  String ideaTitle(IdeaPreset preset) => ideaTitleText(preset.id) ?? preset.title;\n\n`;
d += `  String ideaSummary(IdeaPreset preset) =>\n      ideaSummaryText(preset.id) ?? preset.summary;\n\n`;
d += `  /// Localised label of an idea role (see [IdeaRoles]), or null.\n`;
d += `  String? ideaRoleText(String role) => switch (role) {\n`;
for (const r of Object.keys(roles)) d += `    ${dartStr(r)} => ideasRole${pascal(r)},\n`;
d += `    _ => null,\n  };\n\n`;
d += `  /// Localised reason of an idea role (see [IdeaRoles.reasonFor]), or null.\n`;
d += `  String? ideaReasonText(String reason) => switch (reason) {\n`;
for (const [r, v] of Object.entries(roles)) d += `    ${dartStr(v[2])} => ideasReason${pascal(r)},\n`;
d += `    _ => null,\n  };\n\n`;
d += `  String ideaCategoryLabel(IdeaCategory category) => switch (category) {
    IdeaCategory.technique => ideasCategoryTechnique,
    IdeaCategory.colorChallenge => ideasCategoryColorChallenge,
    IdeaCategory.mood => ideasCategoryMood,
    IdeaCategory.season => ideasCategorySeason,
  };

  String ideaDifficultyLabel(IdeaDifficulty difficulty) => switch (difficulty) {
    IdeaDifficulty.easy => ideasDifficultyEasy,
    IdeaDifficulty.medium => ideasDifficultyMedium,
    IdeaDifficulty.hard => ideasDifficultyHard,
  };

  String ideaMaterialLabel(IdeaMaterial material) => switch (material) {
    IdeaMaterial.paper => ideasMaterialPaper,
    IdeaMaterial.blender => ideasMaterialBlender,
    IdeaMaterial.whiteGel => ideasMaterialWhiteGel,
    IdeaMaterial.pigmentLiner => ideasMaterialPigmentLiner,
    IdeaMaterial.pencil => ideasMaterialPencil,
    IdeaMaterial.tape => ideasMaterialTape,
  };

  /// "Pencil, masking tape." from the materials of an idea.
  String ideaMaterialsText(List<IdeaMaterial> materials) {
    if (materials.isEmpty) return '';
    final String joined = materials.map(ideaMaterialLabel).join(', ');
    return '\${joined[0].toUpperCase()}\${joined.substring(1)}.';
  }
}
`;
fs.writeFileSync(path.join(repo, 'lib/l10n/ideas_text.dart'), d);
console.log('presets', presets.length);
