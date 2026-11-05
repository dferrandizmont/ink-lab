# Política de privacidade do Ink Lab


Última atualização: 2026-11-05

Tradução de cortesia. Prevalece a [versão espanhola](https://inklab.mainshai.com/es/privacy/).

O Ink Lab é uma aplicação para quem desenha com marcadores de álcool: permite consultar as amostras de cor, associar a
cor de uma fotografia a um marcador da sua coleção e criar paletas com teoria da cor. É uma aplicação independente: não
foi criada, revista nem apoiada pela Ohuhu, pela DecoTime nem por qualquer outra marca.

Resumo: **não tem conta, não existe servidor próprio e os seus dados ficam no seu telemóvel.** A aplicação é totalmente
gratuita e de código aberto, e não inclui análise de utilização própria, anúncios nem rastreio. **Se não ativar a IA, a
aplicação não utiliza a rede.** Se a ativar, no Android a IA no dispositivo utiliza o ML Kit da Google, que envia à
Google dados de diagnóstico e de utilização (nunca os seus pedidos, as suas cores nem as suas fotografias); e, se
escolher o OpenRouter com a sua própria chave, é enviado exatamente o que se explica mais abaixo.

## 1. Responsável pelo tratamento


- Titular: Daniel Mont Ferrandiz
- Correio eletrónico de contacto: inklab@mainshai.com

## 2. Que dados são tratados


### Dados que ficam no seu telemóvel (não os recebemos)
A sua marca ativa, os packs e marcadores que tem, os seus favoritos, a sua lista de desejos, os marcadores que
assinala como secos, as cores próprias que guarda para os seus marcadores, as suas paletas guardadas, o histórico das
suas últimas escolhas ao associar cores, as entradas e as fotografias do seu diário, as suas ideias favoritas e vistas
há pouco e as suas definições são guardados apenas no armazenamento privado da aplicação, no seu dispositivo. De cada
cor própria guarda-se apenas o código hexadecimal, nunca a fotografia de onde a tirou. Os catálogos de marcadores vêm
incluídos na aplicação e tudo funciona sem ligação; «Noutras marcas» (no detalhe de um marcador), a pré-visualização
«Visão das cores» (em «Paleta») e os «Números do diário» são calculados no seu telemóvel com esses catálogos e os seus
dados, sem enviar nada. Não há sincronização nem cópia em nenhum servidor nosso.

A cópia de segurança do sistema Android está **desativada** para esta aplicação: exclui todos os ficheiros da
aplicação da cópia na nuvem e da transferência entre dispositivos, pelo que nem as suas definições, nem a sua chave,
nem os seus dados nem as fotografias do diário saem do telemóvel por essa via. No iPhone, as preferências e as
fotografias do diário podem fazer parte da cópia de segurança do dispositivo ou do iCloud que gere com a sua conta
Apple: é um mecanismo da Apple, sob o seu controlo, e não um envio feito pelo programador.

### Câmara e galeria
Só quando utiliza «Comparar», «A partir de uma foto» (em «Paleta») ou «A minha cor» (no detalhe de um marcador), ou
adiciona uma fotografia a uma entrada do «Diário» (em «Ideias»), e opta por tirar uma fotografia ou escolher uma da
galeria é que a aplicação pede a permissão ou abre o seletor do sistema. A fotografia é descodificada e analisada **no
seu telemóvel**: não é carregada para lado nenhum e nunca é enviada a um fornecedor de IA; salvo no diário (ver
abaixo), também não é guardada. Em «Comparar», da escolha conservam-se apenas a cor amostrada e o marcador associado,
no seu histórico local. Em «A partir de uma foto», extraem-se as suas cores principais para lhe propor marcadores da
sua coleção; a fotografia só é mantida em memória enquanto vê o resultado e, se guardar a paleta, guardam-se os
códigos dos marcadores, nunca a fotografia. Em «A minha cor», toca na amostra pintada na fotografia e apenas a sua cor
é guardada, como código hexadecimal, nunca a fotografia.

### Diário
No separador «Ideias», «Diário» permite-lhe registar as obras que pinta: título, data, sobre o que a pintou, estado,
marcadores usados, paleta associada e notas. As entradas são guardadas no seu telemóvel como os restantes dados. Cada
entrada admite até 4 fotografias, tiradas com a câmara ou escolhidas da galeria, que a aplicação copia reduzidas (no
máximo 2048 píxeis de lado) para a sua pasta privada; a fotografia original da sua galeria não é alterada. Essas
fotografias não são carregadas para lado nenhum nem enviadas às funções de IA (nem ao OpenRouter, nem ao Gemini Nano,
nem ao ML Kit), e são apagadas quando remove a fotografia ou a entrada, e com a aplicação quando a desinstala.
«Partilhar esta entrada» desenha, só quando lhe toca, uma imagem com o título, a data, o estado, a primeira
fotografia, os marcadores usados e as cores da paleta associada, e entrega-a apenas à aplicação que escolher no menu
de partilha do sistema.

### Cópia de segurança
«Exportar» (Definições → Cópia de segurança) gera um texto JSON, não um ficheiro, com as suas definições, as
definições não secretas da IA, a sua coleção, favoritos, lista de desejos, marcadores secos, cores próprias, paletas,
histórico, ideias favoritas e vistas há pouco e as entradas do diário (com os nomes internos dos ficheiros das suas
fotografias, não as fotografias), e **copia-o para a área de transferência** para que o cole onde quiser; «Importar»
recebe-o quando o cola. Ao importar, a cópia substitui os seus dados atuais, incluindo o diário: as entradas que não
constem dela são apagadas juntamente com as suas fotografias, e a aplicação avisa-o antes. A cópia não está cifrada,
não contém nenhum identificador e nunca inclui a sua chave de API nem as fotografias do diário. O que fizer com ele
depois (guardá-lo na sua nuvem, enviá-lo numa mensagem...) fica fora da aplicação. Tenha em conta que, consoante o
sistema, a área de transferência pode ser visível para o seu teclado ou para outras aplicações.

«Guardar cópia num ficheiro» (Definições → Os teus dados → Cópia em ficheiro) cria um ficheiro ZIP com essa mesma
cópia e, além disso, as fotografias do diário, escreve-o na pasta temporária (cache) da aplicação e abre o menu de
partilha do sistema para que o guarde em Ficheiros, Drive ou na aplicação que escolher: só vai para onde o enviar, e a
aplicação apaga os ficheiros de cópia anteriores dessa pasta ao criar o seguinte. «Restaurar de um ficheiro» abre o
seletor de documentos do sistema, que não precisa de nenhuma permissão (o seletor deixa uma cópia do ficheiro
escolhido na cache da aplicação, e a aplicação apaga-a ao terminar); o ficheiro é verificado por inteiro antes de se
escrever o que quer que seja e a aplicação pede-lhe confirmação, porque substitui os seus dados atuais, fotografias
incluídas, e apaga as fotografias do diário que não estejam no ficheiro. Nenhuma cópia, nem a da área de transferência
nem o ficheiro, inclui a sua chave de API.

### IA opcional
Está **desligada por predefinição** (Definições → Assistente de IA → Sugerir com IA). Com ela desligada, a aplicação não abre
nenhuma ligação de rede e não chama o ML Kit. Se a ativar, a aplicação mostra-lhe antes o que sairia do telemóvel e pode
escolher entre:

- **Teoria da cor (motor local):** sem IA e sem rede.
- **No dispositivo (Gemini Nano, em Android compatível, através do ML Kit da Google):** o seu cenário e os códigos de
  cor são processados no seu telefone e não são enviados para lado nenhum. Ao ativar a IA, a aplicação utiliza o ML Kit
  para verificar se o Gemini Nano está disponível e, se escolher esta opção, para o descarregar e gerar as sugestões.
  Quando é utilizado, **o ML Kit envia à Google**, por HTTPS e em lotes (aproximadamente uma vez por dia), dados de
  diagnóstico e de utilização: informações do dispositivo (fabricante, modelo, versão e compilação do sistema), da
  aplicação (nome do pacote e versão), identificadores do dispositivo e outros, incluindo identificadores por
  instalação, métricas de desempenho, a configuração da API, o tamanho da entrada e da saída, a versão da
  funcionalidade, o tipo de evento, códigos de erro e os idiomas configurados. A Google indica que os utiliza para
  diagnóstico e análise de utilização e que não os transfere a terceiros
  (https://developers.google.com/ml-kit/android-data-disclosure). Esse envio não inclui o conteúdo dos seus pedidos, as
  suas cores nem as suas fotografias, apenas o respetivo tamanho. O programador não recebe esses dados: são tratados
  pela Google segundo as suas próprias condições e a sua política de privacidade (https://policies.google.com/privacy).
  Se o modelo não estiver no telemóvel, o Android descarrega-o uma vez através dos serviços da Google; essa
  transferência e o modelo regem-se pelas condições da Google. No iPhone não se usa o ML Kit: a IA no dispositivo é
  o Apple Intelligence (ver o ponto seguinte).
- **No iPhone (Apple Intelligence, no iOS 26 ou posterior e num iPhone compatível):** o seu cenário e os códigos de cor
  são processados no seu telemóvel pelo modelo da Apple que vem com o Apple Intelligence, através da framework
  Foundation Models da Apple. A aplicação não transfere o modelo (o iOS instala-o e gere-o), não usa nenhum outro serviço
  para esta opção e não envia nada: nem os seus pedidos, nem as suas cores, nem as suas fotos.
- **OpenRouter com a sua chave:** só se escolher o OpenRouter, guardar a sua chave e tocar em «Sugerir com IA» em
  «Paleta», a aplicação envia, **a partir do seu telemóvel diretamente para `openrouter.ai`, por HTTPS e com a sua
  própria chave e a sua própria conta**: a marca (identificador e nome), o modo de paleta, o nome da cena (em inglês), o
  código e o nome do marcador base (se existir) e se está fixado, o tamanho da paleta, os códigos e as cores
  hexadecimais do catálogo dos marcadores candidatos da sua coleção (não os seus nomes), as definições de geração
  (modelo, temperatura e limite de comprimento), instruções fixas da aplicação e o cabeçalho `X-Title: Ink Lab`. Para
  lhe mostrar os modelos disponíveis, a aplicação consulta o catálogo do OpenRouter (com a sua chave, se a tiver
  guardado). **Nunca** são enviadas fotografias (o pedido indica que não leva imagem e a aplicação não tem forma de a
  anexar), as suas cores próprias, os seus favoritos, as suas paletas guardadas nem identificadores seus. Como em
  qualquer ligação à Internet, o OpenRouter e o fornecedor do modelo veem o endereço IP do seu dispositivo. Recebem esse
  pedido e aplicam as **suas próprias** condições e políticas de privacidade, incluindo quanto ao tempo durante o qual o
  conservam, que pode ler em https://openrouter.ai/privacy. O programador não o vê, o pedido não passa por nenhum
  servidor seu e a aplicação não o guarda.

A sua chave do OpenRouter é guardada no armazenamento seguro do sistema (Android Keystore ou Porta-chaves do iOS, apenas
neste dispositivo). Não é enviada ao programador, não é incluída nas cópias de segurança e pode apagá-la em «Definições»
quando quiser. Se a IA falhar, a aplicação volta à teoria da cor.

### Permissões
A aplicação pede a permissão de **câmara ou fotografias** apenas quando utiliza «Comparar», «A partir de uma foto» ou
«A minha cor», ou adiciona uma fotografia ao «Diário». No Android declara o acesso à **Internet** e ao **estado da
rede** (`INTERNET` e `ACCESS_NETWORK_STATE`), que só são utilizados com a IA ativada: para a IA opcional com o
OpenRouter e para os diagnósticos que o ML Kit envia à Google quando se utiliza a IA no dispositivo. Não pede
localização, contactos, calendário, microfone nem notificações, e não utiliza o identificador de publicidade. Se
partilhar uma paleta, uma carta de amostras ou uma entrada do diário como imagem, ou um ficheiro de cópia, só é
entregue à aplicação que escolher no menu de partilha do sistema; a aplicação não precisa de nenhuma permissão para
isso, nem para escolher um ficheiro de cópia com o seletor do sistema.

### Dados que NÃO são tratados
- Não pedimos nem guardamos nome, correio eletrónico, telefone, idade nem qualquer dado de conta: não há contas.
- O programador não utiliza análise de utilização nem relatórios de erros, e não há anúncios, publicidade personalizada
  nem rastreio entre aplicações. A única exceção são os dados de diagnóstico e de utilização que o ML Kit envia à Google
  quando utiliza a IA no dispositivo (ver «IA opcional»); o programador não os recebe.
- Não recebemos as suas fotografias, as suas coleções, as suas paletas nem a sua chave.

### Se nos escrever
Pode escrever-nos para inklab@mainshai.com. Trataremos o seu endereço de correio eletrónico e o que nos contar apenas
para lhe responder. Não nos envie a sua chave de API nem cópias de segurança com dados que não queira partilhar: para um
erro bastam-nos dados de teste.

Se reportar uma sugestão da IA («Reportar esta sugestão», em «Paleta»), a aplicação abre a sua aplicação de correio
eletrónico com uma mensagem já escrita para inklab@mainshai.com: o motivo que escolher, a versão da aplicação, o
fornecedor e o modelo de IA, a marca, o modo ou a cena, o código do marcador base e os códigos, papéis e justificações
dessa sugestão. Nunca inclui a sua chave de API nem fotografias. Só nos chega se o enviar, e utilizamo-lo para rever o
conteúdo reportado e melhorar as sugestões. Se não houver aplicação de correio eletrónico, o relatório é copiado para a
área de transferência para que o cole.

## 3. Finalidades e fundamento jurídico


| Tratamento | Finalidade | Fundamento jurídico (RGPD) |
|---|---|---|
| Coleções, lista de desejos, cores próprias, favoritos, paletas, diário e definições no seu telemóvel | Permitir-lhe utilizar a aplicação e conservar o seu trabalho | Não os recebemos: ficam no seu dispositivo, sob o seu controlo |
| Fotografia de «Comparar», de «A partir de uma foto», de «A minha cor» ou do «Diário» | Encontrar os marcadores mais parecidos, ler a cor da sua amostra ou guardar a fotografia de uma obra no seu diário | É processada (e, no diário, guardada) apenas no seu telemóvel, a seu pedido; não a recebemos |
| Diagnósticos do ML Kit (apenas com a IA no dispositivo, no Android) | Diagnóstico e análise de utilização do SDK, segundo a Google | São enviados apenas se decidir ativar a IA opcional; são tratados pela Google enquanto fornecedora do ML Kit, segundo as suas próprias condições e a sua política de privacidade; não os recebemos |
| IA com o OpenRouter (opcional) | Gerar sugestões de paleta | O seu consentimento ao ativá-la e utilizar a sua própria chave; o tratamento é feito pelo OpenRouter segundo as suas condições |
| Mensagens de suporte e relatórios de sugestões da IA | Responder à sua consulta e rever o conteúdo reportado | O seu pedido e o nosso interesse legítimo em atendê-lo (artigo 6.º, n.º 1, alínea f)) |

Não tomamos decisões automatizadas nem definimos perfis sobre si.

## 4. Quem recebe os dados
A aplicação não transmite dados ao programador. Se ativar a IA, no Android a **Google** recebe os dados de diagnóstico e
de utilização que o ML Kit envia quando se utiliza a IA no dispositivo. Se utilizar a IA com o OpenRouter, o pedido
descrito acima é recebido pelo **OpenRouter** e pelo **fornecedor do modelo** que escolher, em seu nome e com a sua
chave. Se enviar uma mensagem de suporte ou um relatório de uma sugestão, recebe-o o titular em inklab@mainshai.com (ou
em dev@mainshai.com, o endereço que a aplicação utilizava até à versão 0.6.2) através do serviço de correio eletrónico
que escolher.

## 5. Transferências internacionais
O programador não realiza transferências de dados. Se utilizar a IA com o OpenRouter, o pedido vai para o fornecedor que
escolher, que pode tratá-lo noutras regiões e segundo as suas próprias condições. A Google pode tratar os diagnósticos
do ML Kit noutros países, segundo as suas próprias condições. Os restantes serviços que decida utilizar (correio
eletrónico, nuvem, destino de um texto copiado ou de um ficheiro ou imagem partilhados) regem-se pelas suas próprias
condições.

## 6. Durante quanto tempo são conservados


- **Dados no seu telemóvel:** até desinstalar a aplicação ou apagar os seus dados nas definições do sistema (e, se for o
  caso, dos textos ou ficheiros de cópia de segurança que tiver guardado). As fotografias do diário são ainda apagadas
  assim que remove a fotografia ou a entrada.
- **Mensagens de suporte:** o tempo necessário para atender a sua consulta e, no máximo, um ano a contar da última
  resposta.

## 7. Os seus direitos


Pode exercer os seus direitos de **acesso, retificação, apagamento, oposição, limitação do tratamento e portabilidade**
escrevendo para inklab@mainshai.com. Responder-lhe-emos no prazo de um mês.

Não recebemos os dados guardados no seu telemóvel, pelo que não os podemos ver nem apagar por si. Pode apagá-los
desinstalando a aplicação ou apagando os seus dados nas definições do sistema, e levá-los consigo com «Exportar»
(Definições → Cópia de segurança; as fotografias do diário não fazem parte desse texto) ou com «Guardar cópia num
ficheiro» (que as inclui). Relativamente ao que tiver enviado ao OpenRouter, exerça os seus direitos junto do
OpenRouter e do fornecedor do modelo; quanto aos diagnósticos
do ML Kit, junto da Google.

Se considerar que não tratámos devidamente os seus dados, pode apresentar reclamação à autoridade espanhola de proteção
de dados (Agencia Española de Protección de Datos): https://www.aepd.es

## 8. Menores


A aplicação não se destina a menores de 13 anos (ou da idade mínima equivalente no seu país). Não pede a idade nem
recolhe dados pessoais de ninguém, incluindo de menores: não há contas e os seus dados ficam no dispositivo. A IA com o
OpenRouter exige uma conta própria num terceiro, que os menores não devem criar sem autorização dos pais ou tutores.

## 9. Segurança
Não há servidor do programador nem transmissão de dados a partir da aplicação, exceto com a IA opcional ativada. Os seus
dados estão no espaço privado da aplicação; a sua chave, no Keystore ou no Porta-chaves; as ligações ao OpenRouter
utilizam HTTPS e não seguem redirecionamentos. Proteger o seu telemóvel (bloqueio de ecrã, cifragem, sem root nem
jailbreak) é da sua responsabilidade. O código é público e qualquer pessoa pode verificar o que faz.

## 10. Alterações a esta política


Se mudar o que a aplicação faz com os dados, atualizaremos esta página e a data acima. Se a alteração for importante
(por exemplo, se alguma funcionalidade enviasse dados para fora do telemóvel), também o indicaremos na aplicação e só
seria ativada com o seu consentimento.

## 11. Contacto


inklab@mainshai.com
