# Informativa sulla privacy di Ink Lab


Ultimo aggiornamento: 2026-11-03

Traduzione di cortesia. Fa fede la [versione spagnola](https://inklab.mainshai.com/es/privacy/).

Ink Lab è un'app per chi disegna con i pennarelli ad alcol: consulta i campioni di colore, abbina il colore di una foto
a un pennarello della tua collezione e crea palette con la teoria del colore. È un'app indipendente: non è stata creata,
verificata né approvata da Ohuhu, DecoTime o qualsiasi altro marchio.

Riepilogo: **non hai un account, non esiste un server nostro e i tuoi dati restano sul tuo telefono.** L'app è
completamente gratuita e open source, e non include strumenti di analisi propri, pubblicità né tracciamento. **Se non
attivi l'IA, l'app non usa la rete.** Se la attivi, su Android l'IA sul dispositivo usa ML Kit di Google, che invia a
Google dati diagnostici e di utilizzo (mai le tue richieste, i tuoi colori o le tue foto); e se scegli OpenRouter con la
tua chiave, viene inviato esattamente ciò che è spiegato più avanti.

## 1. Titolare del trattamento


- Titolare: Daniel Mont Ferrandiz
- E-mail di contatto: inklab@mainshai.com

## 2. Quali dati vengono trattati


### Dati che restano sul tuo telefono (non li riceviamo)
Il tuo marchio attivo, i pack e i pennarelli che possiedi, i tuoi preferiti, la tua lista dei desideri, i pennarelli
che segni come secchi, i colori personali che salvi per i tuoi pennarelli, le tue palette salvate, la cronologia delle
tue ultime scelte nell'abbinamento dei colori, le voci e le foto del tuo diario, le tue idee preferite e viste di
recente e le tue impostazioni sono salvati solo nella memoria privata dell'app, sul tuo dispositivo. Di ogni colore
personale viene salvato solo il codice esadecimale, mai la foto da cui l'hai ricavato. I cataloghi dei pennarelli sono
inclusi nell'app e tutto funziona offline; «In altre marche» (nel dettaglio di un pennarello), l'anteprima «Visione dei
colori» (in «Palette») e i «Numeri del diario» vengono calcolati sul tuo telefono con quei cataloghi e i tuoi dati,
senza inviare nulla. Non c'è alcuna sincronizzazione né copia su un nostro server.

Il backup di sistema di Android è **disattivato** per questa app: esclude tutti i file dell'app dal backup nel cloud e
dal trasferimento tra dispositivi, quindi né le tue impostazioni, né la tua chiave, né i tuoi dati né le foto del
diario lasciano il telefono per questa via. Su iPhone, le preferenze e le foto del diario possono rientrare nel backup
del dispositivo o di iCloud che gestisci con il tuo account Apple: è un meccanismo di Apple, sotto il tuo controllo,
non un invio da parte dello sviluppatore.

### Fotocamera e galleria
Solo quando usi «Abbina», «Da una foto» (in «Palette») o «Il mio colore» (nel dettaglio di un pennarello), o aggiungi
una foto a una voce del «Diario» (in «Idee»), e scegli di scattare una foto o di sceglierne una dalla galleria, l'app
chiede l'autorizzazione o apre il selettore di sistema. La foto viene decodificata e analizzata **sul tuo telefono**:
non viene caricata da nessuna parte e non viene mai inviata a un fornitore di IA; salvo nel diario (vedi sotto), non
viene nemmeno salvata. In «Abbina», della scelta si conservano solo il colore campionato e il pennarello
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

### Copia di backup
«Esporta» (Opzioni → Backup) genera un testo JSON, non un file, con le tue impostazioni, le impostazioni non segrete
dell'IA, la tua collezione, i preferiti, la lista dei desideri, i pennarelli secchi, i colori personali, le palette,
la cronologia, le idee preferite e viste di recente e le voci del diario (con i nomi interni dei file delle loro foto,
non le foto), e lo **copia negli appunti** perché tu lo incolli dove vuoi; «Importa» lo riceve quando lo incolli.
All'importazione, il backup sostituisce i tuoi dati attuali, diario compreso: le voci che non vi compaiono vengono
eliminate insieme alle loro foto, e l'app ti avvisa prima. Il backup non è cifrato, non contiene alcun identificativo
e non include mai la tua chiave API né le foto del diario. Ciò che ne fai dopo (salvarlo nel tuo cloud, inviarlo in un
messaggio...) è al di fuori dell'app. Tieni presente che, a seconda del sistema, gli appunti possono essere visibili
alla tua tastiera o ad altre app.

«Salva il file di backup» (Opzioni → I tuoi dati → File di backup) crea un file ZIP con quello stesso backup e, in
più, le foto del diario, lo scrive nella cartella temporanea (cache) dell'app e apre il menu di condivisione del
sistema perché tu lo salvi in File, Drive o nell'app che scegli: va solo dove lo mandi tu, e l'app elimina i file di
backup precedenti di quella cartella quando crea il successivo. «Ripristina da file» apre il selettore di documenti del
sistema, che non ha bisogno di alcuna autorizzazione (il selettore lascia una copia del file scelto nella cache
dell'app, e l'app la elimina quando ha finito); il file viene controllato per intero prima di scrivere qualsiasi cosa
e l'app ti chiede conferma, perché sostituisce i tuoi dati attuali, foto comprese, ed elimina le foto del diario che
non sono nel file. Nessun backup, né quello degli appunti né il file, include la tua chiave API.

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
  servizi Google; questo download e il modello sono disciplinati dai termini di Google. Su iPhone non ci sono né IA sul
  dispositivo né ML Kit.
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
aggiungi una foto al «Diario». Su Android dichiara l'accesso a **Internet** e allo **stato della rete** (`INTERNET` e
`ACCESS_NETWORK_STATE`), che vengono usati solo con l'IA attivata: per l'IA facoltativa con OpenRouter e per i dati
diagnostici che ML Kit invia a Google quando usi l'IA sul dispositivo. Non chiede posizione, contatti, calendario,
microfono né notifiche, e non usa l'identificativo pubblicitario. Se condividi una palette, una carta dei campioni o
una voce del diario come immagine, o un file di backup, viene consegnato solo all'app che scegli nel menu di
condivisione del sistema; l'app non ha bisogno di alcuna autorizzazione per farlo, né per scegliere un file di backup
con il selettore di sistema.

### Dati che NON vengono trattati
- Non chiediamo né conserviamo nome, e-mail, telefono, età né alcun dato di account: non ci sono account.
- Lo sviluppatore non usa strumenti di analisi né report sugli arresti anomali, e non ci sono pubblicità, pubblicità
  personalizzata né tracciamento tra app. L'unica eccezione sono i dati diagnostici e di utilizzo che ML Kit invia a
  Google quando usi l'IA sul dispositivo (vedi «IA facoltativa»); lo sviluppatore non li riceve.
- Non riceviamo le tue foto, le tue collezioni, le tue palette né la tua chiave.

### Se ci scrivi
Puoi scriverci a inklab@mainshai.com. Tratteremo il tuo indirizzo e-mail e ciò che ci racconti solo per risponderti. Non
inviarci la tua chiave API né backup con dati che non vuoi condividere: per un malfunzionamento ci bastano dati di
prova.

Se segnali un suggerimento dell'IA («Segnala questo suggerimento», in «Palette»), l'app apre la tua app di posta con un
messaggio già scritto per inklab@mainshai.com: il motivo che scegli, la versione dell'app, il fornitore e il modello di
IA, il marchio, la modalità o la scena, il codice del pennarello di base e i codici, i ruoli e le motivazioni di quel
suggerimento. Non include mai la tua chiave API né foto. Ci arriva solo se lo invii tu, e lo usiamo per esaminare il
contenuto segnalato e migliorare i suggerimenti. Se non c'è un'app di posta, la segnalazione viene copiata negli appunti
perché tu la incolli.

## 3. Finalità e base giuridica


| Trattamento | Finalità | Base giuridica (RGPD) |
|---|---|---|
| Collezioni, lista dei desideri, colori personali, preferiti, palette, diario e impostazioni sul tuo telefono | Consentirti di usare l'app e conservare il tuo lavoro | Non li riceviamo: restano sul tuo dispositivo, sotto il tuo controllo |
| Foto di «Abbina», di «Da una foto», di «Il mio colore» o del «Diario» | Trovare i pennarelli più simili, leggere il colore del tuo campione o conservare la foto di un'opera nel tuo diario | Viene elaborata (e, nel diario, salvata) solo sul tuo telefono, su tua richiesta; non la riceviamo |
| Dati diagnostici di ML Kit (solo con l'IA sul dispositivo, su Android) | Diagnostica e analisi dell'utilizzo dell'SDK, secondo Google | Vengono inviati solo se decidi di attivare l'IA facoltativa; li tratta Google in qualità di fornitore di ML Kit, secondo i propri termini e la propria informativa sulla privacy; non li riceviamo |
| IA con OpenRouter (facoltativa) | Generare suggerimenti di palette | Il tuo consenso quando la attivi e usi la tua chiave; il trattamento è effettuato da OpenRouter secondo i suoi termini |
| E-mail di assistenza e segnalazioni di suggerimenti dell'IA | Rispondere alla tua richiesta ed esaminare il contenuto segnalato | La tua richiesta e il nostro legittimo interesse a darvi seguito (art. 6, paragrafo 1, lettera f)) |

Non prendiamo decisioni automatizzate né elaboriamo profili su di te.

## 4. Chi riceve i dati
L'app non trasmette dati allo sviluppatore. Se attivi l'IA, su Android **Google** riceve i dati diagnostici e di
utilizzo che ML Kit invia quando usi l'IA sul dispositivo. Se usi l'IA con OpenRouter, la richiesta descritta sopra
viene ricevuta da **OpenRouter** e dal **fornitore del modello** che scegli, per tuo conto e con la tua chiave. Se invii
un'e-mail di assistenza o una segnalazione di un suggerimento, la riceve il titolare all'indirizzo inklab@mainshai.com
(o dev@mainshai.com, l'indirizzo usato dall'app fino alla versione 0.6.2) tramite il servizio di posta che scegli.

## 5. Trasferimenti internazionali
Lo sviluppatore non effettua trasferimenti di dati. Se usi l'IA con OpenRouter, la richiesta va al fornitore che scegli,
che può trattarla in altre regioni e secondo i propri termini. Google può trattare i dati diagnostici di ML Kit in altri
Paesi, secondo i propri termini. Gli altri servizi che decidi di usare (posta, cloud, destinazione di un testo copiato
o di un file o di un'immagine condivisi) sono disciplinati dai rispettivi termini.

## 6. Per quanto tempo vengono conservati


- **Dati sul tuo telefono:** finché non disinstalli l'app o non ne cancelli i dati dalle impostazioni di sistema (e, se
  del caso, dai testi o file di backup che hai salvato). Le foto del diario vengono inoltre eliminate non appena rimuovi
  la foto o la voce.
- **E-mail di assistenza:** il tempo necessario per gestire la tua richiesta e, al massimo, un anno dall'ultima
  risposta.

## 7. I tuoi diritti


Puoi esercitare i tuoi diritti di **accesso, rettifica, cancellazione, opposizione, limitazione del trattamento e
portabilità** scrivendo a inklab@mainshai.com. Ti risponderemo entro un mese.

Non riceviamo i dati salvati sul tuo telefono, quindi non possiamo vederli né cancellarli per te. Puoi cancellarli
disinstallando l'app o cancellandone i dati dalle impostazioni di sistema, e portarli con te con «Esporta» (Opzioni →
Backup; le foto del diario non fanno parte di quel testo) o con «Salva il file di backup» (che le include). Per ciò che
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
Non c'è alcun server dello sviluppatore né trasmissione di dati dall'app, salvo con l'IA facoltativa attivata. I tuoi
dati si trovano nello spazio privato dell'app; la tua chiave, nel Keystore o nel Portachiavi; le connessioni a
OpenRouter usano HTTPS e non seguono reindirizzamenti. Proteggere il tuo telefono (blocco schermo, crittografia, niente
root né jailbreak) spetta a te. Il codice è pubblico e chiunque può verificare cosa fa.

## 10. Modifiche a questa informativa


Se cambia ciò che l'app fa con i dati, aggiorneremo questa pagina e la data indicata in alto. Se la modifica è
importante (per esempio, se una funzionalità inviasse dati fuori dal telefono), te lo indicheremo anche all'interno
dell'app e sarebbe attivata solo con il tuo consenso.

## 11. Contatti


inklab@mainshai.com
