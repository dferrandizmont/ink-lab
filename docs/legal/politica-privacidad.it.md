# Informativa sulla privacy di Ink Lab


Ultimo aggiornamento: 2026-11-20

Traduzione di cortesia. Fa fede la [versione spagnola](https://inklab.mainshai.com/es/privacy/).

Ink Lab è un'app per chi disegna con i pennarelli ad alcol: consulta i campioni di colore, abbina il colore di una foto
a un pennarello della tua collezione e crea palette con la teoria del colore. È un'app indipendente: non è stata creata,
verificata né approvata da Ohuhu, DecoTime o qualsiasi altro marchio.

Riepilogo: **non hai un account, non esiste un server nostro e i tuoi dati restano sul tuo telefono.** L'app è
completamente gratuita e open source, e non include strumenti di analisi propri, pubblicità né tracciamento. **Se non
attivi l'IA, l'app non usa la rete.** Se la attivi, su Android l'IA sul dispositivo usa ML Kit di Google, che invia a
Google dati diagnostici e di utilizzo (mai le tue richieste, i tuoi colori o le tue foto); e se scegli OpenRouter con la
tua chiave, viene inviato esattamente ciò che è spiegato più avanti. Se ci scrivi, Cloudflare inoltra il messaggio a
Gmail. Ne conserviamo una copia su Proton e rispondiamo tramite Resend senza tracciare aperture o clic.

## 1. Titolare del trattamento


- Titolare: Daniel Mont Ferrandiz
- E-mail di contatto: inklab@mainshai.com

## 2. Quali dati vengono trattati


### Dati che restano sul tuo telefono (non li riceviamo)
Il tuo marchio attivo, i pack e i pennarelli che possiedi, i tuoi preferiti, la tua lista dei desideri, il livello
d'inchiostro dei tuoi pennarelli (pieno, in esaurimento o secco) e le tue note di ricarica, le foto dei tuoi campioni
reali, i colori personali che salvi per i tuoi pennarelli, le tue palette salvate, le tue ricette di sfumatura e le loro
foto, la cronologia delle tue ultime scelte nell'abbinamento dei colori, le voci e le foto del tuo diario, le tue idee
preferite e viste di recente, le tue impostazioni, il punto del benvenuto in cui ti sei fermato, la data del tuo ultimo
file di backup, i contatori della recensione nello store e il registro degli errori (vedi sotto) sono salvati solo nella
memoria privata dell'app, sul tuo dispositivo. Di ogni colore personale viene salvato solo il codice esadecimale, mai la
foto da cui l'hai ricavato. I cataloghi delle 15 marche di pennarelli (Ohuhu, DecoTime, Copic, Finecolour, Touch Twin,
Promarker, Promarker Brush, Prismacolor Premier, Spectrum Noir, Arrtx, ZIG Kurecolor, Graph'it, Marvy Le Plume, Blick
Studio Brush e Artist's Loft) sono inclusi nell'app e tutto funziona offline. «In altre marche», «Ombra e luce», «Sfuma
con…» e l'avviso sui pennarelli quasi uguali (nel dettaglio di un pennarello), la ricerca per codice esadecimale, la
vista «Valori» in scala di grigi, l'anteprima «Visione dei colori» (in «Palette»), la «Mappa dei colori» e la traduzione
delle ricette (in «La mia collezione» → «Strumenti») e i «Numeri del diario» vengono calcolati sul tuo telefono con quei
cataloghi e i tuoi dati, senza inviare nulla. Non c'è alcuna sincronizzazione né copia su un nostro server.

Il backup di sistema di Android è **disattivato** per questa app: esclude tutti i file dell'app dal backup nel cloud e
dal trasferimento tra dispositivi, quindi né le tue impostazioni, né la tua chiave, né i tuoi dati, né le foto del
diario, né il registro degli errori lasciano il telefono per questa via. Su iPhone, le preferenze, il diario, le ricette
di sfumatura, le foto che l'app conserva e il registro degli errori possono rientrare nel backup del dispositivo o di
iCloud che gestisci con il tuo account Apple:
è un meccanismo di Apple, sotto il tuo controllo, non un invio da parte dello sviluppatore.

### Fotocamera e galleria
Solo quando usi «Abbina», «Da una foto» (in «Palette») o «Il mio colore» (nel dettaglio di un pennarello), o aggiungi
una foto a una voce del «Diario» (in «Idee»), al «Campione reale» di un pennarello o a una ricetta di sfumatura, e
scegli di scattare una foto o di sceglierne una dalla galleria, l'app chiede l'autorizzazione o apre il selettore di
sistema. La foto viene decodificata e analizzata **sul tuo telefono**: non viene caricata da nessuna parte e non viene
mai inviata a un fornitore di IA; salvo nel diario, nel campione reale e nelle ricette (vedi sotto), non viene nemmeno
salvata. In «Abbina», della scelta si conservano solo il colore campionato e il pennarello
abbinato, nella tua cronologia locale. In «Da una foto» se ne estraggono i colori principali per proporti
pennarelli della tua collezione; la foto resta in memoria solo mentre guardi il risultato e, se salvi la palette,
vengono salvati i codici dei pennarelli, mai la foto. In «Il mio colore» tocchi il campione dipinto nella foto e viene
salvato solo il suo colore, come codice esadecimale, mai la foto.

### Diario
Nella scheda «Idee», «Diario» ti permette di annotare le opere che dipingi: titolo, data, su cosa l'hai dipinta, stato,
pennarelli usati, palette collegata e note. Le voci vengono salvate sul tuo telefono come il resto dei tuoi dati. Ogni
voce può contenere fino a 4 foto, scattate con la fotocamera o scelte dalla galleria, che l'app copia ridotte (al
massimo 2048 pixel di lato) nella sua cartella privata; la foto originale nella tua galleria non viene modificata.
Queste foto non vengono caricate da nessuna parte né inviate alle funzioni di IA (né a OpenRouter, né a Gemini Nano, né
a ML Kit), e vengono eliminate quando rimuovi la foto o la voce, e insieme all'app quando la disinstalli. «Condividi
questa voce» disegna, solo quando lo tocchi, un'immagine con il titolo, la data, lo stato, la prima foto, i pennarelli
usati e i colori della palette collegata, e la consegna unicamente all'app che scegli nel menu di condivisione del
sistema.

### Campioni reali, livello d'inchiostro e ricette di sfumatura
Nel dettaglio di un pennarello che possiedi puoi indicare il livello d'inchiostro (pieno, in esaurimento o secco),
scrivere una nota di ricarica di al massimo 80 caratteri e aggiungere una foto del tuo campione reale su carta, che
l'app copia ridotta (circa 1024 pixel di lato) nella sua cartella privata. In «La mia collezione» → «Strumenti» puoi
salvare le tue ricette di sfumatura (nome, pennarelli, note e una foto facoltativa, ridotta al massimo a 2048 pixel di
lato). Tutto questo resta sul tuo telefono: le foto non vengono caricate da nessuna parte né inviate alle funzioni di
IA, vengono eliminate quando le rimuovi o elimini la ricetta, e insieme all'app quando la disinstalli. Lasciano il
telefono solo se salvi un file di backup (vedi sotto) e lo mandi da qualche parte.

### Condividere come testo
«Condividi come testo» (in «Palette»), l'esportazione della tua collezione in CSV o testo e la ricetta tradotta (in
«Strumenti») preparano un testo con i pennarelli (la marca, i codici e, a seconda dei casi, i nomi, i colori e se sono
secchi) e, solo quando lo tocchi, lo consegnano all'app che scegli nel menu di condivisione del sistema o lo copiano
negli appunti. «Importa da testo» e l'importazione dei codici leggono solo il testo che incolli o scrivi; non aprono
link e non si collegano a nulla.

### Recensione nello store
Ogni tanto, dopo che hai salvato una palette o una nuova voce del diario, Ink Lab può chiedere allo store (Google Play
su Android, l'App Store su iPhone e iPad) di mostrarti la sua finestra per valutare l'app. Non lo chiede durante la
prima settimana, né durante un ripristino o subito dopo aver ripristinato o importato un backup, né più di tre volte in
totale (al massimo una per versione e ad almeno 90 giorni di distanza), ed **è lo store a decidere** se la finestra
compare. Per chiedere quella finestra l'app usa la libreria di recensioni di Google Play su Android (una comunicazione
interna al telefono con l'app Google Play) e la funzione del sistema su iPhone e iPad. **Ink Lab indica allo store solo
di quale app si tratta:** non gli passa le tue palette, la tua collezione né altri tuoi dati, e non sa se hai lasciato
una valutazione né cosa hai scritto. La tua valutazione e la tua recensione le scrivi nella finestra dello store e **le
riceve Google o Apple, con il tuo account dello store** e secondo i propri termini. Puoi anche aprire la pagina di Ink
Lab nello store quando vuoi con «Valuta Ink Lab» (Opzioni → Informazioni).

Per decidere quando chiedere, l'app conserva sul tuo telefono alcuni contatori: il giorno in cui l'hai aperta per la
prima volta, l'ultimo giorno in cui l'hai aperta, in quanti giorni diversi l'hai aperta, quante volte ha chiesto una
recensione, il giorno e la versione dell'ultima richiesta, e quante volte lo store non è riuscito a mostrare la finestra
(alla terza smette di provarci). Sono solo date e conteggi: non contengono nulla di ciò che fai nell'app né di ciò che
scrivi. Questi contatori non fanno parte del backup dell'app (né del testo né del file) e Ink Lab non li invia a
nessuno. Su Android non escono nemmeno dal telefono, perché il backup di sistema è disattivato per questa app; su iPhone
e iPad possono far parte del backup del dispositivo o di iCloud, se lo hai attivato, come le altre impostazioni
dell'app.

### Modalità cavalletto e scorciatoie
La modalità cavalletto (in «Palette») mostra la palette in grande e tiene lo schermo acceso finché è aperta; quando la
chiudi, lo schermo torna a spegnersi come sempre. Non chiede autorizzazioni e non salva né invia dati. Le scorciatoie
della schermata Home (pressione prolungata sull'icona su Android, azioni rapide su iPhone) aprono solo «Abbina un
colore», «Nuova palette» o «Cerca campioni»: non contengono tuoi dati.

### Copia di backup
«Esporta» (Opzioni → Backup) genera un testo JSON, non un file, con le tue impostazioni, le impostazioni non segrete
dell'IA, la tua collezione, i preferiti, la lista dei desideri, i pennarelli secchi, i livelli d'inchiostro e le note
di ricarica, i colori personali, le palette, la cronologia, le idee preferite e viste di recente, le voci del diario e
le tue ricette di sfumatura (con i nomi interni dei file delle loro foto e delle foto dei tuoi campioni, non le foto), e lo **copia negli appunti** perché tu lo incolli dove vuoi; «Importa» lo riceve quando lo incolli.
All'importazione, il backup sostituisce i tuoi dati attuali, diario compreso: le voci che non vi compaiono vengono
eliminate insieme alle loro foto, e l'app ti avvisa prima. Il backup non è cifrato, non contiene alcun identificativo
e non include mai la tua chiave API né alcuna foto. Ciò che ne fai dopo (salvarlo nel tuo cloud, inviarlo in un
messaggio...) è al di fuori dell'app. Tieni presente che, a seconda del sistema, gli appunti possono essere visibili
alla tua tastiera o ad altre app.

«Condividi il file di backup» (Opzioni → I tuoi dati → File di backup) crea un file ZIP con quello stesso backup e, in
più, le foto del tuo diario, dei tuoi campioni reali e delle tue ricette di sfumatura, lo scrive nella cartella temporanea (cache) dell'app e apre il menu di condivisione del
sistema perché tu lo salvi in File, Drive o nell'app che scegli: va solo dove lo mandi tu, e l'app elimina i file di
backup precedenti di quella cartella quando crea il successivo. «Ripristina da file» apre il selettore di documenti del
sistema, che non ha bisogno di alcuna autorizzazione (il selettore lascia una copia del file scelto nella cache
dell'app, e l'app la elimina quando ha finito); il file viene controllato per intero prima di scrivere qualsiasi cosa
e l'app ti chiede conferma, perché sostituisce i tuoi dati attuali, foto comprese, ed elimina le foto che non sono nel
file. Nessun backup, né quello degli appunti né il file, include la tua chiave API.

L'app ricorda inoltre, solo sul tuo telefono, la data in cui hai salvato l'ultimo file di backup, per mostrartela e
suggerirti un nuovo backup quando sono passati più di 30 giorni. Questa data non fa parte di nessun backup.

### Registro degli errori
Se l'app incontra un errore imprevisto, scrive una breve annotazione in un file della sua memoria privata, sul tuo
telefono, perché il problema possa essere individuato e corretto. Ogni annotazione contiene l'ora, la versione dell'app,
la piattaforma e la versione del sistema, il punto dell'app in cui l'errore è stato intercettato, la prima riga del
messaggio di errore (al massimo 300 caratteri) e una traccia tecnica abbreviata del codice (stack trace). Prima di
salvare un'annotazione, l'app sostituisce i parametri degli indirizzi web, i token e le chiavi, gli indirizzi e-mail e i
nomi delle cartelle che identificano l'app o l'utente del dispositivo. Il registro è pensato per dati tecnici, non per i
tuoi contenuti, anche se un messaggio di errore può talvolta includere un frammento di ciò che l'app stava elaborando in
quel momento. Il file ha un limite di circa 200 KB e viene conservato un solo file precedente; le annotazioni più
vecchie vengono scartate. Il registro **non lascia mai il telefono da solo**: non viene caricato nulla e l'app non usa
alcun servizio di segnalazione degli arresti anomali. In Opzioni → Informazioni, «Condividi il registro degli errori»
consegna il file, solo quando lo tocchi, all'app che scegli nel menu di condivisione del sistema, e va solo dove lo
mandi tu; «Cancella il registro degli errori» lo elimina, insieme al file precedente. Su Android è escluso dal backup
nel cloud e dal trasferimento tra dispositivi, come il resto dei dati dell'app; su iPhone può rientrare nel backup del
dispositivo o di iCloud, anche in questo caso come il resto dei dati dell'app.

### IA facoltativa
È **disattivata per impostazione predefinita** (Opzioni → Assistente IA → Suggerisci con l’IA). Quando è disattivata, l'app
non apre alcuna connessione di rete e non chiama ML Kit. Se la attivi, l'app ti mostra prima cosa uscirebbe dal telefono
e puoi scegliere tra:

- **Teoria del colore (motore locale):** senza IA e senza rete.
- **Sul dispositivo (Gemini Nano, su Android compatibili, tramite ML Kit di Google):** il tuo scenario e i codici colore
  vengono elaborati sul tuo telefono e non vengono inviati da nessuna parte. Quando attivi l'IA, l'app usa ML Kit per
  verificare se Gemini Nano è disponibile e, se scegli questa opzione, per scaricarlo e generare i suggerimenti. Durante
  l'uso, **ML Kit invia a Google**, tramite HTTPS e in blocchi (all'incirca una volta al giorno), dati diagnostici e di
  utilizzo: informazioni sul dispositivo (produttore, modello, versione e build del sistema), sull'app (nome del
  pacchetto e versione), identificativi del dispositivo e altri, compresi identificativi per installazione, metriche
  sulle prestazioni, la configurazione dell'API, la dimensione dell'input e dell'output, la versione della funzionalità,
  il tipo di evento, codici di errore e le lingue configurate. Google dichiara di usarli per la diagnostica e l'analisi
  dell'utilizzo e di non trasferirli a terzi (https://developers.google.com/ml-kit/android-data-disclosure). Questo
  invio non include il contenuto delle tue richieste, i tuoi colori né le tue foto, solo la loro dimensione. Lo
  sviluppatore non riceve questi dati: li tratta Google secondo i propri termini e la propria informativa sulla privacy
  (https://policies.google.com/privacy). Se il modello non è sul telefono, Android lo scarica una volta tramite i
  servizi Google; questo download e il modello sono disciplinati dai termini di Google. Su iPhone non si
  usa ML Kit: lì l'IA sul dispositivo è Apple Intelligence (vedi il punto successivo).
- **Su iPhone (Apple Intelligence, con iOS 26 o successivo su un iPhone compatibile):** il tuo scenario e i codici colore
  vengono elaborati sul telefono dal modello di Apple incluso in Apple Intelligence, tramite il framework Foundation
  Models di Apple. L'app non scarica il modello (lo installa e lo gestisce iOS), non usa altri servizi per questa opzione
  e non invia nulla: né le tue richieste, né i tuoi colori, né le tue foto.
- **OpenRouter con la tua chiave:** solo se scegli OpenRouter, salvi la tua chiave e tocchi «Suggerisci con l’IA» in
  «Palette», l'app invia, **dal tuo telefono direttamente a `openrouter.ai`, tramite HTTPS e con la tua chiave e il tuo
  account**: il marchio (identificativo e nome), la modalità della palette, il nome della scena (in inglese), il codice
  e il nome del pennarello di base (se presente) e se è bloccato, la dimensione della palette, i codici e i colori
  esadecimali del catalogo dei pennarelli candidati della tua collezione (non i loro nomi), le impostazioni di
  generazione (modello, temperatura e limite di lunghezza), istruzioni fisse dell'app e l'intestazione
  `X-Title: Ink Lab`. Per mostrarti i modelli disponibili, l'app consulta il catalogo di OpenRouter (con la tua chiave,
  se l'hai salvata). Non vengono **mai** inviati foto (la richiesta indica che non contiene immagini e l'app non ha modo
  di allegarne una), i tuoi colori personali, i tuoi preferiti, le tue palette salvate né tuoi identificativi. Come in
  qualsiasi connessione a Internet, OpenRouter e il fornitore del modello vedono l'indirizzo IP del tuo dispositivo.
  Ricevono questa richiesta e applicano i **propri** termini e le proprie informative sulla privacy, anche riguardo alla
  durata della conservazione, che puoi leggere su https://openrouter.ai/privacy. Lo sviluppatore non la vede, non passa
  da nessun suo server e l'app non la salva.

La tua chiave di OpenRouter viene salvata nell'archivio sicuro del sistema (Android Keystore o Portachiavi di iOS, solo
su questo dispositivo). Non viene inviata allo sviluppatore, non è inclusa nei backup e puoi eliminarla in «Opzioni»
quando vuoi. Se l'IA non funziona, l'app torna alla teoria del colore.

### Autorizzazioni
L'app chiede l'autorizzazione per **fotocamera o foto** solo quando usi «Abbina», «Da una foto» o «Il mio colore», o
aggiungi una foto al «Diario», a un campione reale o a una ricetta di sfumatura. Su Android dichiara l'accesso a **Internet** e allo **stato della rete** (`INTERNET` e
`ACCESS_NETWORK_STATE`), che vengono usati solo con l'IA attivata: per l'IA facoltativa con OpenRouter e per i dati
diagnostici che ML Kit invia a Google quando usi l'IA sul dispositivo. Non chiede posizione, contatti, calendario,
microfono né notifiche, e non usa l'identificativo pubblicitario. Se condividi una palette, una carta dei campioni o una
voce del diario come immagine, un file di backup o il registro degli errori, viene consegnato solo all'app che scegli
nel menu di condivisione del sistema; l'app non ha bisogno di alcuna autorizzazione per farlo, né per scegliere un file
di backup con il selettore di sistema. La modalità cavalletto, le scorciatoie e la recensione nello store non
richiedono autorizzazioni. Su iPhone, il manifesto della privacy dell'app dichiara, come richiede Apple, che una
libreria usata dall'app (per leggere la propria versione) può consultare la data dei file; lo fa solo con i file
dell'app stessa, nel suo spazio privato (motivo C617.1), e queste informazioni non lasciano il telefono.

### Dati che NON vengono trattati
- L'app non chiede né conserva nome, e-mail, telefono, età né alcun dato di account: non ci sono account. Conosciamo il
  tuo indirizzo e-mail solo se ci scrivi (vedi «Se ci scrivi»).
- Lo sviluppatore non usa strumenti di analisi né report sugli arresti anomali, e non ci sono pubblicità, pubblicità
  personalizzata né tracciamento tra app. L'unica eccezione nell'app sono i dati diagnostici e di utilizzo che ML Kit
  invia a Google quando usi l'IA sul dispositivo (vedi «IA facoltativa»); lo sviluppatore non li riceve. Al di fuori
  dell'app, le nostre risposte e-mail non contengono alcun tracciamento di aperture né di clic (vedi «Se ci scrivi»).
- Il registro degli errori (vedi «Registro degli errori») non è un report sugli arresti anomali: non viene inviato nulla
  in automatico, e lascia il telefono solo se lo condividi tu.
- Non riceviamo le tue foto, le tue collezioni, le tue palette né la tua chiave.

### Se ci scrivi
Puoi scriverci a inklab@mainshai.com. Usiamo il tuo indirizzo e-mail, il tuo nome se lo indichi e ciò che ci racconti
per risponderti e risolvere ciò che ci chiedi. Se eserciti un diritto in materia di protezione dei dati, trattiamo la
tua richiesta per adempiere gli obblighi che ci impone il RGPD (art. 6, paragrafo 1, lettera c)). Se dobbiamo conservare
una conversazione a causa di un reclamo, lo facciamo in base al nostro legittimo interesse ad accertare, esercitare o
difendere un diritto in sede giudiziaria (art. 6, paragrafo 1, lettera f)), per il tempo necessario a tale scopo. Non
inviarci la tua chiave API né backup con dati che non vuoi
condividere: per un malfunzionamento ci bastano dati di prova.

Lungo il percorso intervengono questi fornitori (Cloudflare, Google e Proton anche per i
messaggi inviati a dev@mainshai.com, l'indirizzo usato dalle versioni fino alla 0.6.2):

- **Cloudflare** (Cloudflare, Inc., Stati Uniti) riceve il messaggio sul nostro dominio e lo inoltra subito. Non
  conserva il messaggio, ma conserva un registro tecnico dell'inoltro (mittente, destinatario, oggetto, data e
  risultato). Lo conserva per il periodo stabilito dal suo servizio, che non abbiamo potuto confermare, così come le
  opzioni per cancellarlo; se ci chiedi la cancellazione, inoltreremo la richiesta anche a Cloudflare e ti informeremo
  dell'esito. Cloudflare tratta l'e-mail anche negli Stati Uniti.
- **Google** (Gmail; Google Ireland Limited) è la casella in cui leggiamo il tuo messaggio, ti rispondiamo e conserviamo
  la conversazione. Google può trattare questi dati anche negli Stati Uniti.
- **Proton** (Proton AG, Svizzera) conserva una copia dei messaggi che riceviamo, come backup. Da lì non rispondiamo.
- **Resend** (Plus Five Five, Inc., Stati Uniti) invia le nostre risposte, che partono da inklab@mainshai.com, quindi
  ne tratta il contenuto. Le invia dai suoi server in Irlanda, ma conserva i dati negli Stati Uniti: una copia di ogni
  risposta (che può includere il tuo messaggio, se è citato sotto) e il suo registro di invio (destinatario, oggetto,
  data e se è stato consegnato). Secondo Resend, conserva ogni risposta e il suo registro di invio per 30 giorni
  dall'invio, e i suoi backup vengono conservati per sette giorni. Abbiamo disattivato il tracciamento di aperture e
  clic: le nostre risposte non contengono alcuna immagine di tracciamento e i loro link non vengono modificati. Resend si
  avvale di propri sub-responsabili (per esempio, Amazon Web Services per l'invio), negli Stati Uniti; l'elenco è su
  https://resend.com/legal/subprocessors.

**Brevo, fino al 20 novembre 2026.** Fino a quella data, questa informativa diceva che le risposte partivano tramite
Brevo (Sendinblue SAS, che opera come Brevo, Francia), che aggiunge alle e-mail un'immagine invisibile (un pixel) che
registra se vengono aperte e sostituisce i link con altri suoi, che registrano se vengono cliccati. Prima del passaggio
a Resend, da inklab@mainshai.com sono state inviate tramite Brevo solo e-mail di prova del titolare, nessuna risposta a
chi ci avesse scritto. Brevo conserva il registro di quelle e-mail di prova e lo cancella automaticamente dodici mesi
dopo ogni invio (la cancellazione può richiedere fino a un giorno in più). Chiederemo a Brevo di cancellare prima quella
cronologia e chiuderemo l'account.

**Per quanto tempo li conserviamo.** Conserviamo la conversazione in Gmail e la copia in Proton per un anno al massimo
dall'ultimo messaggio della conversazione, salvo che ci serva conservarle più a lungo per gestire un reclamo o una
contestazione. Facciamo una pulizia ogni tre mesi e a ogni pulizia cancelliamo ciò che compirebbe l'anno prima della
successiva. Secondo Resend, conserva ogni risposta e il suo registro di invio per 30 giorni dall'invio, e i suoi backup
vengono conservati per sette giorni. Quando hai diritto alla cancellazione, eliminiamo i messaggi da Gmail e Proton e
chiediamo a Resend di eliminare le risposte e i registri di invio che conserva ancora (si può fare solo tramite il suo
supporto). Se dobbiamo conservare alcuni dati, ti spiegheremo quali e perché.

Se segnali un suggerimento dell'IA («Segnala questo suggerimento», in «Palette»), l'app apre la tua app di posta con un
messaggio già scritto per inklab@mainshai.com: il motivo che scegli, la versione dell'app, il fornitore e il modello di
IA, il marchio, la modalità o la scena, il codice del pennarello di base e i codici, i ruoli e le motivazioni di quel
suggerimento. Non include mai la tua chiave API né foto. Ci arriva solo se lo invii tu, e lo usiamo per esaminare il
contenuto segnalato e migliorare i suggerimenti. Se non c'è un'app di posta, la segnalazione viene copiata negli appunti
perché tu la incolli.

«Invia un commento» (Opzioni → Informazioni) apre la tua app di posta con un messaggio per inklab@mainshai.com che
riporta già la versione dell'app, la piattaforma e la versione del sistema, e lascia spazio per scrivere. Non viene
inviato nulla se non invii tu l'e-mail, e il registro degli errori non viene allegato. Se non c'è un'app di posta,
l'indirizzo viene copiato negli appunti. Se ci mandi il registro degli errori, lo usiamo solo per individuare e
correggere l'errore.

## 3. Finalità e base giuridica


| Trattamento | Finalità | Base giuridica (RGPD) |
|---|---|---|
| Collezioni, livello d'inchiostro e note, lista dei desideri, colori personali, preferiti, palette, ricette di sfumatura, diario e impostazioni sul tuo telefono | Consentirti di usare l'app e conservare il tuo lavoro | Non li riceviamo: restano sul tuo dispositivo, sotto il tuo controllo |
| Foto di «Abbina», di «Da una foto», di «Il mio colore», del «Diario», di un campione reale o di una ricetta di sfumatura | Trovare i pennarelli più simili, leggere il colore del tuo campione o conservare la foto di un'opera, di un campione o di una ricetta | Viene elaborata (e, nel diario, nel campione reale e nelle ricette, salvata) solo sul tuo telefono, su tua richiesta; non la riceviamo |
| Registro degli errori sul tuo telefono | Individuare e correggere gli errori dell'app | Viene salvato solo sul tuo telefono e non lo riceviamo. Se decidi di mandarcelo: la tua richiesta e il nostro legittimo interesse a correggere l'errore (art. 6, paragrafo 1, lettera f)) |
| Dati diagnostici di ML Kit (solo con l'IA sul dispositivo, su Android) | Diagnostica e analisi dell'utilizzo dell'SDK, secondo Google | Vengono inviati solo se decidi di attivare l'IA facoltativa; li tratta Google in qualità di fornitore di ML Kit, secondo i propri termini e la propria informativa sulla privacy; non li riceviamo |
| IA con OpenRouter (facoltativa) | Generare suggerimenti di palette | Il tuo consenso quando la attivi e usi la tua chiave; il trattamento è effettuato da OpenRouter secondo i suoi termini |
| E-mail di assistenza, commenti e segnalazioni di suggerimenti dell'IA | Rispondere alla tua richiesta ed esaminare il contenuto segnalato | La tua richiesta e il nostro legittimo interesse a darvi seguito (art. 6, paragrafo 1, lettera f)) |
| Richieste di esercizio dei diritti in materia di protezione dei dati | Gestire e documentare la tua richiesta | Adempiere gli obblighi che ci impone il RGPD (art. 6, paragrafo 1, lettera c)) |
| Conservazione di una conversazione a causa di un reclamo | Accertare, esercitare o difendere un diritto in sede giudiziaria | Il nostro legittimo interesse (art. 6, paragrafo 1, lettera f)), per il tempo necessario |

Non prendiamo decisioni automatizzate né elaboriamo profili su di te.

## 4. Chi riceve i dati
L'app non trasmette dati allo sviluppatore. Se attivi l'IA, su Android **Google** riceve i dati diagnostici e di
utilizzo che ML Kit invia quando usi l'IA sul dispositivo. Se usi l'IA con OpenRouter, la richiesta descritta sopra
viene ricevuta da **OpenRouter** e dal **fornitore del modello** che scegli, per tuo conto e con la tua chiave. Se ci
invii un'e-mail di assistenza, un commento, una segnalazione di un suggerimento o il registro degli errori, li riceve il
titolare all'indirizzo inklab@mainshai.com (o dev@mainshai.com, l'indirizzo usato dall'app fino alla versione 0.6.2)
tramite il servizio di posta che scegli. Lungo il percorso intervengono i fornitori spiegati in «Se ci scrivi», ciascuno nel passaggio indicato
dalla tabella:

| Fornitore | A cosa serve | Dove |
|---|---|---|
| Cloudflare, Inc. | Ricevere e inoltrare l'e-mail di assistenza; registro tecnico dell'inoltro | Stati Uniti |
| Google Ireland Limited (Gmail) | Casella dell'e-mail di assistenza | Irlanda; Google LLC può trattare dati negli Stati Uniti |
| Proton AG | Copia di backup dell'e-mail ricevuta | Svizzera |
| Plus Five Five, Inc. (Resend) | Inviare le risposte; copia di ogni risposta e il suo registro di invio per 30 giorni dall'invio (i suoi backup vengono conservati sette giorni); nessun tracciamento di aperture né di clic | Stati Uniti (le e-mail partono dall'Irlanda) |
| Sendinblue SAS (Brevo), RCS Paris 498 019 298 | Fino al 20 novembre 2026, servizio di invio previsto; ha inviato solo e-mail di prova del titolare, il cui registro cancella automaticamente dodici mesi dopo ogni invio, anche se la cancellazione può richiedere fino a un giorno in più | UE (Francia) |

Resend tratta le risposte in qualità di responsabile del trattamento, in base all'accordo sul trattamento dei dati
(art. 28 del RGPD) che si applica a tutti i suoi account (https://resend.com/legal/dpa).

Se condividi il registro degli errori con un'altra persona o un altro servizio, lo riceve solo quel destinatario. Se
valuti l'app nello store, la tua valutazione e la tua recensione le riceve direttamente **Google** o **Apple**, con il
tuo account dello store; non passano dall'app. Lo sviluppatore vede poi solo ciò che lo store pubblica o gli mostra
nella sua console (la valutazione, la recensione e il tuo nome pubblico; su Google Play anche dati tecnici come il
modello del dispositivo e le versioni del sistema e dell'app) e può risponderti lì.

## 5. Trasferimenti internazionali
Per l'e-mail di assistenza, Cloudflare e Google possono trattare dati negli Stati Uniti. Cloudflare, Inc. e Google LLC
aderiscono al quadro UE-USA per la protezione dei dati personali, il Data Privacy Framework (decisione di adeguatezza
della Commissione europea del 10 luglio 2023); l'accordo sul trattamento dei dati di Cloudflare include inoltre clausole
contrattuali tipo. Proton si trova in Svizzera, Paese con una decisione di adeguatezza della Commissione europea. Resend
(Plus Five Five, Inc.) conserva le risposte e il loro registro negli Stati Uniti, anche se l'invio parte dall'Irlanda;
questo trasferimento si basa sull'adesione di Resend al quadro UE-USA per la protezione dei dati personali e sulle
clausole contrattuali tipo della Commissione europea (modulo 2) incluse nel suo accordo sul trattamento dei dati
(https://resend.com/legal/dpa); puoi anche chiederci informazioni all'indirizzo di contatto. Brevo, il servizio di invio
previsto fino al 20 novembre 2026, è un'azienda francese e, secondo la sua documentazione, ospita i dati nell'Unione
europea. Al di fuori dell'e-mail di assistenza, lo sviluppatore non effettua trasferimenti di dati. Se usi l'IA con OpenRouter, la richiesta va al fornitore
che scegli, che può trattarla in altre regioni e secondo i propri termini. Google può trattare i dati diagnostici di ML
Kit in altri Paesi, secondo i propri termini. Lo store in cui valuti l'app (Google Play o l'App Store) può trattare la
tua valutazione e la tua recensione in altri Paesi, secondo i propri termini. Gli altri servizi che decidi di usare
(posta, cloud, destinazione di un testo copiato o di un file o di un'immagine condivisi) sono disciplinati dai
rispettivi termini.

## 6. Per quanto tempo vengono conservati


- **Dati sul tuo telefono:** finché non disinstalli l'app o non ne cancelli i dati dalle impostazioni di sistema (e, se
  del caso, dai testi o file di backup che hai salvato). Le foto del diario, dei campioni e delle ricette vengono
  inoltre eliminate non appena rimuovi la foto, la voce o la ricetta.
- **Registro degli errori:** sul tuo telefono, finché non lo cancelli con «Cancella il registro degli errori», non
  cancelli i dati dell'app o non la disinstalli. Poiché non supera mai circa 200 KB più un file precedente, le
  annotazioni più vecchie vengono scartate man mano.
- **E-mail di assistenza, commenti e registri degli errori che ci mandi:** come spiegato in «Se ci scrivi»: al massimo
  un anno dall'ultimo messaggio della conversazione in Gmail e nella copia di Proton, con una pulizia ogni tre mesi,
  salvo che ci serva conservarli più a lungo per gestire un reclamo o una contestazione. Secondo Resend, conserva ogni risposta e
  il suo registro di invio per 30 giorni dall'invio, e i suoi backup vengono conservati per sette giorni. Non abbiamo
  potuto confermare il periodo del registro tecnico di Cloudflare; su questo registro e su ciò che resta in Brevo, vedi
  «Se ci scrivi».

## 7. I tuoi diritti


Puoi esercitare i tuoi diritti di **accesso, rettifica, cancellazione, opposizione, limitazione del trattamento e
portabilità** scrivendo a inklab@mainshai.com. Ti risponderemo entro un mese.

Non riceviamo i dati salvati sul tuo telefono, quindi non possiamo vederli né cancellarli per te. Puoi cancellarli
disinstallando l'app o cancellandone i dati dalle impostazioni di sistema, e portarli con te con «Esporta» (Opzioni →
Backup; le foto non fanno parte di quel testo) o con «Condividi il file di backup» (che le include). Per ciò che
hai inviato a OpenRouter, esercita i tuoi
diritti nei confronti di OpenRouter e del fornitore del modello; per i dati diagnostici di ML Kit, nei confronti di
Google.

Se ritieni che non abbiamo trattato correttamente i tuoi dati, puoi proporre reclamo all'autorità spagnola per la
protezione dei dati (Agencia Española de Protección de Datos): https://www.aepd.es

## 8. Minori


L'app non è rivolta ai minori di 13 anni (o dell'età minima equivalente nel tuo Paese). Non chiede l'età né raccoglie
dati personali di nessuno, nemmeno dei minori: non ci sono account e i tuoi dati restano sul dispositivo. L'IA con
OpenRouter richiede un account personale presso un terzo, che i minori non devono creare senza il permesso dei genitori
o dei tutori.

## 9. Sicurezza
Non c'è alcun server dello sviluppatore né trasmissione di dati dall'app, salvo con l'IA facoltativa attivata (la
finestra di valutazione la mostra lo store, non l'app; vedi «Recensione nello store»). I tuoi dati si trovano nello
spazio privato dell'app; la tua chiave, nel Keystore o nel Portachiavi; le connessioni a OpenRouter usano HTTPS e non
seguono reindirizzamenti. Proteggere il tuo telefono (blocco schermo, crittografia, niente root né jailbreak) spetta a
te. Il codice è pubblico e chiunque può verificare cosa fa.

## 10. Modifiche a questa informativa


Se cambia ciò che l'app fa con i dati, aggiorneremo questa pagina e la data indicata in alto. Se la modifica è
importante (per esempio, se una funzionalità inviasse dati fuori dal telefono), te lo indicheremo anche all'interno
dell'app e sarebbe attivata solo con il tuo consenso.

## 11. Contatti


inklab@mainshai.com
