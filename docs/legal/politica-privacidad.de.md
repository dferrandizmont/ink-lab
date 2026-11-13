# Datenschutzerklärung von Ink Lab


Zuletzt aktualisiert: 2026-11-13

Unverbindliche Übersetzung. Maßgeblich ist die [spanische Fassung](https://inklab.mainshai.com/es/privacy/).

Ink Lab ist eine App für Menschen, die mit Alkoholmarkern zeichnen: Sie können Farbmuster ansehen, die Farbe eines Fotos
einem Marker Ihrer Sammlung zuordnen und Paletten mit Farbtheorie erstellen. Es ist eine unabhängige App: Sie wurde
weder von Ohuhu, DecoTime noch einer anderen Marke erstellt, geprüft oder unterstützt.

Zusammenfassung: **Sie haben kein Konto, es gibt keinen eigenen Server, und Ihre Daten bleiben auf Ihrem Handy.** Die
App ist vollständig kostenlos und quelloffen und enthält keine eigene Analyse, keine Werbung und kein Tracking. **Wenn
Sie die KI nicht aktivieren, nutzt die App das Netzwerk nicht.** Wenn Sie sie aktivieren, verwendet die KI auf dem Gerät
unter Android ML Kit von Google, das Diagnose- und Nutzungsdaten an Google sendet (niemals Ihre Anfragen, Ihre Farben
oder Ihre Fotos); und wenn Sie OpenRouter mit Ihrem eigenen Schlüssel wählen, wird genau das gesendet, was weiter unten
erläutert wird.

## 1. Verantwortlicher


- Inhaber: Daniel Mont Ferrandiz
- Kontakt-E-Mail: inklab@mainshai.com

## 2. Welche Daten verarbeitet werden


### Daten, die auf Ihrem Handy bleiben (wir erhalten sie nicht)
Ihre aktive Marke, die Packs und Marker, die Sie besitzen, Ihre Favoriten, Ihre Wunschliste, der Tintenstand Ihrer
Marker (voll, fast leer oder ausgetrocknet) und Ihre Nachfüll-Notizen, die Fotos Ihrer echten Farbproben, die eigenen
Farben, die Sie für Ihre Marker speichern, Ihre gespeicherten Paletten, Ihre Mischrezepte und deren Fotos, der Verlauf
Ihrer letzten Auswahlen beim Farbabgleich, die Einträge und Fotos Ihres Tagebuchs, Ihre Favoriten und zuletzt
angesehenen Ideen, Ihre Einstellungen, wie weit Sie in der Einführung gekommen sind, das Datum Ihrer letzten
Sicherungsdatei, die Zähler für die Bewertung im Store und das Fehlerprotokoll (siehe unten) werden ausschließlich im
privaten Speicher der App auf Ihrem Gerät gespeichert. Von jeder eigenen Farbe wird nur ihr Hex-Code gespeichert,
niemals das Foto, aus dem Sie sie entnommen haben. Die Kataloge der 15 Markermarken (Ohuhu, DecoTime, Copic, Finecolour,
Touch Twin, Promarker, Promarker Brush, Prismacolor Premier, Spectrum Noir, Arrtx, ZIG Kurecolor, Graph'it, Marvy Le
Plume, Blick Studio Brush und Artist's Loft) sind in der App enthalten, und alles funktioniert ohne Verbindung. „In
anderen Marken“, „Schatten und Licht“, „Mischen mit …“ und der Hinweis auf fast gleiche Marker (in der Detailansicht
eines Markers), die Hex-Suche, die Graustufenansicht „Tonwerte“, die Vorschau „Farbsehen“ (in „Palette“), die
„Farbkarte“ und die Rezept-Übersetzung (unter „Meine Sammlung“ → „Werkzeuge“) sowie die „Zahlen des Tagebuchs“ werden
auf Ihrem Handy aus diesen Katalogen und Ihren Daten berechnet, ohne etwas zu senden. Es gibt keine Synchronisierung und
keine Kopie auf einem unserer Server.

Die Systemsicherung von Android ist für diese App **deaktiviert**: Sie schließt alle Dateien der App von der
Cloud-Sicherung und von der Übertragung zwischen Geräten aus, sodass weder Ihre Einstellungen noch Ihr Schlüssel, Ihre
Daten, Ihre Fotos oder das Fehlerprotokoll auf diesem Weg das Handy verlassen. Auf dem iPhone können die
Einstellungen, das Tagebuch, die Mischrezepte, die von der App gespeicherten Fotos und das Fehlerprotokoll Teil der
Geräte- oder iCloud-Sicherung sein, die Sie mit Ihrem
Apple-Account verwalten: Das ist ein Mechanismus von Apple unter Ihrer Kontrolle, keine Übermittlung durch den
Entwickler.

### Kamera und Galerie
Nur wenn Sie „Abgleich“, „Aus einem Foto“ (in „Palette“) oder „Meine Farbe“ (in der Detailansicht eines Markers)
verwenden oder einem Eintrag im „Tagebuch“ (unter „Ideen“), der „Echten Farbprobe“ eines Markers oder einem Mischrezept
ein Foto hinzufügen und ein Foto aufnehmen oder eines aus der Galerie auswählen, fragt die App nach der Berechtigung
oder öffnet die Auswahl des Systems. Das Foto wird **auf Ihrem Handy** dekodiert und analysiert: Es wird nirgendwohin
hochgeladen und niemals an einen KI-Anbieter gesendet; außer im Tagebuch, bei der echten Farbprobe und bei den Rezepten
(siehe unten) wird es auch nicht gespeichert. Bei „Abgleich“ werden von der Auswahl nur die
abgetastete Farbe und der zugeordnete Marker in Ihrem lokalen Verlauf aufbewahrt. Bei „Aus einem Foto“ werden die
Hauptfarben des Fotos ermittelt, um Ihnen Marker aus Ihrer Sammlung vorzuschlagen; das Foto wird nur im
Arbeitsspeicher gehalten, solange Sie das Ergebnis ansehen, und wenn Sie die Palette speichern, werden die Codes der
Marker gespeichert, niemals das Foto. Bei „Meine Farbe“ tippen Sie auf das gemalte Farbmuster im Foto, und nur seine
Farbe wird als Hex-Code gespeichert, niemals das Foto.

### Tagebuch
Im Tab „Ideen“ können Sie unter „Tagebuch“ die Werke festhalten, die Sie malen: Titel, Datum, worauf Sie gemalt haben,
Status, verwendete Marker, verknüpfte Palette und Notizen. Die Einträge werden wie Ihre übrigen Daten auf Ihrem Handy
gespeichert. Jeder Eintrag kann bis zu 4 Fotos enthalten, mit der Kamera aufgenommen oder aus der Galerie ausgewählt;
die App kopiert sie verkleinert (höchstens 2048 Pixel Seitenlänge) in ihren privaten Ordner, das Originalfoto in Ihrer
Galerie bleibt unverändert. Diese Fotos werden nirgendwohin hochgeladen und nicht an die KI-Funktionen gesendet (weder
an OpenRouter noch an Gemini Nano oder ML Kit); sie werden gelöscht, wenn Sie das Foto oder den Eintrag entfernen, und
zusammen mit der App, wenn Sie diese deinstallieren. „Diesen Eintrag teilen“ zeichnet nur dann, wenn Sie darauf
tippen, ein Bild mit Titel, Datum, Status, dem ersten Foto, den verwendeten Markern und den Farben der verknüpften
Palette und übergibt es ausschließlich an die App, die Sie im Teilen-Menü des Systems auswählen.

### Echte Farbproben, Tintenstand und Mischrezepte
In der Detailansicht eines Markers, den Sie besitzen, können Sie den Tintenstand festlegen (voll, fast leer oder
ausgetrocknet), eine Nachfüll-Notiz mit bis zu 80 Zeichen schreiben und ein Foto Ihrer echten Farbprobe auf Papier
hinzufügen; die App kopiert es verkleinert (etwa 1024 Pixel Seitenlänge) in ihren privaten Ordner. Unter „Meine
Sammlung“ → „Werkzeuge“ können Sie eigene Mischrezepte anlegen (Name, Marker, Notizen und ein optionales Foto,
verkleinert auf höchstens 2048 Pixel Seitenlänge). All das bleibt auf Ihrem Handy: Die Fotos werden nirgendwohin
hochgeladen und nicht an die KI-Funktionen gesendet; sie werden gelöscht, wenn Sie sie entfernen oder das Rezept
löschen, und zusammen mit der App, wenn Sie diese deinstallieren. Sie verlassen das Handy nur, wenn Sie eine
Sicherungsdatei speichern (siehe unten) und sie irgendwohin senden.

### Als Text teilen
„Als Text teilen“ (in „Palette“), der Export Ihrer Sammlung als CSV oder Text und das übersetzte Rezept (unter
„Werkzeuge“) erstellen einen Text mit den Markern (Marke, Codes und je nach Fall Namen, Farben und ob sie ausgetrocknet
sind) und übergeben ihn nur dann, wenn Sie darauf tippen, an die App, die Sie im Teilen-Menü des Systems auswählen,
oder kopieren ihn in die Zwischenablage. „Aus Text importieren“ und der Import von Codes lesen nur den Text, den Sie
einfügen oder eintippen; sie öffnen keine Links und stellen keine Verbindung her.

### Bewertung im Store
Ab und zu, nachdem Sie eine Palette oder einen neuen Tagebucheintrag gespeichert haben, kann Ink Lab den Store (Google
Play unter Android, den App Store auf iPhone und iPad) bitten, Ihnen sein Fenster zum Bewerten der App zu zeigen. In der
ersten Woche, während einer Wiederherstellung oder direkt nach dem Wiederherstellen oder Importieren einer Sicherung
fragt die App nicht, und insgesamt fragt sie höchstens dreimal (höchstens einmal pro Version und mit mindestens 90 Tagen
Abstand); **ob das Fenster erscheint, entscheidet der Store**. Für die Bitte um das Fenster nutzt die App unter Android
die Bewertungsbibliothek von Google Play (ein interner Austausch auf dem Handy mit der Google-Play-App) und auf iPhone
und iPad die Funktion des Systems. **Ink Lab teilt dem Store nur mit, um welche App es geht:** Die App gibt weder Ihre
Paletten noch Ihre Sammlung oder andere Daten von Ihnen weiter und erfährt nicht, ob Sie bewertet haben oder was Sie
geschrieben haben. Ihre Bewertung und Ihre Rezension schreiben Sie im Fenster des Stores, und **sie gehen an Google oder
Apple, mit Ihrem Store-Konto** und nach deren eigenen Bedingungen. Sie können die Seite von Ink Lab im Store auch
jederzeit mit „Ink Lab bewerten“ (Optionen → Info) öffnen.

Um zu entscheiden, wann sie fragt, speichert die App auf Ihrem Handy einige Zähler: den Tag, an dem Sie sie zum ersten
Mal geöffnet haben, den letzten Tag, an dem Sie sie geöffnet haben, an wie vielen verschiedenen Tagen Sie sie geöffnet
haben, wie oft sie um eine Bewertung gebeten hat, Tag und Version der letzten Bitte und wie oft der Store das Fenster
nicht anzeigen konnte (nach dem dritten Mal versucht sie es nicht mehr). Es sind nur Daten und Zählungen: Die Zähler
enthalten nichts darüber, was Sie in der App tun oder schreiben. Diese Zähler sind nicht Teil der Sicherung der App
(weder des Textes noch der Datei), und Ink Lab sendet sie an niemanden. Unter Android verlassen sie das Handy auch sonst
nicht, weil die Systemsicherung für diese App deaktiviert ist; auf iPhone und iPad können sie Teil Ihrer Geräte- oder
iCloud-Sicherung sein, wenn Sie diese aktiviert haben, wie die übrigen Einstellungen der App.

### Staffelei-Modus und Verknüpfungen
Der Staffelei-Modus (in „Palette“) zeigt die Palette groß an und hält den Bildschirm eingeschaltet, solange er offen
ist; nach dem Schließen schaltet sich der Bildschirm wieder wie gewohnt ab. Er benötigt keine Berechtigung und
speichert oder sendet keine Daten. Die Verknüpfungen auf dem Startbildschirm (langes Drücken auf das Symbol unter
Android, Schnellaktionen auf dem iPhone) öffnen nur „Farbe abgleichen“, „Neue Palette“ oder „Farbmuster suchen“: Sie
enthalten keine Daten von Ihnen.

### Sicherungskopie
„Export“ (Optionen → Sicherung) erzeugt einen JSON-Text, keine Datei, mit Ihren Einstellungen, den nicht geheimen
KI-Einstellungen, Ihrer Sammlung, Favoriten, Wunschliste, ausgetrockneten Markern, Tintenständen und Nachfüll-Notizen,
eigenen Farben, Paletten, Ihrem Verlauf, Ihren Favoriten und zuletzt angesehenen Ideen, den Tagebucheinträgen und Ihren
Mischrezepten (mit den internen Dateinamen ihrer Fotos und der Fotos Ihrer Farbproben, nicht den Fotos selbst) und **kopiert ihn in die Zwischenablage**, damit Sie ihn einfügen können, wo Sie
möchten; „Import“ nimmt ihn durch Einfügen entgegen. Beim Import ersetzt die Sicherung Ihre aktuellen Daten, auch das
Tagebuch: Einträge, die nicht darin enthalten sind, werden zusammen mit ihren Fotos gelöscht, und die App weist Sie
vorher darauf hin. Die Sicherung ist nicht verschlüsselt, enthält keine Kennung und niemals Ihren API-Schlüssel oder
ein Foto. Was Sie danach damit tun (ihn in Ihrer Cloud speichern, per Nachricht versenden ...), liegt
außerhalb der App. Beachten Sie, dass die Zwischenablage je nach System für Ihre Tastatur oder für andere Apps
sichtbar sein kann.

„Sicherungsdatei teilen“ (Optionen → Deine Daten → Sicherungsdatei) erzeugt eine ZIP-Datei mit derselben Sicherung
und zusätzlich den Fotos Ihres Tagebuchs, Ihrer echten Farbproben und Ihrer Mischrezepte, schreibt sie in den temporären Ordner (Cache) der App und öffnet das Teilen-Menü des
Systems, damit Sie sie in „Dateien“, Drive oder der App Ihrer Wahl speichern: Sie geht nur dorthin, wohin Sie sie
senden, und die App löscht die früheren Sicherungsdateien in diesem Ordner, wenn sie die nächste erzeugt. „Aus Datei
wiederherstellen“ öffnet die Dokumentauswahl des Systems, die keine Berechtigung benötigt (die Auswahl hinterlässt eine
Kopie der gewählten Datei im Cache der App, und die App löscht sie, wenn sie fertig ist); die Datei wird vollständig
geprüft, bevor etwas geschrieben wird, und die App bittet Sie um Bestätigung, denn sie ersetzt Ihre aktuellen Daten,
Fotos eingeschlossen, und löscht die Fotos, die nicht in der Datei enthalten sind. Keine Sicherung, weder die
in der Zwischenablage noch die Datei, enthält Ihren API-Schlüssel.

Außerdem merkt sich die App, nur auf Ihrem Handy, wann Sie zuletzt eine Sicherungsdatei gespeichert haben, um Ihnen
dieses Datum anzuzeigen und eine neue Sicherung vorzuschlagen, wenn mehr als 30 Tage vergangen sind. Dieses Datum ist in
keiner Sicherung enthalten.

### Fehlerprotokoll
Tritt in der App ein unerwarteter Fehler auf, schreibt sie einen kurzen Eintrag in eine Datei in ihrem privaten Speicher
auf Ihrem Handy, damit sich der Fehler finden und beheben lässt. Jeder Eintrag enthält den Zeitpunkt, die App-Version,
die Plattform und die Systemversion, die Stelle in der App, an der der Fehler abgefangen wurde, die erste Zeile der
Fehlermeldung (höchstens 300 Zeichen) und eine gekürzte technische Aufrufliste des Codes (Stack-Trace). Bevor ein
Eintrag gespeichert wird, ersetzt die App die Parameter von Webadressen, Tokens und Schlüssel, E-Mail-Adressen sowie
Ordnernamen, die auf die App oder den Gerätenutzer schließen lassen. Das Protokoll ist für technische Angaben gedacht,
nicht für Ihre Inhalte; eine Fehlermeldung kann allerdings gelegentlich einen Ausschnitt dessen enthalten, was die App
gerade verarbeitet hat. Die Datei ist auf etwa 200 KB begrenzt, und eine vorherige Datei wird aufbewahrt; ältere
Einträge werden verworfen. Das Protokoll **verlässt Ihr Handy nie von selbst**: Es wird nichts hochgeladen, und die App
nutzt keinen Dienst für Absturzberichte. Unter Optionen → Info übergibt „Fehlerprotokoll teilen“ die Datei nur dann,
wenn Sie darauf tippen, an die App, die Sie im Teilen-Menü des Systems auswählen, und sie geht nur dorthin, wohin Sie
sie senden; „Fehlerprotokoll löschen“ löscht sie zusammen mit der vorherigen Datei. Unter Android ist es wie die übrigen
Daten der App von der Cloud-Sicherung und der Übertragung zwischen Geräten ausgeschlossen; auf dem iPhone kann es,
ebenfalls wie die übrigen Daten der App, Teil Ihrer Geräte- oder iCloud-Sicherung sein.

### Optionale KI
Sie ist **standardmäßig ausgeschaltet** (Optionen → KI-Assistent → Mit KI vorschlagen). Ist sie ausgeschaltet, baut die App
keine Netzwerkverbindung auf und ruft ML Kit nicht auf. Wenn Sie sie aktivieren, zeigt Ihnen die App vorher, was das
Handy verlassen würde, und Sie können wählen zwischen:

- **Farbtheorie (lokale Engine):** ohne KI und ohne Netzwerk.
- **Auf dem Gerät (Gemini Nano, auf kompatiblen Android-Geräten, über ML Kit von Google):** Ihr Szenario und die
  Farbcodes werden auf Ihrem Telefon verarbeitet und nirgendwohin gesendet. Beim Aktivieren der KI verwendet die App ML
  Kit, um zu prüfen, ob Gemini Nano verfügbar ist, und, wenn Sie diese Option wählen, um es herunterzuladen und die
  Vorschläge zu erzeugen. Bei der Nutzung **sendet ML Kit an Google** über HTTPS und gebündelt (etwa einmal am Tag)
  Diagnose- und Nutzungsdaten: Informationen zum Gerät (Hersteller, Modell, Version und Build des Systems), zur App
  (Paketname und Version), Gerätekennungen und andere Kennungen, einschließlich installationsbezogener Kennungen,
  Leistungsmetriken, die API-Konfiguration, die Größe der Ein- und Ausgabe, die Version der Funktion, den Ereignistyp,
  Fehlercodes und die eingestellten Sprachen. Google gibt an, diese Daten für Diagnose und Nutzungsanalyse zu verwenden
  und nicht an Dritte weiterzugeben (https://developers.google.com/ml-kit/android-data-disclosure). Diese Übermittlung
  enthält nicht den Inhalt Ihrer Anfragen, Ihre Farben oder Ihre Fotos, nur deren Größe. Der Entwickler erhält diese
  Daten nicht: Google verarbeitet sie nach seinen eigenen Bedingungen und seiner Datenschutzerklärung
  (https://policies.google.com/privacy). Ist das Modell nicht auf dem Handy, lädt Android es einmalig über die
  Google-Dienste herunter; dieser Download und das Modell unterliegen den Bedingungen von Google. Auf dem iPhone wird
  ML Kit nicht verwendet: Die KI auf dem Gerät ist dort Apple Intelligence (siehe nächster Punkt).
- **Auf dem iPhone (Apple Intelligence, ab iOS 26 auf einem kompatiblen iPhone):** Ihr Szenario und Ihre Farbcodes
  werden auf Ihrem Handy von Apples Modell verarbeitet, das mit Apple Intelligence geliefert wird, über Apples
  Framework Foundation Models. Die App lädt das Modell nicht herunter (iOS installiert und verwaltet es), nutzt für diese
  Option keinen anderen Dienst und sendet nichts: weder Ihre Anfragen noch Ihre Farben oder Fotos.
- **OpenRouter mit Ihrem Schlüssel:** Nur wenn Sie OpenRouter wählen, Ihren Schlüssel speichern und in „Palette“ auf
  „Mit KI vorschlagen“ tippen, sendet die App **von Ihrem Handy direkt an `openrouter.ai`, über HTTPS und mit Ihrem eigenen
  Schlüssel und Ihrem eigenen Konto**: die Marke (Kennung und Name), den Palettenmodus, den Namen der Szene (auf
  Englisch), Code und Namen des Basismarkers (falls vorhanden) und ob er fixiert ist, die Palettengröße, die Codes und
  die Hex-Farben aus dem Katalog der Kandidatenmarker aus Ihrer Sammlung (nicht ihre Namen), die
  Generierungseinstellungen (Modell, Temperatur und Längenbegrenzung), feste Anweisungen der App und den Header
  `X-Title: Ink Lab`. Um Ihnen die verfügbaren Modelle anzuzeigen, fragt die App den Katalog von OpenRouter ab (mit
  Ihrem Schlüssel, falls Sie ihn gespeichert haben). **Niemals** gesendet werden Fotos (die Anfrage gibt an, dass kein
  Bild angehängt ist, und die App hat keine Möglichkeit, eines anzuhängen), Ihre eigenen Farben, Ihre Favoriten, Ihre
  gespeicherten Paletten oder Kennungen von Ihnen. Wie bei jeder Internetverbindung sehen OpenRouter und der
  Modellanbieter die IP-Adresse Ihres Geräts. Sie erhalten diese Anfrage und wenden **ihre eigenen** Bedingungen und
  Datenschutzrichtlinien an, auch hinsichtlich der Speicherdauer, die Sie unter https://openrouter.ai/privacy nachlesen
  können. Der Entwickler sieht sie nicht, sie läuft über keinen seiner Server, und die App speichert sie nicht.

Ihr OpenRouter-Schlüssel wird im sicheren Speicher des Systems abgelegt (Android Keystore oder iOS-Schlüsselbund, nur
auf diesem Gerät). Er wird nicht an den Entwickler übertragen, ist nicht in den Sicherungskopien enthalten, und Sie
können ihn jederzeit in „Optionen“ löschen. Wenn die KI fehlschlägt, kehrt die App zur Farbtheorie zurück.

### Berechtigungen
Die App fragt nach der Berechtigung für **Kamera oder Fotos** nur, wenn Sie „Abgleich“, „Aus einem Foto“ oder „Meine
Farbe“ verwenden oder dem „Tagebuch“, einer echten Farbprobe oder einem Mischrezept ein Foto hinzufügen. Unter Android deklariert sie den Zugriff auf das **Internet**
und den **Netzwerkstatus** (`INTERNET` und `ACCESS_NETWORK_STATE`), die nur bei aktivierter KI genutzt werden: für die
optionale KI mit OpenRouter und für die Diagnosedaten, die ML Kit bei Nutzung der KI auf dem Gerät an Google sendet. Sie
fragt nicht nach Standort, Kontakten, Kalender, Mikrofon oder Benachrichtigungen und verwendet nicht die Werbe-ID. Wenn
Sie eine Palette, eine Farbmusterkarte oder einen Tagebucheintrag als Bild, eine Sicherungsdatei oder das
Fehlerprotokoll teilen, wird der Inhalt nur an die App übergeben, die Sie im Teilen-Menü des Systems auswählen; die App
benötigt dafür keine Berechtigung, auch nicht, um eine Sicherungsdatei mit der Auswahl des Systems zu öffnen. Der
Staffelei-Modus, die Verknüpfungen und die Bewertung im Store benötigen keine Berechtigung. Auf dem iPhone gibt das
Datenschutz-Manifest der App, wie von Apple verlangt, an, dass eine von der App genutzte Bibliothek (zum Auslesen der
eigenen Version) Zeitstempel von Dateien abfragen kann; das geschieht nur für die eigenen Dateien der App in ihrem
privaten Bereich (Grund C617.1), und diese Angaben verlassen das Handy nicht.

### Daten, die NICHT verarbeitet werden
- Wir fragen weder nach Namen, E-Mail-Adresse, Telefonnummer oder Alter noch nach Kontodaten und speichern sie nicht: Es
  gibt keine Konten.
- Der Entwickler verwendet keine Analyse und keine Absturzberichte, und es gibt keine Werbung, keine personalisierte
  Werbung und kein App-übergreifendes Tracking. Die einzige Ausnahme sind die Diagnose- und Nutzungsdaten, die ML Kit an
  Google sendet, wenn Sie die KI auf dem Gerät nutzen (siehe „Optionale KI“); der Entwickler erhält sie nicht.
- Das Fehlerprotokoll (siehe „Fehlerprotokoll“) ist kein Absturzbericht: Es wird nichts automatisch gesendet, und es
  verlässt Ihr Handy nur, wenn Sie es selbst teilen.
- Wir erhalten weder Ihre Fotos noch Ihre Sammlungen, Ihre Paletten oder Ihren Schlüssel.

### Wenn Sie uns schreiben
Sie können uns an inklab@mainshai.com schreiben. Wir verarbeiten Ihre E-Mail-Adresse und Ihre Mitteilung nur, um Ihnen
zu antworten. Senden Sie uns weder Ihren API-Schlüssel noch Sicherungskopien mit Daten, die Sie nicht teilen möchten:
Für einen Fehler genügen uns Testdaten.

Wenn Sie einen KI-Vorschlag melden („Diesen Vorschlag melden“, in „Palette“), öffnet die App Ihre E-Mail-App mit einer
vorformulierten Nachricht an inklab@mainshai.com: der von Ihnen gewählte Grund, die App-Version, der KI-Anbieter und das
Modell, die Marke, der Modus oder die Szene, der Code des Basismarkers sowie die Codes, Rollen und Begründungen dieses
Vorschlags. Sie enthält niemals Ihren API-Schlüssel oder Fotos. Sie erreicht uns nur, wenn Sie sie absenden, und wir
verwenden sie, um den gemeldeten Inhalt zu prüfen und die Vorschläge zu verbessern. Gibt es keine E-Mail-App, wird der
Bericht in die Zwischenablage kopiert, damit Sie ihn selbst einfügen können.

„Feedback senden“ (Optionen → Info) öffnet Ihre E-Mail-App mit einer Nachricht an inklab@mainshai.com, in der bereits
die App-Version, die Plattform und die Systemversion stehen und die Platz für Ihren Text lässt. Es wird nichts gesendet,
solange Sie die E-Mail nicht selbst abschicken, und das Fehlerprotokoll wird nicht angehängt. Gibt es keine E-Mail-App,
wird die Adresse in die Zwischenablage kopiert. Wenn Sie uns das Fehlerprotokoll senden, verwenden wir es nur, um den
Fehler zu finden und zu beheben.

## 3. Zwecke und Rechtsgrundlage


| Verarbeitung | Zweck | Rechtsgrundlage (DSGVO) |
|---|---|---|
| Sammlungen, Tintenstand und Notizen, Wunschliste, eigene Farben, Favoriten, Paletten, Mischrezepte, Tagebuch und Einstellungen auf Ihrem Handy | Damit Sie die App nutzen und Ihre Arbeit behalten können | Wir erhalten sie nicht: Sie bleiben auf Ihrem Gerät, unter Ihrer Kontrolle |
| Foto von „Abgleich“, „Aus einem Foto“, „Meine Farbe“, „Tagebuch“, einer echten Farbprobe oder eines Mischrezepts | Die ähnlichsten Marker finden, die Farbe Ihres Farbmusters auslesen oder das Foto eines Werks, einer Farbprobe oder eines Rezepts aufbewahren | Wird nur auf Ihrem Handy und auf Ihren Wunsch verarbeitet (und im Tagebuch, bei der Farbprobe und bei den Rezepten gespeichert); wir erhalten es nicht |
| Fehlerprotokoll auf Ihrem Handy | Fehler der App finden und beheben | Wird nur auf Ihrem Handy gespeichert; wir erhalten es nicht. Wenn Sie es uns senden: Ihre Anfrage und unser berechtigtes Interesse an der Fehlerbehebung (Art. 6 Abs. 1 lit. f) |
| Diagnosedaten von ML Kit (nur mit der KI auf dem Gerät, unter Android) | Diagnose und Nutzungsanalyse des SDK, laut Google | Werden nur gesendet, wenn Sie sich entscheiden, die optionale KI zu aktivieren; Google verarbeitet sie als Anbieter von ML Kit nach seinen eigenen Bedingungen und seiner Datenschutzerklärung; wir erhalten sie nicht |
| KI mit OpenRouter (optional) | Palettenvorschläge erzeugen | Ihre Einwilligung, indem Sie sie aktivieren und Ihren eigenen Schlüssel verwenden; die Verarbeitung erfolgt durch OpenRouter nach dessen Bedingungen |
| Support-E-Mails, Feedback und Meldungen von KI-Vorschlägen | Ihre Anfrage beantworten und den gemeldeten Inhalt prüfen | Ihre Anfrage und unser berechtigtes Interesse an ihrer Bearbeitung (Art. 6 Abs. 1 lit. f) |

Wir treffen keine automatisierten Entscheidungen und erstellen keine Profile über Sie.

## 4. Wer die Daten erhält
Die App übermittelt keine Daten an den Entwickler. Wenn Sie die KI aktivieren, erhält unter Android **Google** die
Diagnose- und Nutzungsdaten, die ML Kit bei Nutzung der KI auf dem Gerät sendet. Wenn Sie die KI mit OpenRouter nutzen,
erhalten **OpenRouter** und der von Ihnen gewählte **Modellanbieter** die oben beschriebene Anfrage, in Ihrem Namen und
mit Ihrem Schlüssel. Wenn Sie uns eine Support-E-Mail, Feedback, eine Meldung zu einem Vorschlag oder das
Fehlerprotokoll senden, erhält der Inhaber diese unter inklab@mainshai.com (oder unter dev@mainshai.com, der Adresse,
die die App bis Version 0.6.2 verwendet hat) über den Dienst, den Sie wählen. Teilen Sie das Fehlerprotokoll mit einer
anderen Person oder einem anderen Dienst, erhält es nur dieser Empfänger. Bewerten Sie die App im Store, erhalten
**Google** oder **Apple** Ihre Bewertung und Ihre Rezension direkt, mit Ihrem Store-Konto; sie laufen nicht über die
App. Der Entwickler sieht danach nur, was der Store veröffentlicht oder ihm in seiner Konsole zeigt (die Bewertung, die
Rezension und Ihren öffentlichen Namen; bei Google Play auch technische Angaben wie das Gerätemodell und die Versionen
des Systems und der App), und kann Ihnen dort antworten.

## 5. Internationale Übermittlungen
Der Entwickler nimmt keine Datenübermittlungen vor. Wenn Sie die KI mit OpenRouter nutzen, geht die Anfrage an den von
Ihnen gewählten Anbieter, der sie in anderen Regionen und nach seinen eigenen Bedingungen verarbeiten kann. Google kann
die Diagnosedaten von ML Kit nach seinen eigenen Bedingungen in anderen Ländern verarbeiten. Der Store, in dem Sie die
App bewerten (Google Play oder der App Store), kann Ihre Bewertung und Ihre Rezension nach seinen eigenen Bedingungen in
anderen Ländern verarbeiten. Die übrigen Dienste, die Sie nutzen möchten (E-Mail, Cloud, Ziel eines kopierten Textes
oder einer geteilten Datei oder eines geteilten Bildes), unterliegen ihren eigenen Bedingungen.

## 6. Speicherdauer


- **Daten auf Ihrem Handy:** bis Sie die App deinstallieren oder ihre Daten in den Systemeinstellungen löschen (und
  gegebenenfalls die Sicherungstexte oder -dateien, die Sie aufbewahrt haben). Die Fotos des Tagebuchs, der Farbproben
  und der Rezepte werden außerdem gelöscht, sobald Sie das Foto, den Eintrag oder das Rezept entfernen.
- **Fehlerprotokoll:** auf Ihrem Handy, bis Sie es mit „Fehlerprotokoll löschen“ löschen, die Daten der App löschen oder
  die App deinstallieren. Da es nie größer als etwa 200 KB plus eine vorherige Datei wird, werden die ältesten Einträge
  laufend verworfen.
- **Support-E-Mails, Feedback und Fehlerprotokolle, die Sie uns senden:** so lange, wie es zur Bearbeitung Ihrer Anfrage
  erforderlich ist, höchstens jedoch ein Jahr ab der letzten Antwort.

## 7. Ihre Rechte


Sie können Ihre Rechte auf **Auskunft, Berichtigung, Löschung, Widerspruch, Einschränkung der Verarbeitung und
Datenübertragbarkeit** ausüben, indem Sie an inklab@mainshai.com schreiben. Wir antworten Ihnen innerhalb eines Monats.

Wir erhalten die auf Ihrem Handy gespeicherten Daten nicht und können sie daher weder einsehen noch für Sie löschen.
Sie können sie löschen, indem Sie die App deinstallieren oder ihre Daten in den Systemeinstellungen löschen, und sie
mit „Export“ (Optionen → Sicherung; die Fotos sind in diesem Text nicht enthalten) oder mit „Sicherungsdatei
speichern“ (die sie enthält) mitnehmen. Für das, was Sie an OpenRouter gesendet haben, üben Sie Ihre Rechte gegenüber
OpenRouter und dem Modellanbieter aus; für die
Diagnosedaten von ML Kit gegenüber Google.

Wenn Sie der Ansicht sind, dass wir Ihre Daten nicht ordnungsgemäß verarbeitet haben, können Sie Beschwerde bei der
spanischen Datenschutzbehörde (Agencia Española de Protección de Datos) einlegen: https://www.aepd.es

## 8. Minderjährige


Die App richtet sich nicht an Kinder unter 13 Jahren (oder unter dem entsprechenden Mindestalter in Ihrem Land). Sie
fragt nicht nach dem Alter und erhebt von niemandem personenbezogene Daten, auch nicht von Minderjährigen: Es gibt keine
Konten, und Ihre Daten bleiben auf dem Gerät. Die KI mit OpenRouter erfordert ein eigenes Konto bei einem Dritten, das
Minderjährige nicht ohne Erlaubnis ihrer Eltern oder Erziehungsberechtigten anlegen sollten.

## 9. Sicherheit
Es gibt keinen Server des Entwicklers und keine Datenübermittlung aus der App, außer bei aktivierter optionaler KI (das
Bewertungsfenster zeigt der Store, nicht die App; siehe „Bewertung im Store“). Ihre Daten liegen im privaten Bereich der
App, Ihr Schlüssel im Keystore oder im Schlüsselbund; die Verbindungen zu OpenRouter nutzen HTTPS und folgen keinen
Weiterleitungen. Der Schutz Ihres Handys (Bildschirmsperre, Verschlüsselung, kein Root oder Jailbreak) liegt bei Ihnen.
Der Code ist öffentlich, und jeder kann überprüfen, was er tut.

## 10. Änderungen dieser Datenschutzerklärung


Wenn sich ändert, was die App mit den Daten macht, aktualisieren wir diese Seite und das Datum oben. Ist die Änderung
wesentlich (zum Beispiel, wenn eine Funktion Daten vom Handy senden würde), weisen wir Sie auch in der App darauf hin,
und sie würde nur mit Ihrer Einwilligung aktiviert.

## 11. Kontakt


inklab@mainshai.com
