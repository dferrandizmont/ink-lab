# Datenschutzerklärung von Ink Lab


Zuletzt aktualisiert: 2026-11-01

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
Ihre aktive Marke, die Packs und Marker, die Sie besitzen, Ihre Favoriten, Ihre Wunschliste, die Marker, die Sie als
ausgetrocknet markieren, die eigenen Farben, die Sie für Ihre Marker speichern, Ihre gespeicherten Paletten, der
Verlauf Ihrer letzten Auswahlen beim Farbabgleich, die Einträge und Fotos Ihres Tagebuchs, Ihre Favoriten und zuletzt
angesehenen Ideen und Ihre Einstellungen werden ausschließlich im privaten Speicher der App auf Ihrem Gerät
gespeichert. Von jeder eigenen Farbe wird nur ihr Hex-Code gespeichert, niemals das Foto, aus dem Sie sie entnommen
haben. Die Markerkataloge sind in der App enthalten, und alles funktioniert ohne Verbindung; „In anderen Marken“ (in
der Detailansicht eines Markers), die Vorschau „Farbsehen“ (in „Palette“) und die „Zahlen des Tagebuchs“ werden auf
Ihrem Handy aus diesen Katalogen und Ihren Daten berechnet, ohne etwas zu senden. Es gibt keine Synchronisierung und
keine Kopie auf einem unserer Server.

Die Systemsicherung von Android ist für diese App **deaktiviert**: Sie schließt alle Dateien der App von der
Cloud-Sicherung und von der Übertragung zwischen Geräten aus, sodass weder Ihre Einstellungen noch Ihr Schlüssel, Ihre
Daten oder die Tagebuchfotos auf diesem Weg das Handy verlassen. Auf dem iPhone können die Einstellungen und die
Tagebuchfotos Teil der Geräte- oder iCloud-Sicherung sein, die Sie mit Ihrem Apple-Account verwalten: Das ist ein
Mechanismus von Apple unter Ihrer Kontrolle, keine Übermittlung durch den Entwickler.

### Kamera und Galerie
Nur wenn Sie „Abgleich“, „Aus einem Foto“ (in „Palette“) oder „Meine Farbe“ (in der Detailansicht eines Markers)
verwenden oder einem Eintrag im „Tagebuch“ (unter „Ideen“) ein Foto hinzufügen und ein Foto aufnehmen oder eines aus
der Galerie auswählen, fragt die App nach der Berechtigung oder öffnet die Auswahl des Systems. Das Foto wird **auf
Ihrem Handy** dekodiert und analysiert: Es wird nirgendwohin hochgeladen und niemals an einen KI-Anbieter gesendet;
außer im Tagebuch (siehe unten) wird es auch nicht gespeichert. Bei „Abgleich“ werden von der Auswahl nur die
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

### Sicherungskopie
„Export“ (Optionen → Sicherung) erzeugt einen JSON-Text, keine Datei, mit Ihren Einstellungen, den nicht geheimen
KI-Einstellungen, Ihrer Sammlung, Favoriten, Wunschliste, ausgetrockneten Markern, eigenen Farben, Paletten, Ihrem
Verlauf, Ihren Favoriten und zuletzt angesehenen Ideen und den Tagebucheinträgen (mit den internen Dateinamen ihrer
Fotos, nicht den Fotos selbst) und **kopiert ihn in die Zwischenablage**, damit Sie ihn einfügen können, wo Sie
möchten; „Import“ nimmt ihn durch Einfügen entgegen. Beim Import ersetzt die Sicherung Ihre aktuellen Daten, auch das
Tagebuch: Einträge, die nicht darin enthalten sind, werden zusammen mit ihren Fotos gelöscht, und die App weist Sie
vorher darauf hin. Die Sicherung ist nicht verschlüsselt, enthält keine Kennung und niemals Ihren API-Schlüssel oder
die Tagebuchfotos. Was Sie danach damit tun (ihn in Ihrer Cloud speichern, per Nachricht versenden ...), liegt
außerhalb der App. Beachten Sie, dass die Zwischenablage je nach System für Ihre Tastatur oder für andere Apps
sichtbar sein kann.

„Sicherungsdatei speichern“ (Optionen → Deine Daten → Sicherungsdatei) erzeugt eine ZIP-Datei mit derselben Sicherung
und zusätzlich den Tagebuchfotos, schreibt sie in den temporären Ordner (Cache) der App und öffnet das Teilen-Menü des
Systems, damit Sie sie in „Dateien“, Drive oder der App Ihrer Wahl speichern: Sie geht nur dorthin, wohin Sie sie
senden, und die App löscht die früheren Sicherungsdateien in diesem Ordner, wenn sie die nächste erzeugt. „Aus Datei
wiederherstellen“ öffnet die Dokumentauswahl des Systems, die keine Berechtigung benötigt (die Auswahl hinterlässt eine
Kopie der gewählten Datei im Cache der App, und die App löscht sie, wenn sie fertig ist); die Datei wird vollständig
geprüft, bevor etwas geschrieben wird, und die App bittet Sie um Bestätigung, denn sie ersetzt Ihre aktuellen Daten,
Fotos eingeschlossen, und löscht die Tagebuchfotos, die nicht in der Datei enthalten sind. Keine Sicherung, weder die
in der Zwischenablage noch die Datei, enthält Ihren API-Schlüssel.

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
  Google-Dienste herunter; dieser Download und das Modell unterliegen den Bedingungen von Google. Auf dem iPhone gibt es
  weder KI auf dem Gerät noch ML Kit.
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
Farbe“ verwenden oder dem „Tagebuch“ ein Foto hinzufügen. Unter Android deklariert sie den Zugriff auf das
**Internet** und den **Netzwerkstatus** (`INTERNET` und `ACCESS_NETWORK_STATE`), die nur bei aktivierter KI genutzt
werden: für die optionale KI mit OpenRouter und für die Diagnosedaten, die ML Kit bei Nutzung der KI auf dem Gerät an
Google sendet. Sie fragt nicht nach Standort, Kontakten, Kalender, Mikrofon oder Benachrichtigungen und verwendet
nicht die Werbe-ID. Wenn Sie eine Palette, eine Farbmusterkarte oder einen Tagebucheintrag als Bild oder eine
Sicherungsdatei teilen, wird sie nur an die App übergeben, die Sie im Teilen-Menü des Systems auswählen; die App
benötigt dafür keine Berechtigung, auch nicht, um eine Sicherungsdatei mit der Auswahl des Systems zu öffnen.

### Daten, die NICHT verarbeitet werden
- Wir fragen weder nach Namen, E-Mail-Adresse, Telefonnummer oder Alter noch nach Kontodaten und speichern sie nicht: Es
  gibt keine Konten.
- Der Entwickler verwendet keine Analyse und keine Absturzberichte, und es gibt keine Werbung, keine personalisierte
  Werbung und kein App-übergreifendes Tracking. Die einzige Ausnahme sind die Diagnose- und Nutzungsdaten, die ML Kit an
  Google sendet, wenn Sie die KI auf dem Gerät nutzen (siehe „Optionale KI“); der Entwickler erhält sie nicht.
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

## 3. Zwecke und Rechtsgrundlage


| Verarbeitung | Zweck | Rechtsgrundlage (DSGVO) |
|---|---|---|
| Sammlungen, Wunschliste, eigene Farben, Favoriten, Paletten, Tagebuch und Einstellungen auf Ihrem Handy | Damit Sie die App nutzen und Ihre Arbeit behalten können | Wir erhalten sie nicht: Sie bleiben auf Ihrem Gerät, unter Ihrer Kontrolle |
| Foto von „Abgleich“, „Aus einem Foto“, „Meine Farbe“ oder „Tagebuch“ | Die ähnlichsten Marker finden, die Farbe Ihres Farbmusters auslesen oder das Foto eines Werks in Ihrem Tagebuch aufbewahren | Wird nur auf Ihrem Handy und auf Ihren Wunsch verarbeitet (und im Tagebuch gespeichert); wir erhalten es nicht |
| Diagnosedaten von ML Kit (nur mit der KI auf dem Gerät, unter Android) | Diagnose und Nutzungsanalyse des SDK, laut Google | Werden nur gesendet, wenn Sie sich entscheiden, die optionale KI zu aktivieren; Google verarbeitet sie als Anbieter von ML Kit nach seinen eigenen Bedingungen und seiner Datenschutzerklärung; wir erhalten sie nicht |
| KI mit OpenRouter (optional) | Palettenvorschläge erzeugen | Ihre Einwilligung, indem Sie sie aktivieren und Ihren eigenen Schlüssel verwenden; die Verarbeitung erfolgt durch OpenRouter nach dessen Bedingungen |
| Support-E-Mails und Meldungen von KI-Vorschlägen | Ihre Anfrage beantworten und den gemeldeten Inhalt prüfen | Ihre Anfrage und unser berechtigtes Interesse an ihrer Bearbeitung (Art. 6 Abs. 1 lit. f) |

Wir treffen keine automatisierten Entscheidungen und erstellen keine Profile über Sie.

## 4. Wer die Daten erhält
Die App übermittelt keine Daten an den Entwickler. Wenn Sie die KI aktivieren, erhält unter Android **Google** die
Diagnose- und Nutzungsdaten, die ML Kit bei Nutzung der KI auf dem Gerät sendet. Wenn Sie die KI mit OpenRouter nutzen,
erhalten **OpenRouter** und der von Ihnen gewählte **Modellanbieter** die oben beschriebene Anfrage, in Ihrem Namen und
mit Ihrem Schlüssel. Wenn Sie eine Support-E-Mail oder eine Meldung zu einem Vorschlag senden, erhält sie der Inhaber
unter inklab@mainshai.com (oder unter dev@mainshai.com, der Adresse, die die App bis Version 0.6.2 verwendet hat) über
den E-Mail-Dienst, den Sie wählen.

## 5. Internationale Übermittlungen
Der Entwickler nimmt keine Datenübermittlungen vor. Wenn Sie die KI mit OpenRouter nutzen, geht die Anfrage an den von
Ihnen gewählten Anbieter, der sie in anderen Regionen und nach seinen eigenen Bedingungen verarbeiten kann. Google kann
die Diagnosedaten von ML Kit nach seinen eigenen Bedingungen in anderen Ländern verarbeiten. Die übrigen Dienste, die
Sie nutzen möchten (E-Mail, Cloud, Ziel eines kopierten Textes oder einer geteilten Datei oder eines geteilten
Bildes), unterliegen ihren eigenen Bedingungen.

## 6. Speicherdauer


- **Daten auf Ihrem Handy:** bis Sie die App deinstallieren oder ihre Daten in den Systemeinstellungen löschen (und
  gegebenenfalls die Sicherungstexte oder -dateien, die Sie aufbewahrt haben). Die Tagebuchfotos werden außerdem
  gelöscht, sobald Sie das Foto oder den Eintrag entfernen.
- **Support-E-Mails:** so lange, wie es zur Bearbeitung Ihrer Anfrage erforderlich ist, höchstens jedoch ein Jahr ab der
  letzten Antwort.

## 7. Ihre Rechte


Sie können Ihre Rechte auf **Auskunft, Berichtigung, Löschung, Widerspruch, Einschränkung der Verarbeitung und
Datenübertragbarkeit** ausüben, indem Sie an inklab@mainshai.com schreiben. Wir antworten Ihnen innerhalb eines Monats.

Wir erhalten die auf Ihrem Handy gespeicherten Daten nicht und können sie daher weder einsehen noch für Sie löschen.
Sie können sie löschen, indem Sie die App deinstallieren oder ihre Daten in den Systemeinstellungen löschen, und sie
mit „Export“ (Optionen → Sicherung; die Tagebuchfotos sind in diesem Text nicht enthalten) oder mit „Sicherungsdatei
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
Es gibt keinen Server des Entwicklers und keine Datenübermittlung aus der App, außer bei aktivierter optionaler KI. Ihre
Daten liegen im privaten Bereich der App, Ihr Schlüssel im Keystore oder im Schlüsselbund; die Verbindungen zu
OpenRouter nutzen HTTPS und folgen keinen Weiterleitungen. Der Schutz Ihres Handys (Bildschirmsperre, Verschlüsselung,
kein Root oder Jailbreak) liegt bei Ihnen. Der Code ist öffentlich, und jeder kann überprüfen, was er tut.

## 10. Änderungen dieser Datenschutzerklärung


Wenn sich ändert, was die App mit den Daten macht, aktualisieren wir diese Seite und das Datum oben. Ist die Änderung
wesentlich (zum Beispiel, wenn eine Funktion Daten vom Handy senden würde), weisen wir Sie auch in der App darauf hin,
und sie würde nur mit Ihrer Einwilligung aktiviert.

## 11. Kontakt


inklab@mainshai.com
