// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get settingsTitle => 'Definições';

  @override
  String get settingsCollectionGroup => 'A minha coleção';

  @override
  String get settingsDisplayGroup => 'Ecrã';

  @override
  String get settingsDataGroup => 'Os teus dados';

  @override
  String get settingsAiGroup => 'Assistente de IA';

  @override
  String get settingsAiOffByDefault => 'Desativado por predefinição';

  @override
  String get settingsUnavailable =>
      'Os serviços da app não estão disponíveis, por isso não é possível mostrar as definições.';

  @override
  String get settingsBrandTitle => 'Marca';

  @override
  String get settingsBrandSubtitle =>
      'A marca escolhe o catálogo de marcadores com que a app trabalha.';

  @override
  String get settingsPalettesTitle => 'Paletas guardadas';

  @override
  String get settingsClearPalettes => 'Apagar tudo';

  @override
  String get settingsClearPalettesTitle => 'Apagar todas as paletas guardadas?';

  @override
  String get settingsClearPalettesBody =>
      'As paletas guardadas desta marca vão ser apagadas. Não é possível anular.';

  @override
  String get settingsFavoritesTitle => 'Favoritos';

  @override
  String get settingsFavoritesEmpty => 'Ainda não tens nenhuma cor favorita.';

  @override
  String get settingsClearFavorites => 'Apagar tudo';

  @override
  String get settingsClearFavoritesTitle => 'Remover todos os favoritos?';

  @override
  String get settingsClearFavoritesBody =>
      'As cores favoritas desta marca vão ser removidas. Não é possível anular.';

  @override
  String get settingsDeleteFavorite => 'Remover o favorito';

  @override
  String get settingsLabelsTitle => 'Códigos da Ohuhu';

  @override
  String get settingsLabelsSubtitle => 'A Ohuhu mudou os seus códigos em 2023.';

  @override
  String get settingsNewLabels => 'Atuais';

  @override
  String get settingsOldLabels => 'Antigos';

  @override
  String get settingsBothLabels => 'Ambos';

  @override
  String get settingsAppearanceTitle => 'Aspeto';

  @override
  String get settingsAppearanceSystem => 'Sistema';

  @override
  String get settingsAppearanceLight => 'Claro';

  @override
  String get settingsAppearanceDark => 'Escuro';

  @override
  String get settingsBackupSubtitle =>
      'Copia os teus dados (coleção, paletas, diário, histórico e definições) para a área de transferência como texto, para os importares mais tarde. Não inclui as fotos nem a chave da API.';

  @override
  String get settingsExportBackup => 'Exportar';

  @override
  String get settingsImportBackup => 'Importar';

  @override
  String get settingsBackupExported =>
      'Cópia copiada para a área de transferência, sem as fotos';

  @override
  String get settingsBackupImported => 'Cópia importada';

  @override
  String get settingsImportTitle => 'Importar uma cópia';

  @override
  String get settingsImportHint => 'Cola aqui o JSON exportado';

  @override
  String get settingsImportConfirm => 'Importar';

  @override
  String get settingsCancel => 'Cancelar';

  @override
  String get settingsImportConfirmTitle => 'Substituir os teus dados atuais?';

  @override
  String get settingsImportConfirmBody =>
      'A cópia substitui os teus dados atuais: coleção, paletas, diário, histórico e definições. As entradas do diário que não estiverem nela são apagadas com as suas fotos; as fotos nunca fazem parte da cópia.';

  @override
  String get ideasFavoritesChip => 'Favoritas';

  @override
  String get ideasFavoritesEmptyTitle => 'Ainda não há ideias favoritas';

  @override
  String get ideasFavoritesEmptyMessage =>
      'Toca no coração de uma ideia para a guardar aqui.';

  @override
  String get ideasRecentTitle => 'Vistas há pouco';

  @override
  String get settingsBackupFileCaption =>
      'Um ficheiro ZIP com os teus dados e as fotos do diário. Guarda-o em Ficheiros, Drive ou onde quiseres. A chave da API nunca é incluída.';

  @override
  String get settingsBackupTextTitle => 'Copiar como texto (sem fotos)';

  @override
  String get settingsSaveBackupFile => 'Guardar cópia num ficheiro';

  @override
  String get settingsRestoreBackupFile => 'Restaurar de um ficheiro';

  @override
  String get settingsBackupFileSaving => 'A preparar os teus dados e fotos…';

  @override
  String get settingsBackupFileRestoring => 'A restaurar a tua cópia…';

  @override
  String get settingsRestoreConfirmBody =>
      'O ficheiro substitui os teus dados atuais: coleção, paletas, diário, histórico e definições. As fotos do ficheiro também são restauradas. As entradas do diário que não estiverem nele são apagadas com as suas fotos.';

  @override
  String get settingsBackupFileRestored => 'Cópia restaurada, com as fotos';

  @override
  String get settingsBackupFileSaveFailed =>
      'Não foi possível criar o ficheiro da cópia.';

  @override
  String get settingsBackupFileReadFailed => 'Não foi possível ler o ficheiro.';

  @override
  String get settingsBackupFileNotZip =>
      'Esse ficheiro não é uma cópia em ZIP.';

  @override
  String get settingsBackupFileTooLarge =>
      'A cópia é grande demais para o Ink Lab.';

  @override
  String get settingsBackupFileEntryTooLarge =>
      'Uma foto da cópia é grande demais.';

  @override
  String get settingsBackupFileDamaged =>
      'O ficheiro está danificado ou não é uma cópia do Ink Lab.';

  @override
  String get settingsBackupFileUnsupported =>
      'Esta cópia é de uma versão que o Ink Lab não consegue ler.';

  @override
  String get settingsBackupFileNotAPhoto =>
      'Uma foto do ficheiro não é uma imagem JPEG, PNG ou WebP.';

  @override
  String get settingsBackupFileWriteFailed =>
      'Não foi possível guardar as fotos. Os teus dados não mudaram.';

  @override
  String get settingsImportInvalidJson => 'O texto não é um JSON válido.';

  @override
  String get settingsImportInvalidDocument =>
      'O texto não é uma cópia de segurança.';

  @override
  String get settingsAiTitle => 'Assistente de IA';

  @override
  String get settingsAiSubtitle =>
      'A IA só sugere paletas. Nunca altera a tua coleção.';

  @override
  String get settingsAiEnabled => 'Sugerir com IA';

  @override
  String get settingsAiEnabledSubtitleColourTheory =>
      'Escolhe No dispositivo ou OpenRouter abaixo para usar uma IA';

  @override
  String get settingsAiEnabledSubtitleColourTheoryNoOnDevice =>
      'Escolhe OpenRouter abaixo para usar uma IA';

  @override
  String get settingsAiEnabledSubtitleOnDevice => 'Gemini Nano neste telemóvel';

  @override
  String get settingsAiEnabledSubtitleOpenRouter =>
      'Usa a tua própria chave do OpenRouter';

  @override
  String get settingsAiExplainColourTheory =>
      'As paletas vêm do motor de teoria da cor integrado. Sem IA e sem que nada saia do teu telemóvel.';

  @override
  String get settingsAiExplainOnDevice =>
      'O Gemini Nano funciona neste telemóvel e os teus pedidos não saem dele. O ML Kit da Google envia diagnósticos de utilização à Google.';

  @override
  String get settingsAiExplainOpenRouter =>
      'Os pedidos vão para openrouter.ai com a tua própria chave. As fotos nunca são enviadas.';

  @override
  String get settingsAiProvider => 'Fornecedor';

  @override
  String get settingsAiProviderColourTheory => 'Teoria da cor';

  @override
  String get settingsAiProviderOnDevice => 'No dispositivo';

  @override
  String get settingsAiProviderOpenRouter => 'OpenRouter';

  @override
  String get settingsAiTextModel => 'Modelo de texto';

  @override
  String get settingsAiTextModelHint => 'ID do modelo para pedidos de texto';

  @override
  String get settingsAiVisionModel => 'Modelo de visão';

  @override
  String get settingsAiVisionModelHint =>
      'ID do modelo para pedidos com imagem';

  @override
  String get settingsAiTemperature => 'Temperatura';

  @override
  String get settingsAiMaxTokens => 'Máximo de tokens';

  @override
  String get settingsAiAutoFallback => 'Alternativa integrada';

  @override
  String get settingsAiAutoFallbackSubtitle =>
      'Se a IA falhar, responde o motor integrado.';

  @override
  String get settingsAiApiKey => 'Chave de API';

  @override
  String get settingsAiApiKeySubtitle =>
      'A tua própria chave, guardada no armazenamento seguro deste dispositivo.';

  @override
  String get settingsAiApiKeySave => 'Guardar chave';

  @override
  String get settingsAiApiKeyRemove => 'Remover';

  @override
  String get settingsAiApiKeySaved => 'Chave guardada.';

  @override
  String get settingsAiRemoveKeyTitle => 'Remover a chave de API?';

  @override
  String get settingsAiRemoveKeyBody =>
      'A chave é apagada deste dispositivo. As sugestões de IA param até voltares a introduzir uma chave.';

  @override
  String get settingsAiRemoveKeyConfirm => 'Remover';

  @override
  String get settingsAiApiKeyInvalid =>
      'Isso não parece uma chave do OpenRouter. Deve começar por sk-or- e não ter espaços.';

  @override
  String get settingsAiApiKeyUnreadable =>
      'Não foi possível ler a chave guardada. Introduz-la de novo.';

  @override
  String get settingsAiApiKeyStorageError =>
      'Não foi possível guardar a chave. Tenta de novo.';

  @override
  String get settingsAiDisclosureTitle => 'Ativar as sugestões de IA?';

  @override
  String get settingsAiDisclosure =>
      'Com isto ativado, quando pedires uma sugestão ao OpenRouter, a app envia para openrouter.ai e para o fornecedor do modelo, com a tua própria chave de API: a marca, o modo de paleta e a cena, o código e o nome do marcador base e se está fixado, o tamanho da paleta, os códigos e as cores hex dos marcadores candidatos, as definições do modelo e as instruções fixas da app. As fotos nunca são enviadas: esta função não carrega imagens. No Android, a app também pode perguntar ao ML Kit da Google se o Gemini Nano está disponível; o ML Kit envia diagnósticos de utilização à Google. Não é enviado nada enquanto este interruptor estiver desativado.';

  @override
  String get settingsAiDisclosureColourTheory =>
      'Com Teoria da cor selecionada, as paletas vêm do motor integrado: não se usa IA e não saem do teu telemóvel. No Android, a app pode perguntar ao ML Kit da Google se o Gemini Nano está disponível; o ML Kit envia diagnósticos de utilização à Google, nunca as tuas cores nem fotos. Escolhe No dispositivo ou OpenRouter para usar uma IA.';

  @override
  String get settingsAiDisclosureColourTheoryNoOnDevice =>
      'Com Teoria da cor selecionada, as paletas vêm do motor integrado: não se usa IA e não saem do teu telemóvel. No Android, a app pode perguntar ao ML Kit da Google se o Gemini Nano está disponível; o ML Kit envia diagnósticos de utilização à Google, nunca as tuas cores nem fotos. Escolhe OpenRouter para usar uma IA.';

  @override
  String get settingsAiDisclosureConfirm => 'Ativar';

  @override
  String get settingsAiDisclosureCancel => 'Agora não';

  @override
  String get settingsAiDisclosureOnDevice =>
      'Os pedidos No dispositivo (Gemini Nano) são respondidos pelo modelo deste telemóvel: o teu cenário e os códigos de cor nunca saem dele e não é preciso chave. Para verificar, transferir e usar o modelo, a app usa o ML Kit da Google, que envia diagnósticos de utilização à Google (modelo do telemóvel, versão da app, identificadores de instalação, erros e tamanhos), nunca os teus pedidos, cores nem fotos. Não é enviado nada enquanto este interruptor estiver desativado.';

  @override
  String get settingsAiOnDeviceName => 'IA no dispositivo (Gemini Nano)';

  @override
  String get settingsAiOnDevicePrivacy =>
      'Os teus pedidos não saem deste telemóvel. O ML Kit envia diagnósticos de utilização à Google, nunca os teus pedidos, cores nem fotos.';

  @override
  String get settingsAiOnDeviceDownloadable =>
      'O modelo ainda não está neste telemóvel. O Android transfere-o uma vez e guarda-o para todas as apps.';

  @override
  String get settingsAiOnDeviceDownloading => 'A transferir o modelo...';

  @override
  String get settingsAiOnDevicePreparing =>
      'O Android está a preparar o modelo. Pode demorar e esperar por Wi‑Fi e carregamento. Podes sair deste ecrã; a transferência continua em segundo plano.';

  @override
  String get settingsAiEnabledSubtitleOnDeviceIos =>
      'Apple Intelligence neste telemóvel';

  @override
  String get settingsAiExplainOnDeviceIos =>
      'O modelo da Apple funciona neste telemóvel e os teus pedidos não saem dele.';

  @override
  String get settingsAiDisclosureOnDeviceIos =>
      'Os pedidos No dispositivo (Apple Intelligence) são respondidos pelo modelo da Apple neste telemóvel: o teu cenário e os códigos de cor nunca saem dele e não é preciso chave. O iOS instala e gere o modelo com o Apple Intelligence; a app não transfere nada nem usa outro serviço para isso, por isso não é enviado nada.';

  @override
  String get settingsAiOnDeviceNameIos =>
      'IA no dispositivo (Apple Intelligence)';

  @override
  String get settingsAiOnDevicePrivacyIos =>
      'Os teus pedidos não saem deste telemóvel. Não é enviado nada: nem pedidos, nem cores, nem fotos.';

  @override
  String get settingsAiOnDevicePreparingIos =>
      'O iOS está a preparar o modelo do Apple Intelligence. Pode demorar. Podes sair deste ecrã; continua em segundo plano.';

  @override
  String get settingsAiDisclosureIos =>
      'Com isto ativado, quando pedires uma sugestão ao OpenRouter, a app envia para openrouter.ai e para o fornecedor do modelo, com a tua própria chave de API: a marca, o modo de paleta e a cena, o código e o nome do marcador base e se está fixado, o tamanho da paleta, os códigos e as cores hex dos marcadores candidatos, as definições do modelo e as instruções fixas da app. As fotos nunca são enviadas: esta função não carrega imagens. Não é enviado nada enquanto este interruptor estiver desativado.';

  @override
  String get settingsAiDisclosureColourTheoryIos =>
      'Com Teoria da cor selecionada, as paletas vêm do motor integrado: não se usa IA e não saem do teu telemóvel. Escolhe No dispositivo ou OpenRouter para usar uma IA.';

  @override
  String get settingsAiDisclosureColourTheoryNoOnDeviceIos =>
      'Com Teoria da cor selecionada, as paletas vêm do motor integrado: não se usa IA e não saem do teu telemóvel. Escolhe OpenRouter para usar uma IA.';

  @override
  String get settingsAiOnDeviceCheckAgain => 'Verificar de novo';

  @override
  String get settingsAiOnDeviceReady => 'O modelo está pronto neste telemóvel.';

  @override
  String get settingsAiOnDeviceDownload => 'Transferir modelo';

  @override
  String get settingsAiOnDeviceFailed =>
      'A transferência não terminou. Verifica a ligação e tenta de novo.';

  @override
  String get settingsAiTestConnection => 'Testar ligação';

  @override
  String get settingsAiTestingConnection => 'A testar...';

  @override
  String get settingsAiModelsTitle => 'Modelo';

  @override
  String get settingsAiModelsFilterFree => 'Grátis';

  @override
  String get settingsAiModelsFilterPaid => 'Pagos';

  @override
  String get settingsAiModelsFilterBoth => 'Ambos';

  @override
  String get settingsAiModelsLoad => 'Carregar modelos';

  @override
  String get settingsAiModelsEmpty =>
      'Nenhum modelo corresponde a este filtro.';

  @override
  String get settingsAiModelsNeedsKey =>
      'Guarda uma chave para carregar os modelos do OpenRouter.';

  @override
  String get settingsAiPrimaryModel => 'Modelo de texto';

  @override
  String get settingsAiModelNone => 'Sem definir';

  @override
  String get settingsAiModelsPickerHint =>
      'Carrega os modelos e escolhe-os da lista.';

  @override
  String get settingsAiModelSearchHint => 'Procurar modelos';

  @override
  String get settingsAiModelFree => 'Grátis';

  @override
  String get settingsAiModelPaid => 'Pago';

  @override
  String get settingsAiModelsDone => 'Concluído';

  @override
  String get settingsAiModelsNotLoaded =>
      'Carrega primeiro os modelos ou escreve acima um ID de modelo.';

  @override
  String get settingsAiRecommended => 'Recomendados';

  @override
  String get settingsAiFreeModelsNote =>
      'Os modelos gratuitos podem ser lentos ou pouco fiáveis. Os recomendados são económicos e respondem de forma mais constante.';

  @override
  String get settingsAiAllModels => 'Todos os modelos';

  @override
  String get settingsAiRecommendedDefault => 'Predefinição recomendada';

  @override
  String get settingsAiFallbacksTitle => 'Modelos de reserva';

  @override
  String get settingsAboutTitle => 'Acerca de';

  @override
  String get settingsVersion => 'Versão';

  @override
  String get settingsSourceCode => 'Código-fonte';

  @override
  String get settingsPrivacyPolicy => 'Política de privacidade';

  @override
  String get settingsCopyRepository => 'Copiar a ligação';

  @override
  String get settingsRepositoryCopied => 'Ligação copiada';

  @override
  String get settingsDisclaimer =>
      'O Ink Lab é um projeto comunitário independente: não está afiliado, apoiado nem patrocinado pela Ohuhu, pela DecoTime, pela Copic ou pela Finecolour, e usa os códigos, nomes e valores de cor dos seus marcadores apenas como dados factuais de referência.';

  @override
  String get paletteTitle => 'Paleta';

  @override
  String get paletteBaseCodeLabel => 'Código do marcador base';

  @override
  String get paletteBaseCodeHint => 'E08 ou B271';

  @override
  String get paletteScenarioToggle => 'Cenas';

  @override
  String get paletteTypeTitle => 'Tipo de paleta';

  @override
  String get paletteTypeSheetTitle => 'Escolhe o tipo de paleta';

  @override
  String get paletteTypeTheoryGroup => 'Teoria da cor';

  @override
  String get paletteTypeScenesGroup => 'Cenas';

  @override
  String get paletteTypeScenesHint => 'Receitas prontas por motivo';

  @override
  String get paletteTypeDescRecommended => 'Combinações para a tua base';

  @override
  String get paletteTypeDescComplementary => 'Matiz oposto, contraste forte';

  @override
  String get paletteTypeDescAnalogous => 'Matizes vizinhos, calma';

  @override
  String get paletteTypeDescSplitComplementary =>
      'Dois matizes junto ao oposto';

  @override
  String get paletteTypeDescTriad => 'Três matizes equidistantes';

  @override
  String get paletteTypeDescSquare => 'Quatro matizes equidistantes';

  @override
  String get paletteTypeDescRectangle => 'Dois pares complementares';

  @override
  String get paletteTypeDescMonochrome => 'Um matiz, de claro a escuro';

  @override
  String get paletteTypeDescShadow => 'Tons escuros para sombrear';

  @override
  String get paletteTypeDescCustomPalette => 'Constrói-a à mão';

  @override
  String get modeBlendingChain => 'Cadeia de mistura';

  @override
  String get paletteTypeDescBlendingChain => 'De claro a escuro, para misturar';

  @override
  String paletteChainResultTitle(int count) {
    return 'Cadeia de mistura ($count)';
  }

  @override
  String paletteChainStep(int step, String role) {
    return 'Passo $step · $role';
  }

  @override
  String get roleLightest => 'Mais claro';

  @override
  String get roleLighter => 'Claro';

  @override
  String get roleDarker => 'Escuro';

  @override
  String get roleDarkest => 'Mais escuro';

  @override
  String get paletteChainHint =>
      'Trabalha de claro a escuro e sobrepõe cada passo enquanto a tinta ainda está húmida. Suaviza as junções com o misturador incolor, se o tiveres.';

  @override
  String paletteChainShort(int count, int wanted) {
    return 'Só $count dos teus marcadores se misturam bem com esta base, menos dos $wanted que pediste.';
  }

  @override
  String get paletteChainNeedLighter =>
      'Ainda não há cadeia: falta-te um marcador mais claro desta família.';

  @override
  String get paletteChainNeedDarker =>
      'Ainda não há cadeia: falta-te um marcador mais escuro desta família.';

  @override
  String get paletteChainNeedBoth =>
      'Ainda não há cadeia: faltam-te um marcador mais claro e outro mais escuro desta família.';

  @override
  String get paletteChainBaseLightest =>
      'Não tens nada mais claro nesta família, por isso a cadeia começa na tua base.';

  @override
  String get paletteChainBaseDarkest =>
      'Não tens nada mais escuro nesta família, por isso a cadeia termina na tua base.';

  @override
  String get paletteChainOptionsLabel => 'Outras cadeias';

  @override
  String paletteChainOption(int number) {
    return 'Opção $number';
  }

  @override
  String get paletteChainWholeRange => 'Procurar em toda a gama';

  @override
  String paletteChainWholeRangeNote(String brand) {
    return 'A mostrar toda a gama $brand, também marcadores que não tens.';
  }

  @override
  String get paletteChainMyMarkers => 'Voltar aos meus marcadores';

  @override
  String get palettePaintTipChainFirst =>
      'Cobre primeiro toda a zona com a cor mais clara.';

  @override
  String get palettePaintTipChainMiddle =>
      'Sobrepõe o passo anterior enquanto ainda está húmido.';

  @override
  String get palettePaintTipChainLast =>
      'Termina com o mais escuro só onde cai a sombra.';

  @override
  String get swatchesBlendingChain => 'Cadeia de mistura';

  @override
  String paletteTypeSemantic(String value) {
    return 'Tipo de paleta, $value';
  }

  @override
  String get paletteSceneTitle => 'Cena';

  @override
  String get paletteSceneSheetTitle => 'Escolhe uma cena';

  @override
  String get paletteSceneSearchHint => 'Procura cena ou categoria';

  @override
  String get paletteSceneEmpty => 'Nenhuma cena corresponde à pesquisa.';

  @override
  String paletteSceneSemantic(String value) {
    return 'Cena, $value';
  }

  @override
  String get paletteFromPhotoTitle => 'A partir de uma foto';

  @override
  String get paletteFromPhotoHint => 'A tua foto e os marcadores';

  @override
  String get paletteFromPhotoValue => 'A tua foto';

  @override
  String paletteFromPhotoRole(int percent) {
    return 'Cor da foto · $percent %';
  }

  @override
  String get paletteFromPhotoEmpty => 'Não foi possível tirar cores desta foto';

  @override
  String get paletteFromPhotoFarNote =>
      'Algumas cores da foto não têm um marcador parecido na tua coleção';

  @override
  String get sceneCategoryCharacters => 'Personagens';

  @override
  String get sceneCategorySkin => 'Peles e retratos';

  @override
  String get sceneCategorySkyWater => 'Céus e água';

  @override
  String get sceneCategoryNature => 'Natureza';

  @override
  String get sceneCategoryMaterials => 'Materiais';

  @override
  String get sceneCategoryAnimals => 'Animais e pelo';

  @override
  String get sceneCategoryFood => 'Comida';

  @override
  String get sceneCategoryHolidays => 'Festas e ambientes';

  @override
  String get sceneCategoryInteriors => 'Interiores';

  @override
  String get sceneCategoryPatterns => 'Padrões';

  @override
  String get sceneCategoryFantasy => 'Fantasia';

  @override
  String get paletteSizeTitle => 'Tamanho';

  @override
  String get paletteSizeSemantic => 'Tamanho da paleta';

  @override
  String get paletteGenerateButton => 'Gerar';

  @override
  String get paletteRegenerateButton => 'Gerar de novo';

  @override
  String get paletteClearButton => 'Limpar';

  @override
  String get paletteSuggestAiButton => 'Sugerir com IA';

  @override
  String get paletteSuggestAiLoading => 'A sugerir…';

  @override
  String get paletteAiBadge => 'IA';

  @override
  String get paletteSaveButton => 'Guardar paleta';

  @override
  String get paletteShareButton => 'Partilhar';

  @override
  String get shareFailed => 'Não foi possível partilhar a imagem.';

  @override
  String get paletteOkButton => 'OK';

  @override
  String get paletteBaseMarkerTitle => 'Marcador base';

  @override
  String get paletteVariationsLabel => 'Variações';

  @override
  String get palettePaintPlanTitle => 'Ordem de pintura';

  @override
  String get palettePaintTipBase =>
      'Cobre primeiro a forma geral com a cor base.';

  @override
  String get palettePaintTipShadow => 'Põe esta sombra onde a luz não chega.';

  @override
  String get palettePaintTipHighlight =>
      'Coloca a luz onde incide diretamente.';

  @override
  String get palettePaintTipAccent =>
      'Reserva o acento só para as zonas focais.';

  @override
  String get palettePaintTipSupport =>
      'Usa este tom de apoio para suavizar as transições.';

  @override
  String get paletteSubtitleIdle =>
      'Cria uma paleta com um marcador que tenhas';

  @override
  String get paletteLockButton => 'Fixar';

  @override
  String get paletteUnlockButton => 'Soltar';

  @override
  String get paletteSaveDialogTitle => 'Guardar paleta';

  @override
  String get paletteSaveDialogHint => 'Nome da paleta';

  @override
  String get paletteSaveDialogCancel => 'Cancelar';

  @override
  String get paletteSaveDialogConfirm => 'Guardar';

  @override
  String get paletteSavedTitle => 'Paletas guardadas';

  @override
  String get paletteSavedEmpty =>
      'Ainda não há paletas guardadas para esta marca.';

  @override
  String palettePaintPlanSummary(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count passos',
      one: '1 passo',
    );
    return '$_temp0';
  }

  @override
  String get paletteLoadButton => 'Carregar';

  @override
  String get paletteDeleteButton => 'Apagar';

  @override
  String get paletteDeleteDialogTitle => 'Apagar a paleta?';

  @override
  String get paletteDeleteDialogBody => 'Esta ação não pode ser anulada.';

  @override
  String get paletteAiReportButton => 'Reportar esta sugestão';

  @override
  String get paletteAiReportTitle => 'Reportar esta sugestão';

  @override
  String get paletteAiReportBody =>
      'Diz-nos se a IA escreveu algo ofensivo, inadequado ou errado. Vai abrir-se a tua app de e-mail com o texto da sugestão; tu decides se o envias. A tua chave de API nunca é incluída.';

  @override
  String get paletteAiReportOffensive => 'Ofensiva ou inadequada';

  @override
  String get paletteAiReportWrong => 'Errada ou sem sentido';

  @override
  String get paletteAiReportOther => 'Outra coisa';

  @override
  String get paletteAiReportSend => 'Enviar por e-mail';

  @override
  String get paletteAiReportThanks =>
      'Obrigado, isto ajuda-nos a melhorar as sugestões';

  @override
  String get paletteAiReportCopied =>
      'Não há app de e-mail. O relatório foi copiado: cola-o num e-mail para inklab@mainshai.com';

  @override
  String get paletteAiFellBack =>
      'IA indisponível. A mostrar sugestões locais.';

  @override
  String get paletteEmptyHint =>
      'Escolhe um marcador base para criar uma paleta, ou escolhe Cenas como tipo de paleta.';

  @override
  String get paletteCustomModeHint =>
      'O modo de paleta personalizada é manual: carrega uma paleta guardada ou aplica uma das Ideias.';

  @override
  String get paletteNoSuggestions =>
      'Não foi possível criar nenhuma paleta com a tua coleção. Experimenta outro modo ou junta mais marcadores.';

  @override
  String get palettePickBaseTooltip => 'Escolher entre os teus marcadores';

  @override
  String get palettePickerTitle => 'Escolhe o marcador base';

  @override
  String get palettePickerSearchHint => 'Código ou nome';

  @override
  String get palettePickerEmpty => 'Nenhum marcador corresponde à pesquisa.';

  @override
  String get paletteUndoButton => 'Anular';

  @override
  String paletteBaseReplaced(String code) {
    return '$code é agora a base. A paleta anterior foi substituída.';
  }

  @override
  String paletteIdeaApplied(String title, int count) {
    return 'Paleta de “$title” aplicada ($count marcadores).';
  }

  @override
  String get swatchesTitle => 'Amostras';

  @override
  String get swatchesSearchHint => 'Código, nome ou hex';

  @override
  String get swatchesClearSearch => 'Limpar a pesquisa';

  @override
  String get swatchesAllFilter => 'Todos';

  @override
  String get swatchesFavoritesOnly => 'Favoritos';

  @override
  String get swatchesOwnedOnly => 'Os meus';

  @override
  String get swatchesFilters => 'Filtros';

  @override
  String get swatchesFiltersTitle => 'Filtros';

  @override
  String get swatchesLabelPack => 'Conjunto';

  @override
  String get swatchesLabelLayout => 'Vista';

  @override
  String get swatchesAllPacks => 'Todos os conjuntos';

  @override
  String get swatchesClearFilters => 'Limpar filtros';

  @override
  String get swatchesLoadingSemantics => 'A carregar cores';

  @override
  String get swatchesClosestAlternatives => 'Alternativas próximas';

  @override
  String get swatchesInPacks => 'Em conjuntos';

  @override
  String get swatchesLocation => 'Localização';

  @override
  String get swatchesAddToPalette => 'Juntar à paleta';

  @override
  String get swatchesLayoutGrid => 'Grelha';

  @override
  String get swatchesLayoutList => 'Lista';

  @override
  String get swatchesOwned => 'Tenho';

  @override
  String get swatchesNewLabels => 'Novo';

  @override
  String get swatchesOldLabels => 'Antigo';

  @override
  String get swatchesBothLabels => 'Ambos';

  @override
  String get swatchesLabelMode => 'Nomes';

  @override
  String get swatchesToggleLayout => 'Alternar entre grelha e lista';

  @override
  String get swatchesGridLayout => 'Grelha';

  @override
  String get swatchesListLayout => 'Lista';

  @override
  String get swatchesNewCode => 'Código novo';

  @override
  String get swatchesOldCode => 'Código antigo';

  @override
  String get swatchesNewName => 'Nome novo';

  @override
  String get swatchesOldName => 'Nome antigo';

  @override
  String get swatchesHex => 'Hex';

  @override
  String get swatchesCopyHex => 'Copiar hex';

  @override
  String get swatchesHexCopied => 'Hex copiado para a área de transferência';

  @override
  String get swatchesAddFavorite => 'Adicionar aos favoritos';

  @override
  String get swatchesRemoveFavorite => 'Remover dos favoritos';

  @override
  String get swatchesEmptyNoOwnedTitle => 'Ainda não há marcadores';

  @override
  String get swatchesEmptyNoOwnedBody =>
      'Ainda não juntaste marcadores. Diz à app que conjuntos e marcadores tens.';

  @override
  String get swatchesEmptyNoOwnedAction => 'Configurar a minha coleção';

  @override
  String get swatchesEmptyNoOwnedHint =>
      'Abre as Definições e depois A minha coleção.';

  @override
  String get swatchesEmptySearchTitle => 'Não há cores';

  @override
  String get swatchesEmptySearchBody =>
      'Nenhuma cor desta coleção corresponde à pesquisa.';

  @override
  String get swatchesEmptyFiltersTitle => 'Nada para mostrar';

  @override
  String get swatchesEmptyFiltersBody =>
      'Esta marca não tem cores para os conjuntos e filtros selecionados.';

  @override
  String get swatchesLoading => 'A carregar cores…';

  @override
  String get swatchesLoadFailedTitle => 'Cores indisponíveis';

  @override
  String get swatchesLoadFailedBody =>
      'Não foi possível ler o catálogo de marcadores, por isso não há cores para mostrar.';

  @override
  String get swatchesUnavailable =>
      'Os serviços da app não estão disponíveis, por isso não é possível mostrar as amostras.';

  @override
  String get swatchesVisibleCount => 'Cores';

  @override
  String get swatchesScopeCollection => 'A tua coleção';

  @override
  String get swatchesScopePack => 'Conjunto';

  @override
  String get ideasTitle => 'Ideias';

  @override
  String get ideasHeaderSubtitle => 'Exercícios com os teus marcadores';

  @override
  String get ideasHeaderSubtitleWholeRange =>
      'Exercícios com a paleta tirada de toda a gama';

  @override
  String get ideasSearchHint => 'Procurar ideias';

  @override
  String get ideasCategoryAll => 'Todas';

  @override
  String get ideasApplyButton => 'Usar na Paleta';

  @override
  String get ideasMoreDetails => 'Mais detalhes';

  @override
  String get ideasGuideOnlyNote =>
      'Este exercício usa toda a tua coleção, por isso não tem uma paleta fixa.';

  @override
  String get ideasNoMarkersOther =>
      'Junta em A minha coleção os marcadores que tens para veres uma paleta para esta ideia.';

  @override
  String get ideasCategoriesLabel => 'Categorias';

  @override
  String get ideasEmptyTitle => 'Não há ideias';

  @override
  String get ideasClearFilters => 'Limpar filtros';

  @override
  String get ideasEmptySearch => 'Nenhuma ideia corresponde à pesquisa.';

  @override
  String get ideasNoMarkers => 'Neste momento não há marcadores disponíveis';

  @override
  String get ideasCategoryTechnique => 'Técnicas';

  @override
  String get ideasCategoryColorChallenge => 'Desafios de cor';

  @override
  String get ideasCategoryMood => 'Ambientes';

  @override
  String get ideasCategorySeason => 'Estações';

  @override
  String get ideasDifficultyEasy => 'Fácil';

  @override
  String get ideasDifficultyMedium => 'Média';

  @override
  String get ideasDifficultyHard => 'Difícil';

  @override
  String get ideasFeaturedLabel => 'Ideia do dia';

  @override
  String get ideasOtherMarkersButton => 'Outros marcadores';

  @override
  String get ideasPracticeTitle => 'O que praticas';

  @override
  String get ideasSubjectTitle => 'O que desenhar';

  @override
  String get ideasMarkersTitle => 'Os teus marcadores';

  @override
  String get ideasStepsTitle => 'Passos';

  @override
  String get ideasTipTitle => 'Dica';

  @override
  String get ideasMaterialsTitle => 'Precisas de';

  @override
  String get ideasMaterialPaper =>
      'papel para marcadores com uma folha por baixo';

  @override
  String get ideasMaterialBlender => 'misturador incolor';

  @override
  String get ideasMaterialWhiteGel => 'caneta de gel branca';

  @override
  String get ideasMaterialPigmentLiner => 'fineliner preto de tinta pigmentada';

  @override
  String get ideasMaterialPencil => 'lápis';

  @override
  String get ideasMaterialTape => 'fita de pintor';

  @override
  String get ideasBackLabel => 'Voltar às ideias';

  @override
  String ideasMinutes(int minutes) {
    return '$minutes min';
  }

  @override
  String ideasMissingMarkers(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'À tua coleção faltam $count marcadores para esta ideia.',
      one: 'À tua coleção falta 1 marcador para esta ideia.',
    );
    return '$_temp0';
  }

  @override
  String ideasMarkerSemantic(String role, String code, String name) {
    return '$role: $code $name';
  }

  @override
  String get ideasSmoothFillTitle => 'Preenchimento sem riscos';

  @override
  String get ideasSmoothFillSummary =>
      'Preenche um quadrado com um só marcador sem que se notem os riscos.';

  @override
  String get ideasSmoothFillPractice =>
      'Cobrir uma zona de forma uniforme, a base de qualquer desenho com marcadores.';

  @override
  String get ideasSmoothFillSubject =>
      'Um quadrado de 5 × 5 cm delimitado com fita de pintor e depois uma forma plana simples, como uma folha.';

  @override
  String get ideasSmoothFillTip =>
      'Se o papel começar a fazer bolinhas, pára: está saturado. Deixa secar por completo antes de outra camada.';

  @override
  String get ideasSmoothFillStep1 =>
      'Marca com fita um quadrado de 5 × 5 cm em papel para marcadores e põe uma folha por baixo.';

  @override
  String get ideasSmoothFillStep2 =>
      'Preenche o quadrado com o marcador claro fazendo círculos pequenos que se sobrepõem, sem parar.';

  @override
  String get ideasSmoothFillStep3 =>
      'Trabalha sempre sobre tinta húmida: volta a passar onde ainda brilha, nunca por cima do que está seco.';

  @override
  String get ideasSmoothFillStep4 =>
      'Deixa secar e dá uma segunda camada com o mesmo marcador, na perpendicular à primeira.';

  @override
  String get ideasSmoothFillStep5 =>
      'Repete o quadrado com o marcador mais escuro e compara: nas cores escuras os riscos notam-se mais.';

  @override
  String get ideasSmoothFillStep6 =>
      'Descola a fita devagar para deixar um limite limpo.';

  @override
  String get ideasThreeMarkerBlendTitle => 'Mistura com três marcadores';

  @override
  String get ideasThreeMarkerBlendSummary =>
      'Mistura um marcador claro, um médio e um escuro da mesma família numa bola.';

  @override
  String get ideasThreeMarkerBlendPractice =>
      'Degradar de claro a escuro sem cortes dentro de uma família de cor.';

  @override
  String get ideasThreeMarkerBlendSubject =>
      'Uma bola iluminada de cima, à esquerda, com a sua sombra sobre a mesa.';

  @override
  String get ideasThreeMarkerBlendTip =>
      'Escolhe marcadores de tons próximos: se o salto entre eles for grande, vai ver-se uma linha.';

  @override
  String get ideasThreeMarkerBlendStep1 =>
      'Desenha um círculo com lápis muito leve e marca de onde vem a luz.';

  @override
  String get ideasThreeMarkerBlendStep2 =>
      'Cobre toda a bola com o marcador claro, deixando um ponto de papel branco para o brilho.';

  @override
  String get ideasThreeMarkerBlendStep3 =>
      'Enquanto ainda está húmido, junta o marcador médio na metade da sombra, com traços curvos que sigam a forma.';

  @override
  String get ideasThreeMarkerBlendStep4 =>
      'Junta o marcador escuro só junto ao bordo mais afastado da luz.';

  @override
  String get ideasThreeMarkerBlendStep5 =>
      'Volta a passar nas junções o médio e depois o claro para fundir os saltos.';

  @override
  String get ideasThreeMarkerBlendStep6 =>
      'Suaviza com o misturador incolor qualquer bordo duro à volta do brilho.';

  @override
  String get ideasFlickingTitle => 'Traços rápidos (flicking)';

  @override
  String get ideasFlickingSummary =>
      'Desenha pelo ou erva com traços rápidos que se desvanecem no fim.';

  @override
  String get ideasFlickingPractice =>
      'O flicking: traços rápidos que se afinam, para misturar sem bordos duros.';

  @override
  String get ideasFlickingSubject => 'Um rabo de cavalo ou um tufo de erva.';

  @override
  String get ideasFlickingTip =>
      'Experimenta antes num papel à parte: quanto mais rápido fores, mais fina fica a cauda do traço.';

  @override
  String get ideasFlickingStep1 =>
      'Desenha a lápis as madeixas ou folhas principais como formas simples, sem pormenor.';

  @override
  String get ideasFlickingStep2 =>
      'Cobre cada forma com o marcador claro numa camada plana e deixa secar.';

  @override
  String get ideasFlickingStep3 =>
      'Faz traços rápidos com o marcador médio da raiz para fora: apoia, move depressa e levanta antes de acabar.';

  @override
  String get ideasFlickingStep4 =>
      'Faz o mesmo com o escuro, só a partir da raiz e mais curto, onde as madeixas se sobrepõem.';

  @override
  String get ideasFlickingStep5 =>
      'Com o claro, faz traços das pontas para a raiz para suavizar a passagem entre tons.';

  @override
  String get ideasFlickingStep6 =>
      'Deixa uma faixa da primeira camada onde o pelo apanha a luz.';

  @override
  String get ideasGrayscaleTitle => 'Escala de cinzentos';

  @override
  String get ideasGrayscaleSummary =>
      'Desenha um objeto simples com uma só família de cinzentos para ver como a luz e a sombra criam volume.';

  @override
  String get ideasGrayscalePractice =>
      'Ver a luz e a sombra como degraus de claro a escuro.';

  @override
  String get ideasGrayscaleSubject =>
      'Uma caneca, uma maçã ou um ovo sob um único candeeiro.';

  @override
  String get ideasGrayscaleTip =>
      'Não mistures cinzentos quentes e frios no mesmo objeto: escolhe uma só família.';

  @override
  String get ideasGrayscaleStep1 =>
      'Escolhe um objeto simples e marca a lápis de onde vem a luz.';

  @override
  String get ideasGrayscaleStep2 =>
      'Deixa o brilho com o branco do papel. Nunca pintes por cima.';

  @override
  String get ideasGrayscaleStep3 =>
      'Cobre todo o objeto com o cinzento mais claro e deixa secar.';

  @override
  String get ideasGrayscaleStep4 =>
      'Junta o cinzento seguinte do lado da sombra e funde o bordo enquanto ainda está húmido.';

  @override
  String get ideasGrayscaleStep5 =>
      'Repete com cada cinzento mais escuro, cobrindo de cada vez uma zona mais pequena.';

  @override
  String get ideasGrayscaleStep6 =>
      'Usa o cinzento mais escuro só para a sombra projetada e a linha de contacto sob o objeto.';

  @override
  String get ideasStickerEffectTitle => 'Efeito autocolante';

  @override
  String get ideasStickerEffectSummary =>
      'Faz uma personagem parecer um autocolante recortado, com um bordo de papel branco e um fundo de cor.';

  @override
  String get ideasStickerEffectPractice =>
      'Reservar o branco do papel de propósito.';

  @override
  String get ideasStickerEffectSubject =>
      'Um gato, uma fatia de pizza ou uma estrela de desenho animado.';

  @override
  String get ideasStickerEffectTip =>
      'O branco tem de ser o do papel. O gel branco sobre a tinta fica manchado.';

  @override
  String get ideasStickerEffectStep1 =>
      'Desenha o motivo e, a lápis, um segundo contorno a 3–5 mm por fora: será o bordo do autocolante.';

  @override
  String get ideasStickerEffectStep2 =>
      'Colore o motivo de claro a escuro sem tocar no bordo.';

  @override
  String get ideasStickerEffectStep3 =>
      'Colore o fundo à volta do bordo com uma cor plana, para que o branco se veja.';

  @override
  String get ideasStickerEffectStep4 =>
      'Quando estiver seco, repassa o exterior do bordo com um fineliner ou uma caneta de pincel pretos.';

  @override
  String get ideasStickerEffectStep5 =>
      'Junta uma sombra cinzenta num lado do bordo para o autocolante parecer descolar-se da página.';

  @override
  String get ideasGlossyCherriesTitle => 'Cerejas brilhantes';

  @override
  String get ideasGlossyCherriesSummary =>
      'Faz duas cerejas brilharem com um brilho reservado e uma luz refletida.';

  @override
  String get ideasGlossyCherriesPractice =>
      'Brilhos de bordo nítido e luz refletida, as chaves de uma superfície brilhante.';

  @override
  String get ideasGlossyCherriesSubject =>
      'Duas cerejas com o seu pedúnculo, iluminadas de um lado.';

  @override
  String get ideasGlossyCherriesTip =>
      'Uma superfície brilhante tem brilhos de bordo duro: não os esbatas, deixa o contorno nítido.';

  @override
  String get ideasGlossyCherriesStep1 =>
      'Desenha a lápis as cerejas e a forma de cada brilho: uma mancha alongada e nítida perto do topo.';

  @override
  String get ideasGlossyCherriesStep2 =>
      'Cobre cada cereja com o marcador claro, contornando os brilhos para ficarem com o branco do papel.';

  @override
  String get ideasGlossyCherriesStep3 =>
      'Põe a base em tudo menos numa meia-lua fina junto ao bordo de baixo: é a luz refletida.';

  @override
  String get ideasGlossyCherriesStep4 =>
      'Põe a sombra do lado contrário à luz e funde-a com a base enquanto está húmida.';

  @override
  String get ideasGlossyCherriesStep5 =>
      'Junta o marcador mais escuro numa faixa estreita entre a sombra e a luz refletida.';

  @override
  String get ideasGlossyCherriesStep6 =>
      'Desenha com o cinzento a sombra sobre a mesa e, quando estiver seco, junta um ponto de gel branco em cada brilho.';

  @override
  String get ideasColoredShadowsTitle => 'Sombras de cor';

  @override
  String get ideasColoredShadowsSummary =>
      'Sombreia duas vezes o mesmo limão, uma com cinzento e outra com violeta, e compara-os.';

  @override
  String get ideasColoredShadowsPractice =>
      'Escolher cores de sombra que mantenham o desenho vivo.';

  @override
  String get ideasColoredShadowsSubject =>
      'Dois limões lado a lado sobre uma mesa branca.';

  @override
  String get ideasColoredShadowsTip =>
      'A sombra costuma tender para o oposto da luz: violeta sob o amarelo, azul sob o laranja.';

  @override
  String get ideasColoredShadowsStep1 =>
      'Desenha dois limões iguais, lado a lado, com a luz a chegar pelo mesmo lado.';

  @override
  String get ideasColoredShadowsStep2 =>
      'Colore os dois com o amarelo, deixando um pequeno brilho com o branco do papel.';

  @override
  String get ideasColoredShadowsStep3 =>
      'No primeiro, sombreia com o cinzento o lado escuro e a sombra sobre a mesa.';

  @override
  String get ideasColoredShadowsStep4 =>
      'No segundo, faz o mesmo com o violeta, com suavidade: basta uma camada.';

  @override
  String get ideasColoredShadowsStep5 =>
      'Passa o amarelo pelo bordo da segunda sombra para a fundir.';

  @override
  String get ideasColoredShadowsStep6 =>
      'Olha para eles de longe: a sombra violeta parece mais luminosa e natural junto ao amarelo.';

  @override
  String get ideasStainedGlassTitle => 'Vitral';

  @override
  String get ideasStainedGlassSummary =>
      'Colore os vidros com degradês simples e junta o chumbo no fim.';

  @override
  String get ideasStainedGlassPractice =>
      'Degradês limpos em zonas pequenas; as linhas pretas disfarçam os bordos irregulares.';

  @override
  String get ideasStainedGlassSubject =>
      'Uma rosácea com uma flor ou um sol ao centro.';

  @override
  String get ideasStainedGlassTip =>
      'Se desenhares primeiro as linhas pretas, usa tinta pigmentada resistente ao álcool: a tinta normal esborrata-se com o marcador.';

  @override
  String get ideasStainedGlassStep1 =>
      'Desenha a lápis a janela e divide-a em vidros de tamanhos diferentes.';

  @override
  String get ideasStainedGlassStep2 =>
      'Colore primeiro os vidros da cor principal, cada um em degradê: mais escuro num bordo e mais claro ao centro.';

  @override
  String get ideasStainedGlassStep3 =>
      'Faz o mesmo com a segunda e a terceira cor, deixando secar cada vidro antes de pintar o do lado.';

  @override
  String get ideasStainedGlassStep4 =>
      'Usa o acento só em alguns vidros pequenos para que se destaquem.';

  @override
  String get ideasStainedGlassStep5 =>
      'Quando tudo estiver seco, repassa os bordos com linhas grossas de fineliner ou caneta de pincel pretos.';

  @override
  String get ideasStainedGlassStep6 =>
      'Junta um pequeno traço de gel branco em alguns vidros para sugerir o brilho do vidro.';

  @override
  String get ideasSwatchChartTitle => 'A tua carta de cores';

  @override
  String get ideasSwatchChartSummary =>
      'Testa como fica cada marcador com uma, duas e três camadas.';

  @override
  String get ideasSwatchChartPractice =>
      'Saber como os teus marcadores ficam mesmo no papel, não na tampa.';

  @override
  String get ideasSwatchChartSubject =>
      'Uma grelha com uma linha por marcador, agrupada por famílias de cor.';

  @override
  String get ideasSwatchChartTip =>
      'Faz a carta no papel que usas a sério: o mesmo marcador muda muito de um papel para outro.';

  @override
  String get ideasSwatchChartStep1 =>
      'Desenha uma grelha no papel que costumas usar: uma linha por marcador e quatro quadrados por linha.';

  @override
  String get ideasSwatchChartStep2 =>
      'Preenche o primeiro quadrado com uma camada, o segundo com duas e o terceiro com três, deixando secar entre camadas.';

  @override
  String get ideasSwatchChartStep3 =>
      'No quarto, dá uma camada e levanta parte da tinta com o misturador incolor.';

  @override
  String get ideasSwatchChartStep4 =>
      'Escreve o código por baixo de cada linha, a lápis ou com um fineliner.';

  @override
  String get ideasSwatchChartStep5 =>
      'Usa o separador Amostras para marcar os marcadores que tens e compara-os com a tua carta.';

  @override
  String get ideasOneColorTitle => 'Uma só família de cor';

  @override
  String get ideasOneColorSummary =>
      'Desenha uma cena inteira com quatro marcadores da mesma família de cor.';

  @override
  String get ideasOneColorPractice =>
      'Dar profundidade sobrepondo camadas e escolhendo marcadores mais claros e mais escuros.';

  @override
  String get ideasOneColorSubject =>
      'Uma chávena de chá a fumegar ou uma planta pequena no seu vaso.';

  @override
  String get ideasOneColorTip =>
      'Carregar menos não aclara a cor. Para as zonas claras usa o marcador mais claro ou o misturador incolor.';

  @override
  String get ideasOneColorStep1 =>
      'Escolhe um motivo simples e marca a lápis de onde vem a luz.';

  @override
  String get ideasOneColorStep2 =>
      'Cobre tudo menos os brilhos com o marcador mais claro.';

  @override
  String get ideasOneColorStep3 =>
      'Junta o marcador base nas zonas que não olham para a luz.';

  @override
  String get ideasOneColorStep4 =>
      'Põe o de sombra nas partes mais escuras e funde os bordos enquanto estão húmidos.';

  @override
  String get ideasOneColorStep5 =>
      'Reserva o mais escuro para as sombras de contacto e algum pormenor pequeno.';

  @override
  String get ideasOneColorStep6 =>
      'Para escurecer um tom sem mudar de marcador, dá outra camada do mesmo quando a primeira estiver seca.';

  @override
  String get ideasTwoMarkersTitle => 'Desafio de dois marcadores';

  @override
  String get ideasTwoMarkersSummary =>
      'Só um marcador claro e um escuro, mais nada.';

  @override
  String get ideasTwoMarkersPractice =>
      'Decidir antes de começar o que fica claro e o que fica escuro.';

  @override
  String get ideasTwoMarkersSubject =>
      'Um cogumelo, um gato sentado ou uma casa com telhado.';

  @override
  String get ideasTwoMarkersTip =>
      'Com só dois marcadores, o branco do papel trabalha muito: planeia-o desde o princípio.';

  @override
  String get ideasTwoMarkersStep1 =>
      'Faz primeiro um esboço pequeno e decide que zonas ficam claras e quais escuras.';

  @override
  String get ideasTwoMarkersStep2 =>
      'Cobre tudo menos os brilhos com o marcador claro.';

  @override
  String get ideasTwoMarkersStep3 =>
      'Dá uma segunda camada do claro nas meias-sombras.';

  @override
  String get ideasTwoMarkersStep4 =>
      'Usa o escuro só para as sombras mais profundas e algum pormenor.';

  @override
  String get ideasTwoMarkersStep5 =>
      'Deixa o branco do papel nos pontos de mais luz: é o teu terceiro tom.';

  @override
  String get ideasTwoColorsTitle => 'Duas cores opostas';

  @override
  String get ideasTwoColorsSummary =>
      'Usa duas cores opostas e um cinzento, e mantém-nas separadas.';

  @override
  String get ideasTwoColorsPractice =>
      'Controlar as cores opostas, que ficam sujas quando se misturam.';

  @override
  String get ideasTwoColorsSubject =>
      'Uma laranja sobre uma toalha azul ou uma flor vermelha com folhas verdes.';

  @override
  String get ideasTwoColorsTip =>
      'Duas cores opostas sobrepostas ficam cinzentas ou castanhas. Usa isso só onde queiras uma sombra apagada.';

  @override
  String get ideasTwoColorsStep1 =>
      'Decide que zonas vão de cada cor e mantém-nas em formas separadas.';

  @override
  String get ideasTwoColorsStep2 =>
      'Colore as formas da primeira cor, de claro a escuro.';

  @override
  String get ideasTwoColorsStep3 =>
      'Junta a sua sombra enquanto a primeira camada ainda está húmida.';

  @override
  String get ideasTwoColorsStep4 =>
      'Deixa secar por completo e colore as formas da segunda cor, parando no limite.';

  @override
  String get ideasTwoColorsStep5 =>
      'Junta a sombra da segunda cor da mesma maneira.';

  @override
  String get ideasTwoColorsStep6 =>
      'Usa o cinzento para as sombras que passam de uma cor para a outra.';

  @override
  String get ideasFiftyFiftyTitle => 'Metade quente, metade fria';

  @override
  String get ideasFiftyFiftySummary =>
      'Divide um desenho em dois: cores quentes de um lado e frias do outro.';

  @override
  String get ideasFiftyFiftyPractice =>
      'Perceber como as cores quentes e frias mudam o ambiente do mesmo motivo.';

  @override
  String get ideasFiftyFiftySubject => 'Um rosto ou uma casa partidos ao meio.';

  @override
  String get ideasFiftyFiftyTip =>
      'Os bordos húmidos escorrem uns para os outros: não deixes uma zona quente húmida tocar numa fria húmida.';

  @override
  String get ideasFiftyFiftyStep1 =>
      'Desenha o motivo e uma linha que o divida em dois.';

  @override
  String get ideasFiftyFiftyStep2 =>
      'Colore primeiro a metade quente, de claro a escuro.';

  @override
  String get ideasFiftyFiftyStep3 =>
      'Junta as suas sombras e deixa essa metade secar por completo.';

  @override
  String get ideasFiftyFiftyStep4 =>
      'Colore a metade fria parando a um milímetro da linha e fecha o espaço quando o outro lado estiver seco.';

  @override
  String get ideasFiftyFiftyStep5 =>
      'Junta as sombras frias nos mesmos sítios que na metade quente.';

  @override
  String get ideasFiftyFiftyStep6 =>
      'Usa o cinzento só nos pontos mais escuros, para que as duas metades o partilhem.';

  @override
  String get ideasRandomColorsTitle => 'Cinco marcadores ao acaso';

  @override
  String get ideasRandomColorsSummary =>
      'Desenha o que quiseres com cinco marcadores escolhidos ao acaso da tua coleção.';

  @override
  String get ideasRandomColorsPractice =>
      'Fazer funcionar quaisquer cores controlando os claros e os escuros.';

  @override
  String get ideasRandomColorsSubject =>
      'O que quiseres: um pássaro, um bule ou um monstro.';

  @override
  String get ideasRandomColorsTip =>
      'O claro e o escuro importam mais do que a cor: um desenho com bom contraste funciona com quase quaisquer cores.';

  @override
  String get ideasRandomColorsStep1 =>
      'Olha para os cinco marcadores acima: estão ordenados do mais claro ao mais escuro.';

  @override
  String get ideasRandomColorsStep2 =>
      'Usa o mais claro para as zonas grandes iluminadas.';

  @override
  String get ideasRandomColorsStep3 =>
      'Usa os intermédios para as formas principais.';

  @override
  String get ideasRandomColorsStep4 =>
      'Guarda o mais escuro para as sombras e os contornos.';

  @override
  String get ideasRandomColorsStep5 =>
      'Se duas cores chocarem, separa-as com uma linha fina de papel branco.';

  @override
  String get ideasRandomColorsStep6 =>
      'Toca em Outros marcadores para tirar outra combinação e tenta de novo.';

  @override
  String get ideasUnlikelyColorsTitle => 'Cores inesperadas';

  @override
  String get ideasUnlikelyColorsSummary =>
      'Colore um objeto conhecido com cores que não são as suas.';

  @override
  String get ideasUnlikelyColorsPractice =>
      'Respeitar os claros e escuros para que o objeto se reconheça, seja da cor que for.';

  @override
  String get ideasUnlikelyColorsSubject =>
      'Uma banana, um cão ou o teu próprio ténis.';

  @override
  String get ideasUnlikelyColorsTip =>
      'Se semicerrares os olhos e o desenho se perceber, os claros e escuros estão certos, sejam as cores quais forem.';

  @override
  String get ideasUnlikelyColorsStep1 =>
      'Desenha o objeto do natural ou de uma foto e repara onde ficam as suas zonas claras e escuras.';

  @override
  String get ideasUnlikelyColorsStep2 =>
      'Usa o marcador mais claro onde o objeto real é mais claro.';

  @override
  String get ideasUnlikelyColorsStep3 =>
      'Usa a base onde o objeto real tem os tons médios.';

  @override
  String get ideasUnlikelyColorsStep4 =>
      'Usa o de sombra onde o objeto real é mais escuro.';

  @override
  String get ideasUnlikelyColorsStep5 =>
      'Junta o acento numa zona pequena para atrair o olhar.';

  @override
  String get ideasPastelTitle => 'Tons pastel';

  @override
  String get ideasPastelSummary =>
      'Colore um desenho suave e luminoso com marcadores claros e muito branco do papel.';

  @override
  String get ideasPastelPractice =>
      'Camadas claras e uniformes, e reservar o branco do papel.';

  @override
  String get ideasPastelSubject =>
      'Um cupcake, um coelhinho ou um ramo de flores.';

  @override
  String get ideasPastelTip =>
      'Carregar menos não aclara a cor: escolhe um marcador mais claro.';

  @override
  String get ideasPastelStep1 =>
      'Escolhe um motivo amável e deixa as linhas de lápis muito leves.';

  @override
  String get ideasPastelStep2 =>
      'Decide onde o papel fica branco: os brilhos e parte do fundo.';

  @override
  String get ideasPastelStep3 =>
      'Colore cada zona com um marcador claro numa só camada uniforme, com círculos pequenos.';

  @override
  String get ideasPastelStep4 =>
      'Faz a sombra com uma segunda camada do mesmo marcador, não com uma cor mais escura.';

  @override
  String get ideasPastelStep5 =>
      'Usa o marcador um pouco mais intenso só para as sombras mais pequenas.';

  @override
  String get ideasPastelStep6 =>
      'Suaviza os bordos duros com o misturador incolor.';

  @override
  String get ideasSkinTonesTitle => 'Pele com quatro marcadores';

  @override
  String get ideasSkinTonesSummary =>
      'Colore um rosto com um tom claro, uma base, uma sombra e um blush.';

  @override
  String get ideasSkinTonesPractice =>
      'Misturar a pele com suavidade e usar sombras quentes num rosto.';

  @override
  String get ideasSkinTonesSubject =>
      'Um rosto de três quartos, iluminado de um lado.';

  @override
  String get ideasSkinTonesTip =>
      'As sombras da pele são quentes: evita os cinzentos, sujam o rosto.';

  @override
  String get ideasSkinTonesStep1 =>
      'Desenha o rosto com traço leve e marca as formas de sombra: sob a sobrancelha, junto ao nariz, sob o lábio e no maxilar.';

  @override
  String get ideasSkinTonesStep2 =>
      'Cobre toda a pele com o marcador claro e deixa com o branco do papel os pontos de mais luz da testa, do nariz e da bochecha.';

  @override
  String get ideasSkinTonesStep3 =>
      'Enquanto está húmido, junta o blush nas bochechas, na ponta do nariz e nas orelhas.';

  @override
  String get ideasSkinTonesStep4 =>
      'Põe a base nas formas de sombra e funde os seus bordos com o marcador claro.';

  @override
  String get ideasSkinTonesStep5 =>
      'Usa o de sombra só onde as formas se juntam: sob o queixo, dentro da orelha e nas asas do nariz.';

  @override
  String get ideasSkinTonesStep6 =>
      'Suaviza qualquer linha dura com o marcador claro e não com o misturador incolor, para a pele não ficar manchada.';

  @override
  String get ideasMidnightTitle => 'Noite de luar';

  @override
  String get ideasMidnightSummary =>
      'Uma casinha de noite, iluminada pela lua e por uma janela quente.';

  @override
  String get ideasMidnightPractice =>
      'Planear uma cena noturna: sombras frias e algumas luzes quentes e limpas.';

  @override
  String get ideasMidnightSubject =>
      'Uma casinha de noite com uma janela acesa.';

  @override
  String get ideasMidnightTip =>
      'Não deixes o azul e o amarelo tocarem-se enquanto algum estiver húmido: juntos ficam verdes.';

  @override
  String get ideasMidnightStep1 =>
      'Antes de começar, decide onde estão as luzes: a lua e a janela ficam com o branco do papel.';

  @override
  String get ideasMidnightStep2 =>
      'Colore a janela e um halo suave à volta com o amarelo, e deixa secar por completo.';

  @override
  String get ideasMidnightStep3 =>
      'Cobre o céu e as paredes iluminadas com o azul claro, afastando-te da lua.';

  @override
  String get ideasMidnightStep4 =>
      'Junta o azul base em tudo o que está na sombra, a uns milímetros do halo amarelo.';

  @override
  String get ideasMidnightStep5 =>
      'Escurece o céu para cima e as sombras sob o telhado e as árvores.';

  @override
  String get ideasMidnightStep6 =>
      'Usa o mais escuro para as sombras mais profundas e, quando estiver seco, junta umas estrelas com gel branco.';

  @override
  String get ideasUnderwaterTitle => 'Debaixo do mar';

  @override
  String get ideasUnderwaterSummary =>
      'Raios de sol na água azul à volta de um peixinho.';

  @override
  String get ideasUnderwaterPractice =>
      'Abrir raios de luz com o misturador incolor.';

  @override
  String get ideasUnderwaterSubject =>
      'Um peixe pequeno a nadar sobre um coral.';

  @override
  String get ideasUnderwaterTip =>
      'Experimenta antes os raios num papel à parte: só funcionam enquanto a tinta ainda está ligeiramente húmida.';

  @override
  String get ideasUnderwaterStep1 =>
      'Colore primeiro o peixe e o coral com o acento e deixa-os secar.';

  @override
  String get ideasUnderwaterStep2 =>
      'Cobre a água com o azul claro, parando mesmo antes do peixe.';

  @override
  String get ideasUnderwaterStep3 =>
      'Junta o azul base na metade de baixo e funde-o para cima enquanto está húmido.';

  @override
  String get ideasUnderwaterStep4 =>
      'Escurece o fundo e a zona atrás do peixe para que se destaque.';

  @override
  String get ideasUnderwaterStep5 =>
      'Com os azuis ainda húmidos, abre raios na diagonal desde a superfície com o misturador incolor: empurra a tinta.';

  @override
  String get ideasUnderwaterStep6 =>
      'Junta o mais escuro mesmo no fundo e, quando estiver seco, termina com bolhinhas de gel branco.';

  @override
  String get ideasGalaxyTitle => 'Galáxia';

  @override
  String get ideasGalaxySummary =>
      'Funde as cores luminosas de uma nebulosa num céu escuro e termina com estrelas.';

  @override
  String get ideasGalaxyPractice =>
      'Misturar em húmido e levantar tinta para fazer estrelas.';

  @override
  String get ideasGalaxySubject =>
      'Uma nebulosa sobre a silhueta de uma montanha.';

  @override
  String get ideasGalaxyTip =>
      'Põe poucas estrelas grandes: se houver demasiadas, perde-se a profundidade.';

  @override
  String get ideasGalaxyStep1 =>
      'Usa papel para marcadores que não atravesse e põe uma folha por baixo: este exercício leva muita tinta.';

  @override
  String get ideasGalaxyStep2 =>
      'Começa pelas cores mais claras da nebulosa, em nuvens suaves e irregulares.';

  @override
  String get ideasGalaxyStep3 =>
      'Enquanto ainda estão húmidas, funde a cor média nos seus bordos.';

  @override
  String get ideasGalaxyStep4 =>
      'Preenche o resto do céu com os marcadores mais escuros, avançando para as nuvens, não por cima.';

  @override
  String get ideasGalaxyStep5 =>
      'Dá toques com o misturador incolor sobre o escuro para levantar pontos de tinta: serão estrelas distantes.';

  @override
  String get ideasGalaxyStep6 =>
      'Quando estiver seco, junta algumas estrelas brilhantes e um brilho em cruz com gel branco.';

  @override
  String get ideasNeonTitle => 'Letreiro de néon';

  @override
  String get ideasNeonSummary =>
      'Faz um letreiro brilhar deixando um centro branco e um fundo escuro.';

  @override
  String get ideasNeonPractice =>
      'Fazer brilhar: centro branco, halo intenso e fundo escuro.';

  @override
  String get ideasNeonSubject =>
      'A palavra OPEN ou um coração desenhado como um tubo de néon.';

  @override
  String get ideasNeonTip =>
      'Os marcadores fluorescentes são transparentes: usa-os sobre branco, nunca sobre tinta escura.';

  @override
  String get ideasNeonStep1 =>
      'Desenha a lápis uma palavra ou forma simples com traços grossos.';

  @override
  String get ideasNeonStep2 =>
      'Deixa uma linha fina de papel branco no centro de cada traço: é o núcleo de luz.';

  @override
  String get ideasNeonStep3 =>
      'Colore o resto do traço com a versão clara da tua cor de néon.';

  @override
  String get ideasNeonStep4 =>
      'Faz traços rápidos para fora com a cor intensa para criar um halo suave.';

  @override
  String get ideasNeonStep5 =>
      'Quando o halo estiver seco, preenche o fundo com o marcador mais escuro, parando a uns milímetros do halo.';

  @override
  String get ideasNeonStep6 =>
      'Funde esse espaço com o marcador escuro para que o brilho se apague na noite.';

  @override
  String get ideasSepiaPhotoTitle => 'Foto antiga em sépia';

  @override
  String get ideasSepiaPhotoSummary =>
      'Desenha um retrato ou um edifício como se fosse uma fotografia antiga em tons castanhos.';

  @override
  String get ideasSepiaPhotoPractice =>
      'Trabalhar com uma só família quente de castanhos, como um estudo de claros e escuros em cor.';

  @override
  String get ideasSepiaPhotoSubject =>
      'Uma casa antiga, um chapéu de cowboy ou o retrato de um avô.';

  @override
  String get ideasSepiaPhotoTip =>
      'Evita o preto e os cinzentos frios: quebram o ar quente da foto em sépia.';

  @override
  String get ideasSepiaPhotoStep1 =>
      'Desenha o motivo a lápis e emoldura-o com um bordo que fique com o branco do papel.';

  @override
  String get ideasSepiaPhotoStep2 =>
      'Cobre tudo menos os pontos de mais luz com o castanho mais claro.';

  @override
  String get ideasSepiaPhotoStep3 =>
      'Constrói os tons médios com o castanho base.';

  @override
  String get ideasSepiaPhotoStep4 =>
      'Junta as sombras com o castanho de sombra, fundindo os bordos enquanto estão húmidos.';

  @override
  String get ideasSepiaPhotoStep5 =>
      'Usa o castanho mais escuro em vez do preto para as sombras mais profundas.';

  @override
  String get ideasSepiaPhotoStep6 =>
      'Escurece um pouco os cantos da imagem com o cinzento quente para a envelhecer.';

  @override
  String get ideasSunsetTitle => 'Céu de pôr do sol';

  @override
  String get ideasSunsetSummary =>
      'Funde um céu do amarelo ao violeta e junta uma silhueta escura.';

  @override
  String get ideasSunsetPractice =>
      'Misturar em húmido cores vizinhas numa zona grande.';

  @override
  String get ideasSunsetSubject =>
      'Um pôr do sol sobre o mar com uma palmeira ou os edifícios de uma cidade em contraluz.';

  @override
  String get ideasSunsetTip =>
      'Funde só cores vizinhas: o amarelo junto ao violeta fica acastanhado em húmido.';

  @override
  String get ideasSunsetStep1 =>
      'Desenha a lápis o horizonte e a silhueta; deixa o sol como um círculo de papel branco.';

  @override
  String get ideasSunsetStep2 =>
      'Começa pelo sol: colore uma faixa larga de amarelo à sua volta.';

  @override
  String get ideasSunsetStep3 =>
      'Com o amarelo ainda húmido, junta o laranja por cima e funde a união.';

  @override
  String get ideasSunsetStep4 =>
      'Continua para cima com o rosa, fundindo cada faixa com a anterior enquanto está húmida.';

  @override
  String get ideasSunsetStep5 =>
      'Termina a parte de cima do céu com o violeta.';

  @override
  String get ideasSunsetStep6 =>
      'Quando o céu estiver seco, preenche a silhueta com o marcador mais escuro com traços planos e uniformes.';

  @override
  String get ideasSpringTitle => 'Flor de cerejeira';

  @override
  String get ideasSpringSummary =>
      'Um ramo de cerejeira em flor com pétalas de um rosa suave.';

  @override
  String get ideasSpringPractice =>
      'Pétalas delicadas: camadas claras e bordos suaves.';

  @override
  String get ideasSpringSubject =>
      'Um ramo com cinco ou seis flores e algumas folhas.';

  @override
  String get ideasSpringTip =>
      'As pétalas são finas: duas camadas claras ficam mais delicadas do que uma escura.';

  @override
  String get ideasSpringStep1 =>
      'Desenha o ramo e as flores com traço leve, de cinco pétalas cada uma.';

  @override
  String get ideasSpringStep2 =>
      'Colore cada pétala com o rosa claro, deixando um bordo fino de papel branco em algumas.';

  @override
  String get ideasSpringStep3 =>
      'Junta o rosa base perto do centro de cada flor, com traços rápidos para fora.';

  @override
  String get ideasSpringStep4 =>
      'Toca com o rosa mais intenso só no centro e onde as pétalas se sobrepõem.';

  @override
  String get ideasSpringStep5 => 'Colore as folhas e os rebentos com o verde.';

  @override
  String get ideasSpringStep6 =>
      'Sombreia a parte de baixo das folhas com o verde escuro.';

  @override
  String get ideasAutumnTitle => 'Folhas de outono';

  @override
  String get ideasAutumnSummary =>
      'Uma natureza-morta de folhas caídas com cores quentes e luminosas.';

  @override
  String get ideasAutumnPractice =>
      'Misturar cores quentes vizinhas e deixar as nervuras claras.';

  @override
  String get ideasAutumnSubject =>
      'Três folhas caídas sobre uma mesa: de carvalho, de bordo e de castanheiro.';

  @override
  String get ideasAutumnTip =>
      'Deixa as nervuras como uma linha mais clara: é mais fácil do que desenhá-las por cima depois.';

  @override
  String get ideasAutumnStep1 =>
      'Desenha as folhas e as suas nervuras principais com lápis leve.';

  @override
  String get ideasAutumnStep2 =>
      'Colore a folha mais clara com o amarelo, contornando as nervuras para ficarem claras.';

  @override
  String get ideasAutumnStep3 =>
      'Colore a seguinte com o laranja claro e funde um pouco de amarelo nos bordos enquanto está húmida.';

  @override
  String get ideasAutumnStep4 =>
      'Colore a terceira com a base e funde o laranja claro na ponta.';

  @override
  String get ideasAutumnStep5 =>
      'Junta o vermelho nos bordos e em algumas manchas, como se a folha estivesse a mudar de cor.';

  @override
  String get ideasAutumnStep6 =>
      'Sombreia com o laranja escuro onde as folhas se sobrepõem e onde tocam na mesa.';

  @override
  String get ideasWinterTitle => 'Cabana na neve';

  @override
  String get ideasWinterSummary =>
      'Uma cabana na neve em que o branco é o próprio papel.';

  @override
  String get ideasWinterPractice =>
      'Desenhar neve com sombras cinzento-azuladas e muito papel em branco.';

  @override
  String get ideasWinterSubject =>
      'Uma cabana de madeira com neve no telhado e uma janela acesa.';

  @override
  String get ideasWinterTip =>
      'Não sombreies a neve com cinzento quente: os cinzentos azulados deixam-na fria e limpa.';

  @override
  String get ideasWinterStep1 =>
      'Desenha a lápis a cabana e onde acaba a neve: a neve é o papel branco, por isso planeia-a primeiro.';

  @override
  String get ideasWinterStep2 => 'Colore a janela com o amarelo e deixa secar.';

  @override
  String get ideasWinterStep3 =>
      'Colore as paredes de madeira com o castanho sem tocar na neve do telhado.';

  @override
  String get ideasWinterStep4 =>
      'Sombreia a neve com o cinzento azulado claro só onde a luz não chega.';

  @override
  String get ideasWinterStep5 =>
      'Junta o cinzento azulado mais escuro sob o telhado e nas pegadas, fundindo-o com o claro.';

  @override
  String get ideasWinterStep6 =>
      'Usa o mais escuro para a porta e as sombras mais profundas e, quando estiver seco, junta flocos a cair com gel branco.';

  @override
  String get ideasChristmasTitle => 'Bolas de Natal';

  @override
  String get ideasChristmasSummary =>
      'Bolas vermelhas brilhantes penduradas num ramo verde de abeto.';

  @override
  String get ideasChristmasPractice =>
      'Formas redondas e brilhantes com um brilho reservado e reflexos.';

  @override
  String get ideasChristmasSubject =>
      'Duas bolas vermelhas penduradas num ramo de abeto.';

  @override
  String get ideasChristmasTip =>
      'Desenha o ramo depois das bolas, para que o verde nunca entre no vermelho.';

  @override
  String get ideasChristmasStep1 =>
      'Desenha as bolas e planeia em cada uma um brilho em forma de janela.';

  @override
  String get ideasChristmasStep2 =>
      'Cobre cada bola com o vermelho claro, contornando o brilho.';

  @override
  String get ideasChristmasStep3 =>
      'Junta o vermelho base num anel que siga a forma redonda, deixando o centro mais claro.';

  @override
  String get ideasChristmasStep4 =>
      'Escurece o bordo mais afastado da luz e deixa um filete mais claro para o reflexo.';

  @override
  String get ideasChristmasStep5 =>
      'Faz as agulhas do ramo com o verde, com traços rápidos do caule para fora.';

  @override
  String get ideasChristmasStep6 =>
      'Junta o verde escuro onde as agulhas se sobrepõem e, quando estiver seco, um brilho de gel branco em cada bola.';

  @override
  String get ideasHalloweenTitle => 'Abóbora de Halloween';

  @override
  String get ideasHalloweenSummary =>
      'Uma abóbora esculpida que brilha numa noite violeta escura.';

  @override
  String get ideasHalloweenPractice =>
      'A luz que sai de dentro de um objeto, sobre um fundo escuro.';

  @override
  String get ideasHalloweenSubject =>
      'Uma abóbora esculpida com uma vela dentro, à porta de uma casa.';

  @override
  String get ideasHalloweenTip =>
      'Põe o fundo escuro no fim e devagar perto do bordo: a tinta escura escorre para as zonas claras.';

  @override
  String get ideasHalloweenStep1 =>
      'Desenha a abóbora e a sua cara esculpida; o interior da cara será a parte mais luminosa.';

  @override
  String get ideasHalloweenStep2 =>
      'Colore os buracos esculpidos com o laranja claro, deixando um centro branco.';

  @override
  String get ideasHalloweenStep3 =>
      'Colore a abóbora com o laranja base, seguindo os gomos com traços curvos.';

  @override
  String get ideasHalloweenStep4 =>
      'Sombreia as reentrâncias entre os gomos e o lado mais afastado do brilho.';

  @override
  String get ideasHalloweenStep5 => 'Colore o caule com o verde.';

  @override
  String get ideasHalloweenStep6 =>
      'Quando tudo estiver seco, preenche a noite com o violeta escuro, começando a uns milímetros da abóbora.';

  @override
  String get ideasRoleLight => 'Luz';

  @override
  String get ideasReasonLight => 'Primeira camada, quase sobre tudo';

  @override
  String get ideasRoleLightMid => 'Médio claro';

  @override
  String get ideasReasonLightMid =>
      'Segundo degrau, suaviza a passagem para a base';

  @override
  String get ideasRoleBase => 'Base';

  @override
  String get ideasReasonBase => 'Cor principal das formas';

  @override
  String get ideasRoleShadow => 'Sombra';

  @override
  String get ideasReasonShadow => 'Onde a luz não chega';

  @override
  String get ideasRoleDeepShadow => 'Sombra profunda';

  @override
  String get ideasReasonDeepShadow =>
      'Só os recantos mais escuros e as linhas de contacto';

  @override
  String get ideasRoleShadowGray => 'Cinzento de sombra';

  @override
  String get ideasReasonShadowGray => 'Sombras neutras e sombras projetadas';

  @override
  String get ideasRoleAccent => 'Acento';

  @override
  String get ideasReasonAccent => 'Toques pequenos que atraem o olhar';

  @override
  String get ideasRoleBackground => 'Fundo';

  @override
  String get ideasReasonBackground => 'À volta do motivo, no fim';

  @override
  String get ideasRoleMainColor => 'Cor principal';

  @override
  String get ideasReasonMainColor => 'Primeira cor do par';

  @override
  String get ideasRoleMainShadow => 'Sombra principal';

  @override
  String get ideasReasonMainShadow => 'Sombra da primeira cor';

  @override
  String get ideasRoleSecondColor => 'Segunda cor';

  @override
  String get ideasReasonSecondColor => 'Segunda cor do esquema';

  @override
  String get ideasRoleSecondShadow => 'Segunda sombra';

  @override
  String get ideasReasonSecondShadow => 'Sombra da segunda cor';

  @override
  String get ideasRoleThirdColor => 'Terceira cor';

  @override
  String get ideasReasonThirdColor => 'Terceira cor do esquema';

  @override
  String get ideasRoleBlush => 'Blush';

  @override
  String get ideasReasonBlush =>
      'Bochechas, nariz e orelhas, misturado em húmido';

  @override
  String get ideasRoleWarmLight => 'Luz quente';

  @override
  String get ideasReasonWarmLight => 'Zonas iluminadas da metade quente';

  @override
  String get ideasRoleWarmShadow => 'Sombra quente';

  @override
  String get ideasReasonWarmShadow => 'Sombras da metade quente';

  @override
  String get ideasRoleCoolLight => 'Luz fria';

  @override
  String get ideasReasonCoolLight => 'Zonas iluminadas da metade fria';

  @override
  String get ideasRoleCoolShadow => 'Sombra fria';

  @override
  String get ideasReasonCoolShadow => 'Sombras da metade fria';

  @override
  String get ideasRoleColorShadow => 'Sombra de cor';

  @override
  String get ideasReasonColorShadow =>
      'Uma sombra de cor para comparar com a cinzenta';

  @override
  String get matchTitle => 'Comparar';

  @override
  String get matchPrivacyCaption => 'As fotos ficam neste telemóvel.';

  @override
  String get matchCameraButton => 'Câmara';

  @override
  String get matchGalleryButton => 'Galeria';

  @override
  String get matchLoadingPhoto => 'A ler a foto…';

  @override
  String get matchEmptyPhotoTitle => 'Ainda não há foto';

  @override
  String get matchEmptyPhotoMessage =>
      'Tira uma foto ou escolhe uma da galeria para encontrar o marcador mais próximo.';

  @override
  String get matchPhotoSemantics => 'Foto da qual tirar uma cor';

  @override
  String get matchPickToSample =>
      'Toca ou arrasta sobre a foto para tirar uma cor.';

  @override
  String get matchSampledLabel => 'Cor tirada';

  @override
  String get matchBestMatchTitle => 'Melhor correspondência';

  @override
  String get matchAlternatesTitle => 'Alternativas';

  @override
  String get matchSaveButton => 'Guardar';

  @override
  String get matchRecentTitle => 'Escolhas recentes';

  @override
  String get matchRecentDetailSampled => 'Cor tirada';

  @override
  String get matchRecentEmpty =>
      'Ainda não há escolhas recentes. Toca numa correspondência para a guardar aqui.';

  @override
  String get matchClearButton => 'Limpar';

  @override
  String get matchRemoveTooltip => 'Remover';

  @override
  String get matchCloseTooltip => 'Fechar';

  @override
  String get matchRecentPickLabel => 'Escolha recente';

  @override
  String get matchClearDialogTitle => 'Limpar as escolhas recentes?';

  @override
  String get matchClearDialogBody =>
      'Todas as escolhas guardadas são removidas. Não é possível anular.';

  @override
  String get matchCancelButton => 'Cancelar';

  @override
  String get matchCancelNotice => 'Nenhuma foto selecionada.';

  @override
  String get matchCameraDenied =>
      'O acesso à câmara está desativado. Ativa-o nas definições do dispositivo ou escolhe uma foto da galeria.';

  @override
  String get matchGalleryDenied =>
      'O acesso às fotos está desativado. Ativa-o nas definições do dispositivo e tenta de novo.';

  @override
  String get matchDecodeFailed =>
      'Não foi possível ler essa foto. Experimenta outra.';

  @override
  String get matchPickFailed => 'Não foi possível abrir a foto. Tenta de novo.';

  @override
  String get matchOkButton => 'OK';

  @override
  String get appTitle => 'Ink Lab';

  @override
  String get commonOk => 'OK';

  @override
  String get commonOwned => 'Tenho';

  @override
  String get commonFavourite => 'Favorito';

  @override
  String get commonAddToFavourites => 'Adicionar aos favoritos';

  @override
  String get commonRemoveFromFavourites => 'Remover dos favoritos';

  @override
  String get commonClearSearch => 'Limpar pesquisa';

  @override
  String get commonClose => 'Fechar';

  @override
  String get commonMoreActions => 'Mais ações';

  @override
  String commonQualityLine(double value, String quality) {
    final intl.NumberFormat valueNumberFormat =
        intl.NumberFormat.decimalPatternDigits(
          locale: localeName,
          decimalDigits: 1,
        );
    final String valueString = valueNumberFormat.format(value);

    return 'ΔE $valueString · $quality';
  }

  @override
  String get commonBaseLocked => 'Base fixada';

  @override
  String commonDeltaE(double value) {
    final intl.NumberFormat valueNumberFormat =
        intl.NumberFormat.decimalPatternDigits(
          locale: localeName,
          decimalDigits: 1,
        );
    final String valueString = valueNumberFormat.format(value);

    return 'ΔE $valueString';
  }

  @override
  String commonRgb(int r, int g, int b) {
    return 'RGB $r $g $b';
  }

  @override
  String commonOldCode(String code) {
    return 'Antigo $code';
  }

  @override
  String commonMarkersAvailable(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count marcadores disponíveis',
      one: '1 marcador disponível',
    );
    return '$_temp0';
  }

  @override
  String commonColorCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count cores',
      one: '1 cor',
    );
    return '$_temp0';
  }

  @override
  String commonCardLocation(int number) {
    return 'Carta de cores $number';
  }

  @override
  String navTabHint(int index, int count) {
    return 'Separador $index de $count';
  }

  @override
  String get settingsLanguageTitle => 'Idioma';

  @override
  String get settingsLanguageSystem => 'Sistema';

  @override
  String get settingsLanguageSpanish => 'Español';

  @override
  String get settingsLanguageEnglish => 'English';

  @override
  String get settingsLanguageGerman => 'Deutsch';

  @override
  String get settingsLanguageFrench => 'Français';

  @override
  String get settingsLanguagePortuguese => 'Português';

  @override
  String get settingsLanguageItalian => 'Italiano';

  @override
  String settingsOwnedCount(int owned, int total) {
    return '$owned de $total marcadores';
  }

  @override
  String settingsPacksSelected(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count packs selecionados',
      one: '1 pack selecionado',
    );
    return '$_temp0';
  }

  @override
  String settingsImportUnsupportedVersion(int version) {
    return 'Esta cópia tem uma versão não suportada: $version.';
  }

  @override
  String settingsImportFailed(String reason) {
    return 'Não foi possível importar a cópia: $reason';
  }

  @override
  String settingsAiOnDeviceProgressTotal(
    String bytes,
    String total,
    int percent,
  ) {
    return '$bytes de $total MB transferidos ($percent %)';
  }

  @override
  String settingsAiOnDeviceProgressBytes(String bytes) {
    return '$bytes MB transferidos';
  }

  @override
  String settingsAiConnectionOk(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count modelos disponíveis',
      one: '1 modelo disponível',
    );
    return 'Ligação correta ($_temp0).';
  }

  @override
  String settingsAiConnectionFailed(String reason) {
    return 'Falha na ligação: $reason';
  }

  @override
  String settingsAiFallbacksCount(int count, int max) {
    return '$count de $max';
  }

  @override
  String settingsAiUseTyped(String id) {
    return 'Usar “$id”';
  }

  @override
  String settingsAiFallbacksHint(int max) {
    return 'Experimentam-se por ordem quando o modelo acima falha (até $max).';
  }

  @override
  String get settingsAiOnDeviceUnavailable =>
      'A IA no dispositivo não está disponível neste telemóvel neste momento. Usa-se a teoria da cor até estar.';

  @override
  String paletteSizeChip(int size) {
    return '$size cores';
  }

  @override
  String paletteAiLabel(String name) {
    return 'IA · $name';
  }

  @override
  String paletteAiLabelPartial(String name, int aiCount, int total) {
    return 'IA + teoria da cor · $name · $aiCount/$total';
  }

  @override
  String paletteResultTitle(int count) {
    return 'Combinações ($count)';
  }

  @override
  String paletteSavedSubtitle(String mode, int size) {
    return '$mode · $size cores';
  }

  @override
  String paletteSubtitleCustom(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count marcadores',
      one: '1 marcador',
    );
    return 'Paleta personalizada · $_temp0';
  }

  @override
  String paletteSavedNotice(String name) {
    return 'Paleta “$name” guardada.';
  }

  @override
  String paletteLoadedNotice(String name) {
    return 'Paleta “$name” carregada.';
  }

  @override
  String paletteVariationApplied(String label) {
    return 'Variação aplicada: $label.';
  }

  @override
  String paletteDraftApplied(int count) {
    return 'Paleta das Ideias aplicada ($count cores).';
  }

  @override
  String paletteUsingDefaultBase(String code, String scenario) {
    return 'A usar $code como base predefinida para $scenario. Introduz um código para a mudar.';
  }

  @override
  String paletteUnknownCode(String brand, String input, String example) {
    String _temp0 = intl.Intl.selectLogic(brand, {
      'decoTime':
          '$input não é um código de marcador da DecoTime. Experimenta $example.',
      'copic':
          '$input não é um código de marcador da Copic. Experimenta $example.',
      'finecolour':
          '$input não é um código de marcador da Finecolour. Experimenta $example.',
      'other':
          '$input não é um código de marcador do Ink Lab. Experimenta $example.',
    });
    return '$_temp0';
  }

  @override
  String paletteNotAvailable(String brand, String input, String example) {
    String _temp0 = intl.Intl.selectLogic(brand, {
      'decoTime':
          '$input não está na tua coleção. Experimenta $example ou junta-o em A minha coleção.',
      'copic':
          '$input não está na tua coleção. Experimenta $example ou junta-o em A minha coleção.',
      'finecolour':
          '$input não está na tua coleção. Experimenta $example ou junta-o em A minha coleção.',
      'other':
          '$input não está na tua coleção. Experimenta $example ou junta-o em A minha coleção.',
    });
    return '$_temp0';
  }

  @override
  String paletteNoAvailableColors(String brand) {
    String _temp0 = intl.Intl.selectLogic(brand, {
      'decoTime': 'Ainda não há marcadores DecoTime na tua coleção. Junta-os em A minha coleção.',
      'copic': 'Ainda não há marcadores Copic na tua coleção. Junta-os em A minha coleção.',
      'finecolour': 'Ainda não há marcadores Finecolour na tua coleção. Junta-os em A minha coleção.',
      'other': 'Ainda não há marcadores na tua coleção. Junta-os em A minha coleção.',
    });
    return '$_temp0';
  }

  @override
  String paletteMissingBase(String example) {
    return 'Escolhe um marcador base, como $example, ou uma cena com o chip Cenas.';
  }

  @override
  String swatchesFiltersCount(int count) {
    return 'Filtros · $count';
  }

  @override
  String swatchesCodeCopied(String code) {
    return '$code copiado. Cola-o como cor base no separador Paleta.';
  }

  @override
  String swatchesAlternativeSemantics(String code, String name, double value) {
    final intl.NumberFormat valueNumberFormat =
        intl.NumberFormat.decimalPatternDigits(
          locale: localeName,
          decimalDigits: 1,
        );
    final String valueString = valueNumberFormat.format(value);

    return '$code, $name, delta E $valueString';
  }

  @override
  String swatchesCountOf(int visible, int total) {
    return '$visible de $total';
  }

  @override
  String swatchesOwnedSubtitle(String brand, int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count teus',
      one: '1 teu',
    );
    return '$brand · $_temp0';
  }

  @override
  String swatchesFilteredColorCount(int visible, int total) {
    return '$visible de $total cores';
  }

  @override
  String swatchesSwatchSemantics(String code, String name, String favorite) {
    String _temp0 = intl.Intl.selectLogic(favorite, {
      'true': '$code, $name, favorito',
      'other': '$code, $name',
    });
    return '$_temp0';
  }

  @override
  String swatchesClassicPack(String label) {
    return 'Clássico $label';
  }

  @override
  String ideasPaletteSent(String title) {
    return 'A paleta de “$title” já está em Paleta.';
  }

  @override
  String matchSubtitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'os teus $count marcadores',
      one: 'o teu marcador',
    );
    return 'A comparar com $_temp0';
  }

  @override
  String get matchQualityExcellent => 'Quase exata';

  @override
  String get matchQualityVeryClose => 'Muito próxima';

  @override
  String get matchQualityClose => 'Próxima';

  @override
  String get matchQualityFair => 'Aproximada';

  @override
  String get matchQualityApproximate => 'Afastada';

  @override
  String matchRecorded(String code) {
    return '$code guardado nas escolhas recentes.';
  }

  @override
  String get errDisabled => 'As sugestões de IA estão desativadas.';

  @override
  String get errMissingKey => 'Não há nenhuma chave de API configurada.';

  @override
  String get errNoModelSelected => 'Não há nenhum modelo de IA selecionado.';

  @override
  String get errUnauthorized => 'A chave de API foi rejeitada.';

  @override
  String get errPaymentRequired =>
      'A conta não tem saldo ou a chave esgotou a quota.';

  @override
  String get errRateLimited =>
      'O fornecedor está a limitar os pedidos. Tenta de novo daqui a pouco.';

  @override
  String get errServerError =>
      'O fornecedor teve um erro de servidor. Tenta mais tarde.';

  @override
  String get errHttpError => 'O fornecedor rejeitou o pedido.';

  @override
  String get errNetworkError =>
      'Não foi possível contactar o fornecedor. Verifica a ligação.';

  @override
  String get errInvalidJson => 'O fornecedor devolveu uma resposta ilegível.';

  @override
  String get errInvalidResponse =>
      'O fornecedor não devolveu nenhuma paleta utilizável.';

  @override
  String get errNoValidSuggestions =>
      'O fornecedor sugeriu cores que não estão na coleção ativa.';

  @override
  String get errNoAvailableColors =>
      'Não há marcadores disponíveis entre os quais escolher.';

  @override
  String get errNoSuggestions => 'Não foi possível gerar nenhuma sugestão.';

  @override
  String get errTimeout =>
      'O modelo do dispositivo demorou demasiado. Tenta de novo.';

  @override
  String get errOnDeviceUnavailable =>
      'O modelo do dispositivo não está pronto neste telemóvel.';

  @override
  String get errUnknown => 'As sugestões de IA não estão disponíveis.';

  @override
  String errAiUnavailableWithReason(String reason) {
    return 'IA indisponível ($reason) A mostrar sugestões locais.';
  }

  @override
  String get roleMainTone => 'Tom principal';

  @override
  String get roleMidtone => 'Tom médio';

  @override
  String get roleShadow => 'Sombra';

  @override
  String get roleHighlight => 'Luz';

  @override
  String get roleBlend => 'Mistura';

  @override
  String get roleToneA => 'Tom A';

  @override
  String get roleToneAShadow => 'Sombra do tom A';

  @override
  String get roleToneB => 'Tom B';

  @override
  String get roleToneBShadow => 'Sombra do tom B';

  @override
  String get roleBridge => 'Ponte';

  @override
  String get roleWarmBase => 'Base quente';

  @override
  String get roleWarmShadow => 'Sombra quente';

  @override
  String get roleSunlitAccent => 'Acento ensolarado';

  @override
  String get roleDepthTone => 'Tom de profundidade';

  @override
  String get roleCoolBase => 'Base fria';

  @override
  String get roleCoolShadow => 'Sombra fria';

  @override
  String get roleAtmosphere => 'Atmosfera';

  @override
  String get roleDeepCool => 'Frio profundo';

  @override
  String get rolePastelBase => 'Base pastel';

  @override
  String get roleSoftShade => 'Sombra suave';

  @override
  String get rolePastelHighlight => 'Luz pastel';

  @override
  String get roleAccent => 'Acento';

  @override
  String get roleSupport => 'Apoio';

  @override
  String get roleNeonLead => 'Néon principal';

  @override
  String get roleNeonSecondary => 'Néon secundário';

  @override
  String get roleGlow => 'Resplendor';

  @override
  String get rolePopAccent => 'Acento vivo';

  @override
  String get roleHue1 => 'Matiz 1';

  @override
  String get roleHue2 => 'Matiz 2';

  @override
  String get roleHue3 => 'Matiz 3';

  @override
  String get roleHue4 => 'Matiz 4';

  @override
  String get roleHue5 => 'Matiz 5';

  @override
  String get roleUnexpectedLead => 'Protagonista inesperado';

  @override
  String get roleContrastPair => 'Par de contraste';

  @override
  String get roleTensionAccent => 'Acento de tensão';

  @override
  String get roleOffbeatSupport => 'Apoio atípico';

  @override
  String get roleRandom1 => 'Aleatório 1';

  @override
  String get roleRandom2 => 'Aleatório 2';

  @override
  String get roleRandom3 => 'Aleatório 3';

  @override
  String get roleRandom4 => 'Aleatório 4';

  @override
  String get roleRandom5 => 'Aleatório 5';

  @override
  String get roleLightValue => 'Valor claro';

  @override
  String get roleMidLight => 'Médio claro';

  @override
  String get roleMid => 'Médio';

  @override
  String get roleMidDark => 'Médio escuro';

  @override
  String get roleDarkValue => 'Valor escuro';

  @override
  String get roleWarmSideA => 'Lado quente A';

  @override
  String get roleWarmSideB => 'Lado quente B';

  @override
  String get roleCoolSideA => 'Lado frio A';

  @override
  String get roleCoolSideB => 'Lado frio B';

  @override
  String get roleBridgeTone => 'Tom ponte';

  @override
  String get roleSeasonLead => 'Estação principal';

  @override
  String get roleSeasonSupport => 'Estação de apoio';

  @override
  String get roleFestiveRed => 'Vermelho festivo';

  @override
  String get roleEvergreen => 'Verde abeto';

  @override
  String get roleGoldAccent => 'Acento dourado';

  @override
  String get rolePineShadow => 'Sombra de pinheiro';

  @override
  String get roleSnowSupport => 'Apoio neve';

  @override
  String get roleRomanticLead => 'Romântico principal';

  @override
  String get roleRoseShadow => 'Sombra rosa';

  @override
  String get roleSoftBlush => 'Blush suave';

  @override
  String get roleBalanceTone => 'Tom de equilíbrio';

  @override
  String get roleBase => 'Base';

  @override
  String get roleGlowZone => 'Zona de brilho';

  @override
  String get rolePatternAccent => 'Acento do padrão';

  @override
  String get roleContrastColor => 'Cor de contraste';

  @override
  String get rolePrimary1 => 'Primário 1';

  @override
  String get rolePrimary2 => 'Primário 2';

  @override
  String get rolePrimary3 => 'Primário 3';

  @override
  String get roleSecondary => 'Secundário';

  @override
  String get roleSepiaLight => 'Sépia clara';

  @override
  String get roleDustMidtone => 'Médio empoeirado';

  @override
  String get roleLeatherShadow => 'Sombra de couro';

  @override
  String get roleAgedAccent => 'Acento envelhecido';

  @override
  String get roleSmokeNeutral => 'Neutro fumo';

  @override
  String get roleHauntBase => 'Base assombrada';

  @override
  String get rolePumpkinGlow => 'Brilho de abóbora';

  @override
  String get roleNightShadow => 'Sombra noturna';

  @override
  String get roleEerieAccent => 'Acento sinistro';

  @override
  String get roleFogSupport => 'Apoio nevoeiro';

  @override
  String get roleNightBase => 'Base noturna';

  @override
  String get roleDeepShadow => 'Sombra profunda';

  @override
  String get roleMoonlitEdge => 'Bordo de luar';

  @override
  String get roleCoolAccent => 'Acento frio';

  @override
  String get roleMist => 'Bruma';

  @override
  String get roleWaterBase => 'Base de água';

  @override
  String get roleDepth => 'Profundidade';

  @override
  String get roleShadowWater => 'Água na sombra';

  @override
  String get roleLightBeam => 'Feixe de luz';

  @override
  String get roleBubbleHighlight => 'Luz de bolha';

  @override
  String get roleSpookyBase => 'Base tenebrosa';

  @override
  String get roleColdShadow => 'Sombra gélida';

  @override
  String get roleHauntedAccent => 'Acento fantasmagórico';

  @override
  String get roleEerieHighlight => 'Luz sinistra';

  @override
  String get roleFogTone => 'Tom nevoeiro';

  @override
  String get roleMysticBase => 'Base mística';

  @override
  String get roleSpellShadow => 'Sombra de feitiço';

  @override
  String get roleMagicalAccent => 'Acento mágico';

  @override
  String get roleRuneGlow => 'Brilho de runa';

  @override
  String get roleMoodLead => 'Ânimo principal';

  @override
  String get roleMoodShadow => 'Sombra anímica';

  @override
  String get roleEmotionAccent => 'Acento emotivo';

  @override
  String get roleMaterialBase => 'Base do material';

  @override
  String get rolePlaneShift => 'Mudança de plano';

  @override
  String get roleHardShadow => 'Sombra dura';

  @override
  String get roleSpecularEdge => 'Bordo especular';

  @override
  String get rolePatinaAccent => 'Acento de pátina';

  @override
  String get roleSpaceBase => 'Base espacial';

  @override
  String get roleNebulaGlow => 'Brilho de nebulosa';

  @override
  String get roleDeepVoid => 'Vazio profundo';

  @override
  String get roleStarAccent => 'Acento estelar';

  @override
  String get roleDustCloud => 'Nuvem de pó';

  @override
  String get roleGlassPaneA => 'Vidro A';

  @override
  String get roleGlassPaneB => 'Vidro B';

  @override
  String get roleGlassPaneC => 'Vidro C';

  @override
  String get roleGlassPaneD => 'Vidro D';

  @override
  String get roleLightHit => 'Impacto de luz';

  @override
  String get roleShade => 'Sombreado';

  @override
  String get roleContrast => 'Contraste';

  @override
  String get roleSoftShadow => 'Sombra suave';

  @override
  String get roleBackground => 'Fundo';

  @override
  String get roleCompanionHue => 'Matiz acompanhante';

  @override
  String get rolePrimaryShadow => 'Sombra principal';

  @override
  String get roleMysticAccent => 'Acento místico';

  @override
  String get roleSecondaryAccent => 'Acento secundário';

  @override
  String get rolePumpkinShadow => 'Sombra de abóbora';

  @override
  String get roleWitchyPurple => 'Roxo de bruxa';

  @override
  String get roleToxicAccent => 'Acento tóxico';

  @override
  String get roleNightBackground => 'Fundo noturno';

  @override
  String get roleRibbonRed => 'Vermelho do laço';

  @override
  String get rolePineDepth => 'Profundidade de pinheiro';

  @override
  String get roleSnowHighlight => 'Luz de neve';

  @override
  String get roleBudShadow => 'Sombra de rebento';

  @override
  String get roleBlossomTint => 'Tinta de flor';

  @override
  String get roleFreshLeaf => 'Folha fresca';

  @override
  String get roleDaffodilLight => 'Luz de narciso';

  @override
  String get roleRainySky => 'Céu chuvoso';

  @override
  String get roleSkinSubjectShadow => 'Sombra de pele/motivo';

  @override
  String get roleWarmCompanion => 'Acompanhante quente';

  @override
  String get roleNeutralBalance => 'Equilíbrio neutro';

  @override
  String get roleBarkShadow => 'Sombra de casca';

  @override
  String get roleMapleRed => 'Vermelho bordo';

  @override
  String get roleOliveAccent => 'Acento oliva';

  @override
  String get roleMorningMist => 'Neblina matinal';

  @override
  String get roleSubjectShadow => 'Sombra do motivo';

  @override
  String get roleCoolCompanion => 'Acompanhante frio';

  @override
  String get roleAiryHighlight => 'Luz aérea';

  @override
  String get roleSnowShadow => 'Sombra de neve';

  @override
  String get roleFrostHighlight => 'Luz de geada';

  @override
  String get roleEvergreenDepth => 'Profundidade perene';

  @override
  String get roleBerryAccent => 'Acento de baga';

  @override
  String get roleTwilightSky => 'Céu crepuscular';

  @override
  String get roleGroundShadow => 'Sombra do chão';

  @override
  String get roleSkyBlend => 'Mistura de céu';

  @override
  String get roleSunHighlight => 'Luz solar';

  @override
  String get roleContrastAccent => 'Acento de contraste';

  @override
  String get roleNeutralBuffer => 'Neutro de transição';

  @override
  String get rolePalmShadow => 'Sombra de palmeira';

  @override
  String get roleCoralAccent => 'Acento coral';

  @override
  String get roleOceanSplash => 'Salpico de mar';

  @override
  String get roleSunbeamHighlight => 'Luz de raio de sol';

  @override
  String get roleWarmSand => 'Areia quente';

  @override
  String get roleLeafShadow => 'Sombra de folha';

  @override
  String get roleMossMidtone => 'Médio musgo';

  @override
  String get roleSunlitLeaf => 'Folha ensolarada';

  @override
  String get roleTrunkAccent => 'Acento de tronco';

  @override
  String get roleSkyFog => 'Céu/nevoeiro';

  @override
  String get rolePetalShadow => 'Sombra de pétala';

  @override
  String get rolePetalHighlight => 'Luz de pétala';

  @override
  String get roleSecondaryPetal => 'Pétala secundária';

  @override
  String get roleLeafAccent => 'Acento de folha';

  @override
  String get rolePatternBackground => 'Fundo do padrão';

  @override
  String get roleToneC => 'Tom C';

  @override
  String get roleToneD => 'Tom D';

  @override
  String get roleNeutralLinework => 'Linha neutra';

  @override
  String get roleComplement => 'Complementar';

  @override
  String get roleNeutral => 'Neutro';

  @override
  String get roleCompanion => 'Acompanhante';

  @override
  String get reasonScenarioSupport => 'Apoio da cena';

  @override
  String get reasonBalancedPairing => 'Combinação equilibrada';

  @override
  String get reasonShadowDepth => 'Profundidade de sombra';

  @override
  String get reasonSoftNearbyHue => 'Matiz próximo suave';

  @override
  String get reasonControlledContrast => 'Contraste controlado';

  @override
  String get reasonHighlightLift => 'Realce de luz';

  @override
  String get reasonLocked => 'Fixado';

  @override
  String get reasonVariationSupport => 'Apoio da variação';

  @override
  String get reasonOppositeHueContrast => 'Contraste de matiz oposto';

  @override
  String get reasonSplitComplementContrast => 'Contraste complementar dividido';

  @override
  String get reasonTriadBalance => 'Equilíbrio em tríade';

  @override
  String get reasonSquareHarmony => 'Harmonia quadrada';

  @override
  String get reasonRectangleHarmony => 'Harmonia retangular';

  @override
  String get reasonSameFamilyDeeperTone => 'Mesma família, tom mais profundo';

  @override
  String get reasonSameFamilyLighterTone => 'Mesma família, tom mais claro';

  @override
  String get reasonManualPalette => 'Paleta manual';

  @override
  String get reasonSupportTone => 'Tom de apoio';

  @override
  String get reasonAISuggestion => 'Sugestão da IA';

  @override
  String get reasonLoadedPalette => 'Paleta carregada';

  @override
  String get reasonAppliedFromIdeas => 'Aplicada das Ideias';

  @override
  String reasonNearbyHue(int degrees) {
    return 'Harmonia de matiz próximo ($degrees°)';
  }

  @override
  String reasonShadowTone(int percent) {
    return 'Tom de sombra ($percent % mais escuro)';
  }

  @override
  String reasonVariation(String prefix, String reason) {
    return '$prefix: $reason';
  }

  @override
  String get variationPrefixVibrant => 'Vivo';

  @override
  String get variationPrefixSoft => 'Suave';

  @override
  String get variationPrefixContrast => 'Contraste';

  @override
  String get variationPrefixWarm => 'Quente';

  @override
  String get variationPrefixCool => 'Frio';

  @override
  String get variationLabelMoreVibrant => 'Mais vivo';

  @override
  String get variationLabelSofter => 'Mais suave';

  @override
  String get variationLabelHigherContrast => 'Mais contraste';

  @override
  String get variationLabelWarmer => 'Mais quente';

  @override
  String get variationLabelCooler => 'Mais frio';

  @override
  String get modeRecommended => 'Recomendada';

  @override
  String get modeComplementary => 'Complementar';

  @override
  String get modeAnalogous => 'Análoga';

  @override
  String get modeSplitComplementary => 'Complementar dividida';

  @override
  String get modeTriad => 'Tríade';

  @override
  String get modeSquare => 'Quadrada';

  @override
  String get modeRectangle => 'Retangular';

  @override
  String get modeMonochrome => 'Monocromática';

  @override
  String get modeCustomPalette => 'Paleta personalizada';

  @override
  String get modeShadow => 'Sombra';

  @override
  String get packLabel120New => '120 Novo';

  @override
  String get packLabel36Skin => '36 Pele';

  @override
  String get packLabel36Gray => '36 Cinzentos';

  @override
  String get packLabel48Pastel => '48 Pastel';

  @override
  String get categorySignature => 'Assinatura';

  @override
  String get categoryChallenges => 'Desafios';

  @override
  String get categoryAtmosphere => 'Atmosfera';

  @override
  String get settingsLinesTitle => 'Linhas que tens';

  @override
  String get settingsLinesHint =>
      'Escolhe todas as linhas da Ohuhu que tenhas. Se desativares uma linha, os seus packs saem da tua seleção.';

  @override
  String settingsLineSelectedOfTotal(int selected, int total) {
    return '$selected de $total packs selecionados';
  }

  @override
  String settingsCurrentPacks(int count) {
    return 'Packs atuais ($count)';
  }

  @override
  String settingsLegacyPacks(int count) {
    return 'Packs antigos / da comunidade ($count)';
  }

  @override
  String get settingsLegacyPacksNote =>
      'Lista de packs fornecida pela comunidade; pode já não estar à venda.';

  @override
  String settingsPackColorsSemantics(String pack, int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count cores',
      one: '1 cor',
    );
    return '$pack, $_temp0';
  }

  @override
  String get swatchesLines => 'Linhas';

  @override
  String get swatchesLabelLine => 'Linha';

  @override
  String get swatchesAllLines => 'Todas as linhas';

  @override
  String get swatchesLegacyPacks => 'Conjuntos antigos';

  @override
  String packLabelSkin(String n) {
    return '$n Pele';
  }

  @override
  String packLabelPastel(String n) {
    return '$n Pastel';
  }

  @override
  String packLabelPastels(String n) {
    return '$n Pastéis';
  }

  @override
  String packLabelBasic(String n) {
    return '$n Básico';
  }

  @override
  String packLabelIllustration(String n) {
    return '$n Ilustração';
  }

  @override
  String packLabelLandscape(String n) {
    return '$n Paisagem';
  }

  @override
  String packLabelSweetPastels(String n) {
    return '$n Pastéis doces';
  }

  @override
  String packLabelMidTones(String n) {
    return '$n Tons médios';
  }

  @override
  String packLabelBlossomPastels(String n) {
    return '$n Pastéis em flor';
  }

  @override
  String packLabelWhiteCase(String n) {
    return 'Estojo branco $n';
  }

  @override
  String packLabelWhiteCaseVersion(String n, String v) {
    return 'Estojo branco $n (V$v)';
  }

  @override
  String packLabelJapanVersion(String n, String v) {
    return 'Japão $n (V$v)';
  }

  @override
  String packFullLabel(String line, String pack) {
    return '$line $pack';
  }

  @override
  String swatchesMorePacks(int count) {
    return '+$count mais';
  }

  @override
  String get settingsMatchingGroup => 'Comparar cores';

  @override
  String get settingsMatchSuggestUnowned => 'Ver toda a gama';

  @override
  String get settingsMatchSuggestUnownedSubtitle =>
      'Se nenhum dos teus marcadores se parecer, Comparar mostra também o mais próximo de toda a gama.';

  @override
  String get settingsSetupAgain => 'Repetir a configuração';

  @override
  String get matchNoCloseMatch => 'Nenhum dos teus marcadores se parece.';

  @override
  String matchRangeTitle(String brand) {
    return 'Toda a gama $brand';
  }

  @override
  String get matchNotOwnedBadge => 'Não o tens';

  @override
  String matchBestOfRange(String brand) {
    return 'O melhor de toda a gama $brand';
  }

  @override
  String get matchNotOwnedLine => 'Não está na tua coleção';

  @override
  String matchSeeAll(int count) {
    return 'Ver todas ($count)';
  }

  @override
  String get matchSubtitleEmpty => 'Ainda não há marcadores na tua coleção';

  @override
  String swatchesWholeRangeNotice(String brand) {
    return 'A ver toda a gama $brand';
  }

  @override
  String get swatchesWholeRangeAction => 'Configurar';

  @override
  String matchWholeRangeBody(String brand) {
    return 'Até configurares a tua coleção, comparamos com toda a gama $brand.';
  }

  @override
  String get matchWholeRangeAction => 'Ir para A minha coleção';

  @override
  String get collectionTitle => 'A minha coleção';

  @override
  String collectionMarkers(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count marcadores',
      one: '1 marcador',
      zero: 'Sem marcadores',
    );
    return '$_temp0';
  }

  @override
  String collectionSets(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count conjuntos',
      one: '1 conjunto',
    );
    return '$_temp0';
  }

  @override
  String get collectionNotSetUp => 'Por configurar';

  @override
  String get collectionSeriesTitle => 'Séries que tens';

  @override
  String get collectionHonoluluNote =>
      'O Honolulu B, o Honolulu S e o Honolulu² usam os mesmos códigos de cor que o Honolulu; só mudam as pontas.';

  @override
  String get collectionSetsTitle => 'Conjuntos que tens';

  @override
  String get collectionSetsEmpty =>
      'Escolhe uma série para ver os seus conjuntos.';

  @override
  String collectionOlderSets(int count) {
    return 'Conjuntos antigos ($count)';
  }

  @override
  String get collectionOlderSetsNote =>
      'Edições descontinuadas ou regionais, segundo dados da comunidade.';

  @override
  String get collectionExtrasTitle => 'Marcadores avulsos';

  @override
  String get collectionExtrasHint =>
      'Compraste marcadores avulsos? Assinala-os aqui. Os dos teus conjuntos já contam.';

  @override
  String get collectionDecoMarkersTitle => 'Os teus marcadores';

  @override
  String get collectionDecoHint =>
      'A DecoTime não publica que cores traz cada conjunto: assinala as que tens ou junta uma família inteira.';

  @override
  String get collectionDecoSizesHint =>
      'A Action vende conjuntos DecoTime de 100, 150, 160, 200 e 300 marcadores.';

  @override
  String get collectionFamiliesTitle => 'Juntar por família';

  @override
  String collectionFamilyChip(String family, int owned, int total) {
    return '$family $owned/$total';
  }

  @override
  String get collectionFamilyColours => 'Cores';

  @override
  String get collectionFamilyWarmGrey => 'Cinzentos quentes';

  @override
  String get collectionFamilyCoolGrey => 'Cinzentos frios';

  @override
  String get collectionFamilyBlueGrey => 'Cinzentos azulados';

  @override
  String get collectionFamilyGreenGrey => 'Cinzentos esverdeados';

  @override
  String get collectionDecoRange => 'Gama DecoTime';

  @override
  String get collectionWholeRange => 'Toda a gama';

  @override
  String get collectionSearchHint => 'Procurar código ou nome';

  @override
  String get collectionTickVisible => 'Marcar tudo';

  @override
  String get collectionUntickVisible => 'Desmarcar';

  @override
  String get collectionInYourSets => 'No teu conjunto';

  @override
  String get collectionNoResults => 'Nenhum marcador corresponde à pesquisa.';

  @override
  String get collectionReset => 'Esvaziar coleção';

  @override
  String get collectionOwnedGroup => 'O que tens';

  @override
  String get collectionShoppingGroup => 'Compras';

  @override
  String get collectionToolsGroup => 'Ferramentas';

  @override
  String commonSeeAll(int count) {
    return 'Ver todas ($count)';
  }

  @override
  String get collectionChartTitle => 'Carta de amostras para imprimir';

  @override
  String get swatchesOtherBrandsTitle => 'Noutras marcas';

  @override
  String get swatchesOtherBrandsOnlyMine => 'Só os meus';

  @override
  String get swatchesOtherBrandsNone => 'Não há outra marca para comparar.';

  @override
  String get swatchesOtherBrandsNoneMine =>
      'Não tens marcadores utilizáveis de outras marcas.';

  @override
  String get swatchesOtherBrandsFailed =>
      'Não foi possível ler as outras marcas.';

  @override
  String get swatchesOtherBrandsPaletteNote =>
      'As paletas usam a marca escolhida nas Definições, por isso este marcador não pode ser adicionado a uma.';

  @override
  String get paletteVisionTitle => 'Visão das cores';

  @override
  String get paletteVisionNormal => 'Normal';

  @override
  String get paletteVisionProtanopia => 'Protanopia';

  @override
  String get paletteVisionDeuteranopia => 'Deuteranopia';

  @override
  String get paletteVisionTritanopia => 'Tritanopia';

  @override
  String get paletteVisionAchromatopsia => 'Acromatopsia';

  @override
  String paletteVisionPairs(String pairs) {
    return 'Difíceis de distinguir: $pairs';
  }

  @override
  String paletteVisionPairsMore(int count) {
    return '+$count mais';
  }

  @override
  String get paletteVisionNoPairs =>
      'Todas as cores continuam fáceis de distinguir.';

  @override
  String get paletteVisionPreviewNote =>
      'Apenas uma pré-visualização. Ao guardar e partilhar mantêm-se as cores reais.';

  @override
  String get collectionChartHint =>
      'Caixas vazias com o código e o nome de cada marcador que tens, para pintares as tuas amostras reais. Partilham-se como imagens A4 para imprimir ou guardar.';

  @override
  String get collectionChartShowColour => 'Cor do catálogo';

  @override
  String get collectionChartShowColourHint =>
      'Mostra-a como uma faixa fina em cada caixa, para comparar.';

  @override
  String get collectionChartCreate => 'Criar e partilhar';

  @override
  String get collectionChartPreparing => 'A preparar…';

  @override
  String get collectionChartEmpty =>
      'Escolhe antes os teus conjuntos ou marcadores.';

  @override
  String collectionChartPages(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count páginas',
      one: '1 página',
    );
    return '$_temp0';
  }

  @override
  String get chartImageTitle => 'Carta de amostras';

  @override
  String chartImagePage(int page, int total) {
    return 'Página $page de $total';
  }

  @override
  String collectionResetTitle(String brand) {
    return 'Esvaziar a tua coleção $brand?';
  }

  @override
  String get collectionResetBody =>
      'Os conjuntos e marcadores avulsos desta marca são removidos. Os favoritos e as paletas mantêm-se.';

  @override
  String collectionOwnedCount(int owned, int total) {
    return '$owned de $total';
  }

  @override
  String get onboardingWelcomeTitle => 'Damos-te as boas-vindas';

  @override
  String get onboardingWelcomeBody =>
      'Explora os teus marcadores, compara cores das tuas fotos e cria paletas. Primeiro, diz-nos que marcadores tens.';

  @override
  String get onboardingOhuhuLine =>
      'Conjuntos por série: Oahu, Honolulu, Kaala';

  @override
  String get onboardingDecoLine => 'Uma gama de 313 cores, conjuntos na Action';

  @override
  String get onboardingSeriesTitle => 'Que séries tens?';

  @override
  String get onboardingSeriesBody =>
      'Escolhe todas as séries de que tens marcadores.';

  @override
  String get onboardingSetsTitle => 'Que conjuntos tens?';

  @override
  String get onboardingSetsBody =>
      'Escolhe as caixas que compraste. Os marcadores avulsos juntam-se depois.';

  @override
  String get onboardingDoneTitle => 'Tudo pronto';

  @override
  String get onboardingLaterNote =>
      'Podes mudar isto mais tarde em A minha coleção.';

  @override
  String get onboardingSkip => 'Saltar';

  @override
  String get onboardingNext => 'Seguinte';

  @override
  String get onboardingBack => 'Voltar';

  @override
  String get onboardingFinish => 'Começar';

  @override
  String onboardingStep(int step, int total) {
    return 'Passo $step de $total';
  }

  @override
  String get collectionSeriesOahuTips => 'Ponta fina e cinzel';

  @override
  String get collectionSeriesHonoluluTips => 'Pincel e cinzel';

  @override
  String get collectionSeriesKaalaTips => 'Ponta de pincel';

  @override
  String get collectionSummaryNoSets =>
      'Ainda não escolheste conjuntos: usa-se toda a gama';

  @override
  String get collectionSummaryNoMarkers => 'Ainda não assinalaste marcadores';

  @override
  String get collectionExtrasAddTitle => 'Juntar marcadores avulsos';

  @override
  String get collectionDecoMarkersButton => 'Assinalar marcadores';

  @override
  String collectionExtrasCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count marcadores avulsos',
      one: '1 marcador avulso',
      zero: 'Sem marcadores avulsos',
    );
    return '$_temp0';
  }

  @override
  String get wishlistTitle => 'Lista de desejos';

  @override
  String wishlistCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count marcadores por comprar',
      one: '1 marcador por comprar',
      zero: 'A tua lista de desejos está vazia',
    );
    return '$_temp0';
  }

  @override
  String get wishlistEmpty =>
      'Junta os marcadores que queres comprar a partir do detalhe de qualquer um.';

  @override
  String get wishlistAdd => 'Para a lista de desejos';

  @override
  String get wishlistRemove => 'Tirar da lista';

  @override
  String get wishlistCopy => 'Copiar lista';

  @override
  String get wishlistCopied => 'Lista de compras copiada';

  @override
  String get wishlistOfferTitle => 'Juntar à tua lista de desejos?';

  @override
  String wishlistOfferBody(String code) {
    return '$code secou. Junta-o à tua lista de desejos para comprar uma recarga ou um substituto.';
  }

  @override
  String get driedTitle => 'Secos';

  @override
  String driedCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count marcadores secos',
      one: '1 marcador seco',
      zero: 'Nenhum marcador seco',
    );
    return '$_temp0';
  }

  @override
  String get driedHint =>
      'Continuam na tua coleção, mas Comparar, Paleta e Ideias não os sugerem.';

  @override
  String get driedEmpty =>
      'Quando um marcador deixar de pintar, marca-o como seco a partir do seu detalhe.';

  @override
  String get driedMark => 'Marcar como seco';

  @override
  String get driedUnmark => 'Marcar como utilizável';

  @override
  String get driedNote =>
      'Seco: Comparar, Paleta e Ideias omitem-no até o marcares como utilizável.';

  @override
  String get commonDried => 'Seco';

  @override
  String get buyNextTitle => 'O que comprar a seguir';

  @override
  String get buyNextIntro =>
      'Marcadores que não tens e que aproximariam as tuas cores das de mais cenas.';

  @override
  String buyNextReasonScenes(int count, String scenes) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Melhora $count cenas: $scenes',
      one: 'Melhora 1 cena: $scenes',
    );
    return '$_temp0';
  }

  @override
  String get buyNextReasonGap => 'Preenche uma lacuna na tua gama de cores';

  @override
  String get buyNextNoCollection =>
      'Assinala os marcadores que tens para ver o que comprar.';

  @override
  String get buyNextComplete =>
      'Nada a sugerir: os teus marcadores já cobrem bem todas as cenas.';

  @override
  String get buyNextRefill => 'Seco: uma recarga recupera-o.';

  @override
  String onboardingDoneWholeRange(String brand) {
    return 'Até escolheres conjuntos, a app mostra toda a gama $brand.';
  }

  @override
  String get onboardingDoneNext =>
      'A seguir: vê as tuas cores em Amostras, compara uma foto em Comparar ou cria uma paleta em Paleta.';

  @override
  String get collectionVisibleScope =>
      'Afeta os marcadores que correspondem à pesquisa.';

  @override
  String get matchWhiteBalanceButton => 'Corrigir brancos';

  @override
  String get matchWhiteBalanceHint =>
      'Toca num ponto da foto que devia ser papel branco.';

  @override
  String get matchWhiteBalanceOn => 'Brancos corrigidos';

  @override
  String get matchWhiteBalanceReset => 'Remover';

  @override
  String get matchWhiteBalanceTooDark =>
      'Esse ponto é demasiado escuro para ser papel. Escolhe um mais claro.';

  @override
  String get matchWhiteBalanceTooColourful =>
      'Esse ponto tem demasiada cor para ser papel. Escolhe uma zona branca.';

  @override
  String get commonOwnColour => 'A minha cor';

  @override
  String get swatchesMyColourTitle => 'A minha cor';

  @override
  String get swatchesMyColourHelp =>
      'As cores do catálogo são aproximadas. Guarda a que o teu marcador dá mesmo sobre o papel.';

  @override
  String get swatchesMyColourReset => 'Voltar ao catálogo';

  @override
  String get swatchesMyColourSaved => 'A tua cor foi guardada';

  @override
  String get swatchesMyColourWasReset => 'Voltou a cor do catálogo';

  @override
  String get swatchesMyColourSame => 'Igual ao catálogo';

  @override
  String swatchesMyColourValue(String hex) {
    return 'Teu: $hex';
  }

  @override
  String get swatchesStatusWished => 'Na tua lista de desejos';

  @override
  String get swatchesDetailsTitle => 'Detalhes';

  @override
  String get swatchesCatalogueLabel => 'Catálogo';

  @override
  String get swatchesMineLabel => 'Minha';

  @override
  String ownColorTitle(String code) {
    return 'A minha cor de $code';
  }

  @override
  String get ownColorHexLabel => 'Cor hex';

  @override
  String get ownColorHexInvalid => 'Escreve 3 ou 6 dígitos hex, como 3A7F9C.';

  @override
  String get ownColorPhotoTitle => 'A partir de uma foto';

  @override
  String get ownColorPhotoHelp =>
      'Pinta com o marcador sobre papel branco, tira uma foto e toca na zona pintada.';

  @override
  String get ownColorPhotoTap => 'Toca na zona pintada.';

  @override
  String get ownColorSave => 'Guardar a minha cor';

  @override
  String get settingsOwnColors => 'Usar as minhas cores';

  @override
  String get settingsOwnColorsSubtitle =>
      'Comparar, Paleta e Ideias usam a cor que guardaste de um marcador em vez da do catálogo.';

  @override
  String settingsOwnColorsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count cores próprias',
      one: '1 cor própria',
      zero: 'Ainda não tens cores próprias',
    );
    return '$_temp0';
  }

  @override
  String get settingsOwnColorsReset => 'Repor';

  @override
  String get settingsOwnColorsResetTitle => 'Repor as tuas cores?';

  @override
  String get settingsOwnColorsResetBody =>
      'Todos os marcadores voltam à cor do catálogo. Não é possível anular.';

  @override
  String get settingsJoinBeta => 'Junta-te ao beta do Google Play';

  @override
  String get collectionCopicHint =>
      'Os marcadores Copic compram-se à unidade. Assinala os que tens.';

  @override
  String get collectionFinecolourHint =>
      'Os marcadores Finecolour compram-se à unidade. Assinala os que tens.';

  @override
  String get onboardingCopicLine =>
      '358 cores · Assinala os marcadores que tens';

  @override
  String get onboardingFinecolourLine =>
      '480 cores · Assinala os marcadores que tens';

  @override
  String onboardingMarkersTitle(String brand) {
    return 'Os teus marcadores $brand';
  }

  @override
  String onboardingNoMarkers(String brand) {
    return 'Ainda não assinalaste marcadores $brand: assinala-os em A minha coleção.';
  }

  @override
  String ideasNoMarkersBrand(String brand) {
    return 'Junta os marcadores $brand que tens em A minha coleção para veres uma paleta para esta ideia.';
  }

  @override
  String get ideasDiarySegment => 'Diário';

  @override
  String get ideasDiarySubtitle => 'As tuas obras, as mais recentes primeiro';

  @override
  String get diaryEmptyTitle => 'O teu diário está vazio';

  @override
  String get diaryEmptyMessage =>
      'Regista as páginas e folhas que pintas, com os marcadores, notas e fotos.';

  @override
  String get diaryAdd => 'Adicionar ao diário';

  @override
  String get diaryShareButton => 'Partilhar esta entrada';

  @override
  String get diaryStatusLabel => 'Estado';

  @override
  String get diaryStatusInProgress => 'Em curso';

  @override
  String get diaryStatusFinished => 'Terminada';

  @override
  String get diaryNewTitle => 'Nova entrada';

  @override
  String get diaryEditTitle => 'Editar entrada';

  @override
  String get diaryTitleLabel => 'Título';

  @override
  String get diaryDateLabel => 'Data';

  @override
  String get diaryOnWhatLabel => 'Pintado em';

  @override
  String get diaryOnWhatHint => 'p. ex., um livro de colorir ou um caderno';

  @override
  String get diaryMarkersTitle => 'Marcadores usados';

  @override
  String get diaryMarkersChoose => 'Escolher marcadores';

  @override
  String diaryMarkerRemove(String code) {
    return 'Remover $code';
  }

  @override
  String get diaryPaletteTitle => 'Paleta';

  @override
  String get diaryPaletteNone => 'Sem paleta';

  @override
  String get diaryPaletteChoose => 'Associar uma paleta guardada';

  @override
  String get diaryPaletteMissing => 'Esta paleta já não está guardada.';

  @override
  String get diaryPaletteEmpty => 'Ainda não tens paletas guardadas.';

  @override
  String get diaryNotesLabel => 'Notas';

  @override
  String get diaryNotesHint => 'Técnica, papel, esbatimento...';

  @override
  String get diaryMoreDetails => 'Mais detalhes';

  @override
  String get diaryPhotosTitle => 'Fotos';

  @override
  String diaryPhotosHelp(int count) {
    return 'Até $count fotos. Ficam neste telemóvel.';
  }

  @override
  String get diaryPhotoRemove => 'Remover foto';

  @override
  String diaryPhotoSemantic(int number, int total) {
    return 'Foto $number de $total';
  }

  @override
  String get diarySave => 'Guardar entrada';

  @override
  String get diaryDelete => 'Apagar entrada';

  @override
  String get diaryDeleteTitle => 'Apagar esta entrada?';

  @override
  String get diaryDeleteBody =>
      'A entrada e as suas fotos são removidas deste telemóvel. Esta ação não pode ser anulada.';

  @override
  String get diaryDeleteConfirm => 'Apagar';

  @override
  String get diaryAddedNotice => 'Adicionado ao diário';

  @override
  String diaryStatsArtworks(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count obras',
      one: '1 obra',
    );
    return '$_temp0';
  }

  @override
  String diaryStatsFinished(int count) {
    return '$count terminadas';
  }

  @override
  String diaryStatsInProgress(int count) {
    return '$count em curso';
  }

  @override
  String get diaryStatsOpen => 'Ver os números';

  @override
  String get diaryStatsTitle => 'Números do diário';

  @override
  String get diaryStatsStatusTitle => 'Terminadas e em curso';

  @override
  String get diaryStatsMonthsTitle => 'Entradas por mês';

  @override
  String diaryStatsMonthsLatest(int count) {
    return 'A mostrar os últimos $count meses.';
  }

  @override
  String get diaryStatsMarkersTitle => 'Marcadores que mais usas';

  @override
  String get diaryStatsMarkersEmpty => 'Nenhuma entrada tem marcadores ainda.';

  @override
  String diaryStatsEntries(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count entradas',
      one: '1 entrada',
    );
    return '$_temp0';
  }

  @override
  String get diaryStatsUnusedTitle => 'Marcadores por usar';

  @override
  String diaryStatsUnusedCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count marcadores que tens não estão em nenhuma entrada.',
      one: '1 marcador que tens não está em nenhuma entrada.',
    );
    return '$_temp0';
  }

  @override
  String get diaryStatsUnusedNone =>
      'Todos os teus marcadores estão em alguma entrada.';

  @override
  String get diaryStatsUnusedNoCollection =>
      'Adiciona os teus marcadores em A minha coleção para ver quais ainda não usaste.';

  @override
  String get diaryStatsUnusedShow => 'Mostrar a lista';

  @override
  String get diaryStatsUnusedHide => 'Ocultar a lista';

  @override
  String get diaryStatsPalettesTitle => 'Paletas que mais ligas';

  @override
  String get diaryStatsPalettesEmpty =>
      'Nenhuma entrada liga uma paleta guardada ainda.';

  @override
  String diaryShareMore(int count) {
    return '+$count mais';
  }
}
