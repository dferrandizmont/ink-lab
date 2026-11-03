[English](README.md) · [Español](README.es.md) · [Deutsch](README.de.md) · **Français** · [Português](README.pt.md) · [Italiano](README.it.md)

<p align="center">
  <img src="docs/readme/fr/header.png" alt="Ink Lab — Tes marqueurs, tes palettes. Gratuit et hors ligne." width="1024">
</p>

# Ink Lab

[![Code : MIT](https://img.shields.io/badge/Code-MIT-30382F)](LICENSE)
[![Contenu : CC BY-SA 4.0](https://img.shields.io/badge/Contenu-CC_BY--SA_4.0-30382F)](LICENSE-CONTENT.md)
[![Version](https://img.shields.io/github/v/release/dferrandizmont/ink-lab?include_prereleases&label=version&color=30382F)](https://github.com/dferrandizmont/ink-lab/releases)
[![Téléchargements](https://img.shields.io/github/downloads/dferrandizmont/ink-lab/total?label=t%C3%A9l%C3%A9chargements&color=30382F)](https://github.com/dferrandizmont/ink-lab/releases)
[![Ko-fi](https://img.shields.io/badge/Ko--fi-Offre--moi_un_caf%C3%A9-FF5E5B?logo=kofi&logoColor=white)](https://ko-fi.com/danielmfdev)

Compagnon de nuanciers et de palettes pour celles et ceux qui dessinent avec des
marqueurs à alcool. Retrouve le code d’une couleur, découvre quel marqueur de ta
collection se rapproche le plus d’une photo et crée des palettes selon la théorie
des couleurs, uniquement avec les marqueurs que tu possèdes. Appli Android avec
thèmes clair et sombre, barre de navigation latérale sur tablette et six
langues.

**Gratuit · Sans publicité · Sans compte · Hors ligne · Open source**

L’IA est facultative et désactivée par défaut.

## Téléchargement

<p>
  <a href="https://play.google.com/apps/testing/es.inklab.app"><img src="https://img.shields.io/badge/Google_Play-B%C3%AAta-414141?logo=googleplay&amp;style=for-the-badge" alt="Bêta sur Google Play"></a>
  <a href="https://github.com/dferrandizmont/ink-lab/releases/latest"><img src="https://img.shields.io/badge/Disponible_sur-GitHub-181717?logo=github&amp;style=for-the-badge" alt="Disponible sur GitHub"></a>
  <!--
  <a href="[APP_STORE_LINK]"><img src="https://img.shields.io/badge/App_Store-T%C3%A9l%C3%A9charger-0D96F6?logo=appstore&amp;style=for-the-badge" alt="Disponible sur l’App Store"></a>
  -->
</p>

Android sur GitHub et en test fermé sur Google Play. iOS arrivera plus tard.

<details>
<summary>Rejoindre la bêta Google Play</summary>

1. Rejoins le groupe [ink-lab-testers](https://groups.google.com/g/ink-lab-testers). Connecte-toi à Google et appuie sur « Rejoindre le groupe ».
2. Accepte le test : [play.google.com/apps/testing/es.inklab.app](https://play.google.com/apps/testing/es.inklab.app).
3. Installe l’appli depuis Google Play. Elle se met à jour toute seule.

Reste 14 jours : Google exige 12 testeurs pendant 14 jours avant la
publication. Retours : inklab@mainshai.com.

</details>

<details>
<summary>Installer l’APK depuis GitHub</summary>

1. Télécharge l’APK et `SHA256SUMS.txt` de la [dernière
   version](https://github.com/dferrandizmont/ink-lab/releases/latest). Vérifie le téléchargement avec
   `sha256sum -c SHA256SUMS.txt`.
2. Autorise l’installation depuis des sources inconnues quand le téléphone le
   demande, puis ouvre l’APK.

</details>

## Captures d’écran

<p>
  <a href="docs/readme/fr/01-swatches.png"><img src="docs/readme/fr/01-swatches.png" width="19%" alt="Nuanciers : les couleurs de la marque, chacune avec son code et son nom"></a>
  <a href="docs/readme/fr/02-swatch-detail.png"><img src="docs/readme/fr/02-swatch-detail.png" width="19%" alt="Le détail d’un marqueur : son code hex, ses alternatives proches et la même couleur dans les autres marques"></a>
  <a href="docs/readme/fr/03-match.png"><img src="docs/readme/fr/03-match.png" width="19%" alt="Une couleur touchée dans une photo, associée au marqueur le plus proche de ta collection"></a>
  <a href="docs/readme/fr/04-palette.png"><img src="docs/readme/fr/04-palette.png" width="19%" alt="Une palette de scène, avec le rôle et le code de chaque couleur"></a>
  <a href="docs/readme/fr/05-diary.png"><img src="docs/readme/fr/05-diary.png" width="19%" alt="Le journal de dessins : un résumé de tes œuvres et les dernières entrées"></a>
</p>

<details>
<summary>Plus de captures d’écran</summary>

<p>
  <a href="docs/readme/fr/06-photo-scene.png"><img src="docs/readme/fr/06-photo-scene.png" width="19%" alt="Une palette créée à partir des couleurs de ta propre photo"></a>
  <a href="docs/readme/fr/07-ideas.png"><img src="docs/readme/fr/07-ideas.png" width="19%" alt="Des idées : exercices et techniques, avec leurs palettes et tes favoris"></a>
  <a href="docs/readme/fr/08-collection.png"><img src="docs/readme/fr/08-collection.png" width="19%" alt="Ma collection : ce que tu possèdes et ce qu’il faut racheter ensuite"></a>
  <a href="docs/readme/fr/09-settings-dark.png"><img src="docs/readme/fr/09-settings-dark.png" width="19%" alt="Réglages en thème sombre"></a>
</p>

</details>

Touche une capture pour l’agrandir.

## Fonctionnalités

- **Journal de dessins.** Un suivi de ce que tu peins, avec ses photos, les
  marqueurs utilisés et les chiffres qui vont avec.
- **Quatre marques.** Ohuhu (503 couleurs), DecoTime (313), Copic (358) et
  Finecolour (480), avec le marqueur le plus proche de chaque autre marque dans
  « Dans d’autres marques ».
- **Associer.** Touche un point d’une photo pour trouver le marqueur de ta
  collection le plus proche, et corrige les blancs.
- **Palettes et scènes.** Harmonies de la théorie des couleurs, dégradés et 67
  scènes prêtes en 11 catégories.
- **Sauvegarde.** Enregistre tout dans un fichier `.zip`, avec les photos du
  journal dedans.
- **Achats.** Une liste de souhaits, les marqueurs à sec et ce qu’il faut racheter
  ensuite.

<details>
<summary>Plus de fonctionnalités</summary>

- **Vision des couleurs.** Prévisualise une palette comme la voit une personne
  atteinte de protanopie, deutéranopie, tritanopie ou achromatopsie.
- **Nuancier imprimable.** Des pages A4 avec une case étiquetée pour chaque
  marqueur que tu possèdes.
- **Idées.** Des exercices et des techniques avec leurs propres palettes, et tes
  favoris.
- **Nuanciers et ta propre couleur.** Codes, noms et valeurs hex, plus la couleur
  que ton marqueur donne vraiment.
- **Partager.** Envoie une palette, un nuancier ou une entrée du journal à une
  autre appli sous forme d’image.
- **L’IA, si tu veux.** Des suggestions de palettes en option : Gemini Nano sur
  l’appareil, ou OpenRouter avec ta propre clé.

</details>

## Confidentialité

Tes données restent sur ton téléphone : pas de compte, pas de serveur à nous, pas
d’analyse, pas de publicité ni de suivi ; sans l’IA, le réseau n’est jamais
utilisé. ML Kit de l’IA sur l’appareil envoie à Google des diagnostics
d’utilisation, jamais tes demandes, tes couleurs ni tes photos. L’accès à la
caméra et à la galerie ne sert qu’à associer des couleurs, créer des scènes,
définir ta propre couleur et ajouter des photos au journal ; ces photos sont
traitées sur l’appareil, et celles du journal restent dans le dossier privé de
l’appli et ne sont jamais envoyées. Quand tu partages une palette, un nuancier ou
la sauvegarde `.zip`, le fichier ne va qu’à l’appli que tu choisis, et nulle part
ailleurs.

[Site](https://inklab.mainshai.com/fr/) · [Politique de confidentialité](https://inklab.mainshai.com/fr/privacy/) ·
[Détails techniques](docs/privacy.en.md) · Support : **inklab@mainshai.com**.

## Nouveautés

La version 0.9.2 est sortie. La série 0.9 a mis de l’ordre dans l’appli : une
fiche de marqueur plus calme, des écrans mieux rangés et des correctifs pour les
grandes tailles de texte. La liste complète est dans [CHANGELOG.md](CHANGELOG.md)
et dans les [versions](https://github.com/dferrandizmont/ink-lab/releases).

## Contribuer

Les bugs, les idées et les traductions sont les bienvenus. Comment compiler,
tester et contribuer : [CONTRIBUTING.md](CONTRIBUTING.md).

## Licence

Code sous [MIT](LICENSE), Copyright (c) 2026 Daniel Mont Ferrandiz. Documentation
et textes du projet : [CC BY-SA 4.0](LICENSE-CONTENT.md). Les données des
catalogues sont des références factuelles de tiers et sortent des deux licences ;
les polices (SIL OFL 1.1) et les autres éléments tiers gardent leurs propres
conditions.

Un projet indépendant : **sans lien avec Ohuhu, DecoTime, Copic ou Finecolour, sans
parrainage ni approbation de leur part**. « Ohuhu », « Oahu », « DecoTime », « Copic » et « Finecolour » sont des marques de leurs propriétaires.
Mentions complètes : [NOTICE.md](NOTICE.md).

Signaler une faille : [SECURITY.md](SECURITY.md).
