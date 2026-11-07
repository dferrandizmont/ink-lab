# Politique de confidentialité d'Ink Lab


Dernière mise à jour : 2026-11-07

Traduction de courtoisie. Seule la [version espagnole](https://inklab.mainshai.com/es/privacy/) fait foi.

Ink Lab est une application destinée à celles et ceux qui dessinent avec des feutres à alcool : consultez les nuanciers,
associez la couleur d'une photo à un feutre de votre collection et créez des palettes grâce à la théorie des couleurs.
C'est une application indépendante : elle n'a été ni créée, ni examinée, ni approuvée par Ohuhu, DecoTime ou toute autre
marque.

Résumé : **vous n'avez pas de compte, il n'y a pas de serveur à nous et vos données restent sur votre téléphone.**
L'application est entièrement gratuite et open source, et ne comporte ni outil d'analyse propre, ni publicité, ni
pistage. **Si vous n'activez pas l'IA, l'application n'utilise pas le réseau.** Si vous l'activez, sur Android, l'IA sur
l'appareil utilise ML Kit de Google, qui envoie à Google des données de diagnostic et d'utilisation (jamais vos
requêtes, vos couleurs ni vos photos) ; et si vous choisissez OpenRouter avec votre propre clé, l'application envoie
exactement ce qui est expliqué plus bas.

## 1. Responsable du traitement


- Titulaire : Daniel Mont Ferrandiz
- Adresse e-mail de contact : inklab@mainshai.com

## 2. Données traitées


### Données qui restent sur votre téléphone (nous ne les recevons pas)
Votre marque active, les packs et feutres que vous possédez, vos favoris, votre liste de souhaits, le niveau d'encre de
vos feutres (plein, bientôt vide ou sec) et vos notes de recharge, les photos de vos échantillons réels, les couleurs
personnelles que vous enregistrez pour vos feutres, vos palettes enregistrées, vos recettes de mélange et leurs photos,
l'historique de vos derniers choix lors de l'association de couleurs, les entrées et les photos de votre journal, vos
idées favorites et vues récemment, vos réglages, l'étape de l'accueil où vous vous êtes arrêté, la date de votre dernier
fichier de sauvegarde et l'historique des erreurs (voir ci-dessous) sont enregistrés uniquement dans l'espace de
stockage privé de l'application, sur votre appareil. Pour chaque couleur personnelle, seul son code hexadécimal est
enregistré, jamais la photo dont vous l'avez tirée. Les catalogues des 15 marques de feutres (Ohuhu, DecoTime, Copic,
Finecolour, Touch Twin, Promarker, Promarker Brush, Prismacolor Premier, Spectrum Noir, Arrtx, ZIG Kurecolor, Graph'it,
Marvy Le Plume, Blick Studio Brush et Artist's Loft) sont inclus dans l'application et tout fonctionne hors connexion.
« Dans d’autres marques », « Ombre et lumière », « Mélanger avec… » et l'avertissement sur les feutres presque
identiques (dans le détail d'un feutre), la recherche par code hexadécimal, la vue « Valeurs » en niveaux de gris,
l'aperçu « Vision des couleurs » (dans « Palette »), la « Carte des couleurs » et la traduction de recettes (dans « Ma
collection » → « Outils ») et les « Chiffres du journal » sont calculés sur votre téléphone à partir de ces catalogues et
de vos données, sans rien envoyer. Il n'y a ni synchronisation ni copie sur aucun de nos serveurs.

La sauvegarde système d'Android est **désactivée** pour cette application : elle exclut tous les fichiers de
l'application de la sauvegarde dans le cloud et du transfert entre appareils, de sorte que ni vos réglages, ni votre
clé, ni vos données, ni vos photos, ni l'historique des erreurs ne quittent le téléphone par ce biais. Sur
iPhone, les préférences, le journal, les recettes de mélange, les photos conservées par l'application et l'historique
des erreurs peuvent faire partie de la sauvegarde de l'appareil ou d'iCloud que vous gérez avec votre compte Apple : c'est un mécanisme d'Apple, sous votre contrôle, et non
un transfert effectué par le développeur.

### Appareil photo et galerie
Ce n'est que lorsque vous utilisez « Associer », « À partir d’une photo » (dans « Palette ») ou « Ma couleur » (dans
le détail d'un feutre), ou que vous ajoutez une photo à une entrée du « Journal » (dans « Idées »), à l'« Échantillon
réel » d'un feutre ou à une recette de mélange, et que vous choisissez de prendre une photo ou d'en choisir une dans la
galerie que l'application demande l'autorisation ou ouvre le sélecteur du système. La photo est décodée et analysée
**sur votre téléphone** : elle n'est envoyée nulle part et n'est jamais transmise à un fournisseur d'IA ; sauf dans le
journal, l'échantillon réel et les recettes (voir ci-dessous), elle n'est pas enregistrée non plus. Dans « Associer », seuls la couleur échantillonnée et le feutre associé sont conservés, dans votre historique
local. Dans « À partir d’une photo », ses couleurs principales sont extraites pour vous proposer des feutres de votre
collection ; la photo n'est conservée en mémoire que pendant que vous consultez le résultat et, si vous enregistrez la
palette, ce sont les codes des feutres qui sont enregistrés, jamais la photo. Dans « Ma couleur », vous touchez
l'échantillon peint sur la photo et seule sa couleur est enregistrée, sous forme de code hexadécimal, jamais la photo.

### Journal
Dans l'onglet « Idées », « Journal » vous permet de consigner les œuvres que vous peignez : titre, date, support,
statut, feutres utilisés, palette liée et notes. Les entrées sont enregistrées sur votre téléphone comme le reste de
vos données. Chaque entrée peut contenir jusqu'à 4 photos, prises avec l'appareil photo ou choisies dans la galerie,
que l'application copie en taille réduite (2048 pixels de côté au maximum) dans son dossier privé ; la photo d'origine
de votre galerie n'est pas modifiée. Ces photos ne sont envoyées nulle part ni transmises aux fonctions d'IA (ni à
OpenRouter, ni à Gemini Nano, ni à ML Kit), et elles sont supprimées lorsque vous retirez la photo ou l'entrée, et avec
l'application lorsque vous la désinstallez. « Partager cette entrée » dessine, uniquement lorsque vous le touchez, une
image avec le titre, la date, le statut, la première photo, les feutres utilisés et les couleurs de la palette liée,
et ne la remet qu'à l'application que vous choisissez dans le menu de partage du système.

### Échantillons réels, niveau d'encre et recettes de mélange
Dans le détail d'un feutre que vous possédez, vous pouvez indiquer son niveau d'encre (plein, bientôt vide ou sec),
écrire une note de recharge de 80 caractères au maximum et ajouter une photo de votre échantillon réel sur papier, que
l'application copie en taille réduite (environ 1024 pixels de côté) dans son dossier privé. Dans « Ma collection » →
« Outils », vous pouvez conserver vos propres recettes de mélange (nom, feutres, notes et une photo facultative, réduite
à 2048 pixels de côté au maximum). Tout cela reste sur votre téléphone : les photos ne sont envoyées nulle part ni
transmises aux fonctions d'IA, elles sont supprimées lorsque vous les retirez ou supprimez la recette, et avec
l'application lorsque vous la désinstallez. Elles ne quittent le téléphone que si vous enregistrez un fichier de
sauvegarde (voir ci-dessous) et l'envoyez quelque part.

### Partager en texte
« Partager en texte » (dans « Palette »), l'export de votre collection en CSV ou en texte et la recette traduite (dans
« Outils ») préparent un texte avec les feutres (la marque, les codes et, selon le cas, les noms, les couleurs et s'ils
sont secs) et, uniquement lorsque vous le touchez, le remettent à l'application que vous choisissez dans le menu de
partage du système ou le copient dans le presse-papiers. « Importer depuis un texte » et l'import de codes ne lisent que
le texte que vous collez ou saisissez ; ils n'ouvrent aucun lien et ne se connectent à rien.

### Avis sur la boutique
Une seule fois, après l'enregistrement de votre troisième palette ou de votre première entrée du journal,
l'application demande au système d'afficher la fenêtre d'avis de la boutique (Google Play sur Android, App Store sur
iPhone). C'est la boutique qui décide de l'afficher et qui reçoit votre avis si vous en écrivez un, selon ses propres
conditions ; Ink Lab ne reçoit ni la note ni le texte, ne sait pas si vous avez laissé un avis et n'envoie rien. Sur
Android, il s'agit d'un échange interne au téléphone avec l'application Google Play. L'application note seulement, sur
votre téléphone, qu'elle a déjà fait la demande, pour ne pas la refaire, et abandonne si la boutique ne peut pas
afficher la fenêtre à trois reprises.

### Mode chevalet et raccourcis
Le mode chevalet (dans « Palette ») affiche la palette en grand et garde l'écran allumé tant qu'il est ouvert ; une fois
fermé, l'écran se remet en veille normalement. Il ne demande aucune autorisation et n'enregistre ni n'envoie aucune
donnée. Les raccourcis de l'écran d'accueil (appui long sur l'icône sur Android, actions rapides sur iPhone) ouvrent
seulement « Associer une couleur », « Nouvelle palette » ou « Chercher un nuancier » : ils ne contiennent aucune de vos
données.

### Sauvegarde
« Exporter » (Réglages → Sauvegarde) génère un texte JSON, et non un fichier, contenant vos réglages, les réglages non
secrets de l'IA, votre collection, favoris, liste de souhaits, feutres secs, niveaux d'encre et notes de recharge,
couleurs personnelles, palettes, historique, idées favorites et vues récemment, les entrées du journal et vos recettes
de mélange (avec les noms de fichier internes de leurs photos et des photos de vos échantillons, pas les photos), et le **copie dans le presse-papiers** pour que vous le colliez où vous le souhaitez ;
« Importer » le reçoit par collage. Lors de l'importation, la sauvegarde remplace vos données actuelles, journal
compris : les entrées qui n'y figurent pas sont supprimées avec leurs photos, et l'application vous en avertit avant.
La sauvegarde n'est pas chiffrée, ne contient aucun identifiant et n'inclut jamais votre clé d'API ni aucune photo. Ce que vous en faites ensuite (l'enregistrer dans votre cloud, l'envoyer dans un message...) se fait en
dehors de l'application. Sachez que, selon votre système, le presse-papiers peut être visible par votre clavier ou par
d'autres applications.

« Partager la sauvegarde » (Réglages → Tes données → Fichier de sauvegarde) crée un fichier ZIP avec cette même
sauvegarde et, en plus, les photos de votre journal, de vos échantillons réels et de vos recettes de mélange, l'écrit dans le dossier temporaire (cache) de l'application et ouvre le
menu de partage du système pour que vous l'enregistriez dans Fichiers, Drive ou l'application de votre choix : il ne va
que là où vous l'envoyez, et l'application supprime les fichiers de sauvegarde précédents de ce dossier lorsqu'elle
crée le suivant. « Restaurer depuis un fichier » ouvre le sélecteur de documents du système, qui n'a besoin d'aucune
autorisation (le sélecteur laisse une copie du fichier choisi dans le cache de l'application, et l'application la
supprime une fois terminé) ; le fichier est vérifié en entier avant d'écrire quoi que ce soit et l'application vous
demande confirmation, car elle remplace vos données actuelles, photos comprises, et supprime les photos qui ne sont pas
dans le fichier. Aucune sauvegarde, ni celle du presse-papiers ni le fichier, n'inclut votre clé d'API.

L'application mémorise en outre, uniquement sur votre téléphone, la date à laquelle vous avez enregistré un fichier de
sauvegarde pour la dernière fois, afin de vous l'afficher et de vous suggérer une nouvelle sauvegarde lorsque plus de 30
jours se sont écoulés. Cette date ne fait partie d'aucune sauvegarde.

### Historique des erreurs
Si l'application rencontre une erreur inattendue, elle écrit une courte entrée dans un fichier de son espace de stockage
privé, sur votre téléphone, afin que le problème puisse être localisé et corrigé. Chaque entrée contient l'heure, la
version de l'application, la plateforme et la version du système, l'endroit de l'application où l'erreur a été
interceptée, la première ligne du message d'erreur (300 caractères au maximum) et une trace technique abrégée du code
(pile d'appels). Avant d'enregistrer une entrée, l'application remplace les paramètres des adresses web, les jetons et
les clés, les adresses e-mail ainsi que les noms de dossiers qui permettent d'identifier l'application ou l'utilisateur
de l'appareil. L'historique est destiné à des informations techniques, non à vos contenus ; un message d'erreur peut
toutefois contenir à l'occasion un fragment de ce que l'application traitait à ce moment-là. Le fichier est limité à
environ 200 Ko et un seul fichier précédent est conservé ; les entrées plus anciennes sont supprimées. L'historique **ne
quitte jamais votre téléphone de lui-même** : rien n'est envoyé en ligne et l'application n'utilise aucun service de
rapports de plantage. Dans Réglages → À propos, « Partager l’historique des erreurs » remet le fichier, uniquement
lorsque vous le touchez, à l'application que vous choisissez dans le menu de partage du système, et il ne va que là où
vous l'envoyez ; « Effacer l’historique des erreurs » le supprime, ainsi que le fichier précédent. Sur Android, il est
exclu de la sauvegarde dans le cloud et du transfert entre appareils, comme le reste des données de l'application ; sur
iPhone, il peut faire partie de la sauvegarde de l'appareil ou d'iCloud, comme le reste des données de l'application.

### IA facultative
Elle est **désactivée par défaut** (Réglages → Assistant IA → Suggérer avec l’IA). Lorsqu'elle est désactivée,
l'application n'ouvre aucune connexion réseau et n'appelle pas ML Kit. Si vous l'activez, l'application vous montre
d'abord ce qui quitterait le téléphone, et vous pouvez choisir entre :

- **Théorie des couleurs (moteur local) :** sans IA et sans réseau.
- **Sur l'appareil (Gemini Nano, sur les appareils Android compatibles, via ML Kit de Google) :** votre scénario et les
  codes de couleur sont traités sur votre téléphone et ne sont envoyés nulle part. Lorsque vous activez l'IA,
  l'application utilise ML Kit pour vérifier si Gemini Nano est disponible et, si vous choisissez cette option, pour le
  télécharger et générer les suggestions. Lors de son utilisation, **ML Kit envoie à Google**, via HTTPS et par lots
  (environ une fois par jour), des données de diagnostic et d'utilisation : des informations sur l'appareil (fabricant,
  modèle, version et build du système), sur l'application (nom du paquet et version), des identifiants de l'appareil et
  d'autres identifiants, y compris des identifiants propres à chaque installation, des mesures de performances, la
  configuration de l'API, la taille des données d'entrée et de sortie, la version de la fonctionnalité, le type
  d'événement, des codes d'erreur et les langues configurées. Google indique les utiliser à des fins de diagnostic et
  d'analyse d'utilisation et ne pas les transférer à des tiers
  (https://developers.google.com/ml-kit/android-data-disclosure). Cet envoi ne comprend pas le contenu de vos requêtes,
  vos couleurs ni vos photos, seulement leur taille. Le développeur ne reçoit pas ces données : Google les traite selon
  ses propres conditions et sa politique de confidentialité (https://policies.google.com/privacy). Si le modèle n'est
  pas sur le téléphone, Android le télécharge une seule fois via les services Google ; ce téléchargement et le modèle
  sont régis par les conditions de Google. Sur iPhone, ML Kit n'est pas utilisé : l'IA sur l'appareil y est Apple
  Intelligence (voir le point suivant).
- **Sur l'iPhone (Apple Intelligence, sous iOS 26 ou ultérieur sur un iPhone compatible) :** votre scénario et vos codes
  couleur sont traités sur votre téléphone par le modèle d'Apple fourni avec Apple Intelligence, via le framework
  Foundation Models d'Apple. L'application ne télécharge pas le modèle (iOS l'installe et le gère), n'utilise aucun autre
  service pour cette option et n'envoie rien : ni vos demandes, ni vos couleurs, ni vos photos.
- **OpenRouter avec votre clé :** uniquement si vous choisissez OpenRouter, enregistrez votre clé et touchez « Suggérer
  avec l’IA » dans « Palette », l'application envoie, **depuis votre téléphone directement à `openrouter.ai`, via HTTPS,
  avec votre propre clé et votre propre compte** : la marque (identifiant et nom), le mode de palette, le nom de la
  scène (en anglais), le code et le nom du feutre de base (le cas échéant) et s'il est verrouillé, la taille de la
  palette, les codes et les couleurs hexadécimales du catalogue des feutres candidats de votre collection (pas leurs
  noms), les paramètres de génération (modèle, température et limite de longueur), des instructions fixes de
  l'application et l'en-tête `X-Title: Ink Lab`. Pour vous montrer les modèles disponibles, l'application consulte le
  catalogue d'OpenRouter (avec votre clé, si vous l'avez enregistrée). Ne sont **jamais** envoyés : les photos (la
  requête indique qu'aucune image n'est jointe et l'application n'a aucun moyen d'en joindre une), vos couleurs
  personnelles, vos favoris, vos palettes enregistrées ni vos identifiants. Comme pour toute connexion à Internet,
  OpenRouter et le fournisseur du modèle voient l'adresse IP de votre appareil. Ils reçoivent cette requête et
  appliquent **leurs propres** conditions et politiques de confidentialité, y compris quant à sa durée de conservation,
  que vous pouvez consulter sur https://openrouter.ai/privacy. Le développeur ne la voit pas, elle ne transite par aucun
  de ses serveurs et l'application ne l'enregistre pas.

Votre clé OpenRouter est conservée dans le stockage sécurisé du système (Android Keystore ou trousseau iOS, uniquement
sur cet appareil). Elle n'est pas transmise au développeur, n'est pas incluse dans les sauvegardes et vous pouvez la
supprimer à tout moment dans « Réglages ». Si l'IA échoue, l'application revient à la théorie des couleurs.

### Autorisations
L'application ne demande l'autorisation d'accès à l'**appareil photo ou aux photos** que lorsque vous utilisez «
Associer », « À partir d’une photo » ou « Ma couleur », ou que vous ajoutez une photo au « Journal », à un échantillon
réel ou à une recette de mélange. Sur Android, elle
déclare l'accès à **Internet** et à l'**état du réseau** (`INTERNET` et `ACCESS_NETWORK_STATE`), qui ne sont utilisés
qu'avec l'IA activée : pour l'IA facultative avec OpenRouter et pour les diagnostics que ML Kit envoie à Google lorsque
l'IA sur l'appareil est utilisée. Elle ne demande ni la localisation, ni les contacts, ni l'agenda, ni le micro, ni les
notifications, et n'utilise pas l'identifiant publicitaire. Si vous partagez une palette, un nuancier ou une entrée du
journal sous forme d'image, un fichier de sauvegarde ou l'historique des erreurs, il n'est remis qu'à l'application que
vous choisissez dans le menu de partage du système ; l'application n'a besoin d'aucune autorisation pour cela, ni pour
choisir un fichier de sauvegarde avec le sélecteur du système. Le mode chevalet, les raccourcis et l'avis sur la
boutique ne demandent aucune autorisation. Sur iPhone, le manifeste de confidentialité de l'application indique, comme
Apple l'exige, qu'une bibliothèque utilisée par l'application (pour lire sa propre version) peut consulter la date des
fichiers ; elle ne le fait que pour les fichiers de l'application elle-même, dans son espace privé (motif C617.1), et
ces informations ne quittent pas le téléphone.

### Données qui NE sont PAS traitées
- Nous ne demandons ni ne conservons votre nom, votre adresse e-mail, votre numéro de téléphone, votre âge ni aucune
  donnée de compte : il n'y a pas de comptes.
- Le développeur n'utilise ni outil d'analyse ni rapports de plantage, et il n'y a ni publicité, ni publicité
  personnalisée, ni pistage entre applications. La seule exception concerne les données de diagnostic et d'utilisation
  que ML Kit envoie à Google lorsque vous utilisez l'IA sur l'appareil (voir « IA facultative ») ; le développeur ne les
  reçoit pas.
- L'historique des erreurs (voir « Historique des erreurs ») n'est pas un rapport de plantage : rien n'est envoyé
  automatiquement, et il ne quitte votre téléphone que si vous le partagez vous-même.
- Nous ne recevons ni vos photos, ni vos collections, ni vos palettes, ni votre clé.

### Si vous nous écrivez
Vous pouvez nous écrire à inklab@mainshai.com. Nous traiterons votre adresse e-mail et ce que vous nous communiquez
uniquement pour vous répondre. Ne nous envoyez ni votre clé d'API ni des sauvegardes contenant des données que vous ne
souhaitez pas partager : pour un bug, des données de test nous suffisent.

Si vous signalez une suggestion de l'IA (« Signaler cette suggestion », dans « Palette »), l'application ouvre votre
application de messagerie avec un message déjà rédigé à l'adresse inklab@mainshai.com : le motif que vous choisissez, la
version de l'application, le fournisseur et le modèle d'IA, la marque, le mode ou la scène, le code du feutre de base
ainsi que les codes, rôles et justifications de cette suggestion. Il n'inclut jamais votre clé d'API ni de photos. Il ne
nous parvient que si vous l'envoyez, et nous l'utilisons pour examiner le contenu signalé et améliorer les suggestions.
S'il n'y a pas d'application de messagerie, le rapport est copié dans le presse-papiers pour que vous le colliez
vous-même.

« Envoyer un retour » (Réglages → À propos) ouvre votre application de messagerie avec un message adressé à
inklab@mainshai.com, qui indique déjà la version de l'application, la plateforme et la version du système et vous laisse
de la place pour écrire. Rien n'est envoyé tant que vous n'envoyez pas vous-même l'e-mail, et l'historique des erreurs
n'y est pas joint. S'il n'y a pas d'application de messagerie, l'adresse est copiée dans le presse-papiers. Si vous nous
envoyez l'historique des erreurs, nous ne l'utilisons que pour localiser et corriger l'erreur.

## 3. Finalités et base juridique


| Traitement | Finalité | Base juridique (RGPD) |
|---|---|---|
| Collections, niveau d'encre et notes, liste de souhaits, couleurs personnelles, favoris, palettes, recettes de mélange, journal et réglages sur votre téléphone | Vous permettre d'utiliser l'application et de conserver votre travail | Nous ne les recevons pas : ces données restent sur votre appareil, sous votre contrôle |
| Photo de « Associer », de « À partir d’une photo », de « Ma couleur », du « Journal », d'un échantillon réel ou d'une recette de mélange | Trouver les feutres les plus proches, lire la couleur de votre échantillon ou conserver la photo d'une œuvre, d'un échantillon ou d'une recette | Traitée (et, dans le journal, l'échantillon réel et les recettes, enregistrée) uniquement sur votre téléphone, à votre demande ; nous ne la recevons pas |
| Historique des erreurs sur votre téléphone | Localiser et corriger les erreurs de l'application | Conservé uniquement sur votre téléphone ; nous ne le recevons pas. Si vous choisissez de nous l'envoyer : votre demande et notre intérêt légitime à corriger l'erreur (art. 6, paragraphe 1, point f)) |
| Diagnostics de ML Kit (uniquement avec l'IA sur l'appareil, sur Android) | Diagnostic et analyse d'utilisation du SDK, selon Google | Envoyés uniquement si vous décidez d'activer l'IA facultative ; Google les traite en tant que fournisseur de ML Kit, selon ses propres conditions et sa politique de confidentialité ; nous ne les recevons pas |
| IA avec OpenRouter (facultative) | Générer des suggestions de palette | Votre consentement lorsque vous l'activez et utilisez votre propre clé ; le traitement est effectué par OpenRouter selon ses conditions |
| E-mails d'assistance, retours et signalements de suggestions de l'IA | Répondre à votre demande et examiner le contenu signalé | Votre demande et notre intérêt légitime à y donner suite (art. 6, paragraphe 1, point f)) |

Nous ne prenons aucune décision automatisée et n'établissons aucun profil vous concernant.

## 4. Destinataires des données
L'application ne transmet aucune donnée au développeur. Si vous activez l'IA, sur Android, **Google** reçoit les données
de diagnostic et d'utilisation que ML Kit envoie lorsque l'IA sur l'appareil est utilisée. Si vous utilisez l'IA avec
OpenRouter, la requête décrite ci-dessus est reçue par **OpenRouter** et par le **fournisseur du modèle** que vous
choisissez, en votre nom et avec votre clé. Si vous nous envoyez un e-mail d'assistance, un retour, un signalement de
suggestion ou l'historique des erreurs, le titulaire le reçoit à l'adresse inklab@mainshai.com (ou à dev@mainshai.com,
l'adresse utilisée par l'application jusqu'à la version 0.6.2) via le service de votre choix. Si vous partagez
l'historique des erreurs avec une autre personne ou un autre service, seul ce destinataire le reçoit. Si vous écrivez un
avis dans la fenêtre de la boutique, c'est **Google** ou **Apple** qui le reçoit directement, pas l'application.

## 5. Transferts internationaux
Le développeur n'effectue aucun transfert de données. Si vous utilisez l'IA avec OpenRouter, la requête est adressée au
fournisseur que vous choisissez, qui peut la traiter dans d'autres régions et selon ses propres conditions. Google peut
traiter les diagnostics de ML Kit dans d'autres pays, selon ses propres conditions. Les autres services que vous décidez
d'utiliser (messagerie, cloud, destination d'un texte copié ou d'un fichier ou d'une image partagés) sont régis par
leurs propres conditions.

## 6. Durée de conservation


- **Données sur votre téléphone :** jusqu'à ce que vous désinstalliez l'application ou effaciez ses données depuis les
  réglages du système (et, le cas échéant, les textes ou fichiers de sauvegarde que vous avez conservés). Les photos du
  journal, des échantillons et des recettes sont en outre supprimées dès que vous retirez la photo, l'entrée ou la
  recette.
- **Historique des erreurs :** sur votre téléphone, jusqu'à ce que vous l'effaciez avec « Effacer l’historique des
  erreurs », que vous effaciez les données de l'application ou que vous la désinstalliez. Comme il ne dépasse jamais
  environ 200 Ko plus un fichier précédent, les entrées les plus anciennes sont supprimées au fur et à mesure.
- **E-mails d'assistance, retours et historiques des erreurs que vous nous envoyez :** le temps nécessaire pour traiter
  votre demande et, au maximum, un an à compter de la dernière réponse.

## 7. Vos droits


Vous pouvez exercer vos droits d'**accès, de rectification, d'effacement, d'opposition, de limitation du traitement et
de portabilité** en écrivant à inklab@mainshai.com. Nous vous répondrons dans un délai d'un mois.

Nous ne recevons pas les données enregistrées sur votre téléphone : nous ne pouvons donc ni les consulter ni les
supprimer pour vous. Vous pouvez les supprimer en désinstallant l'application ou en effaçant ses données depuis les
réglages du système, et les emporter avec « Exporter » (Réglages → Sauvegarde ; les photos ne font pas partie de ce
texte) ou avec « Partager la sauvegarde » (qui les inclut). Pour ce que vous avez envoyé à OpenRouter,
exercez vos droits auprès d'OpenRouter et du
fournisseur du modèle ; pour les diagnostics de ML Kit, auprès de Google.

Si vous estimez que nous n'avons pas traité correctement vos données, vous pouvez introduire une réclamation auprès de
l'autorité espagnole de protection des données (Agencia Española de Protección de Datos) : https://www.aepd.es

## 8. Mineurs


L'application ne s'adresse pas aux enfants de moins de 13 ans (ou de l'âge minimum équivalent dans votre pays). Elle ne
demande pas l'âge et ne collecte de données personnelles auprès de personne, y compris des mineurs : il n'y a pas de
comptes et vos données restent sur l'appareil. L'IA avec OpenRouter nécessite un compte personnel auprès d'un tiers, que
les mineurs ne doivent pas créer sans l'autorisation de leurs parents ou tuteurs.

## 9. Sécurité
Il n'y a ni serveur du développeur ni transmission de données depuis l'application, sauf lorsque l'IA facultative est
activée. Vos données se trouvent dans l'espace privé de l'application ; votre clé, dans le Keystore ou le trousseau ;
les connexions à OpenRouter utilisent HTTPS et ne suivent pas les redirections. La protection de votre téléphone
(verrouillage de l'écran, chiffrement, ni root ni jailbreak) vous incombe. Le code est public et chacun peut vérifier ce
qu'il fait.

## 10. Modifications de cette politique


Si ce que fait l'application avec les données change, nous mettrons à jour cette page et la date indiquée en haut. Si le
changement est important (par exemple, si une fonctionnalité envoyait des données hors du téléphone), nous vous
l'indiquerons également dans l'application et elle ne serait activée qu'avec votre consentement.

## 11. Contact


inklab@mainshai.com
