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
      'Um ficheiro ZIP com os teus dados e todas as tuas fotos: diário, amostras e receitas. No menu de partilha, escolhe Ficheiros, Drive ou outra app para o guardar. A chave da API nunca é incluída.';

  @override
  String get settingsBackupTextTitle => 'Copiar como texto (sem fotos)';

  @override
  String get settingsSaveBackupFile => 'Partilhar cópia de segurança';

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
      'O Ink Lab é um projeto comunitário independente: não está afiliado, apoiado nem patrocinado por nenhuma das marcas de marcadores que apresenta. Usa os seus códigos, nomes e valores de cor apenas como dados factuais de referência.';

  @override
  String get paletteTitle => 'Paleta';

  @override
  String get paletteBaseCodeLabel => 'Código do marcador base';

  @override
  String get paletteBaseChooseHint => 'Escolhe um marcador';

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
  String get paletteSavedButton => 'Paleta guardada';

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
  String missingMarkersTitle(String brand) {
    return 'Ainda não tens marcadores $brand';
  }

  @override
  String get missingMarkersAction => 'Ir para A minha coleção';

  @override
  String get paletteCustomModeHint =>
      'O modo de paleta personalizada é manual: carrega uma paleta guardada ou aplica uma das Ideias.';

  @override
  String get paletteNoSuggestions =>
      'Não foi possível criar nenhuma paleta com a tua coleção. Experimenta outro modo ou junta mais marcadores.';

  @override
  String get paletteScenarioTitle => 'Cenas';

  @override
  String get palettePickBaseTooltip => 'Escolher entre os teus marcadores';

  @override
  String get palettePickerTitle => 'Escolhe o marcador base';

  @override
  String get palettePickerSearchHint => 'Código ou nome';

  @override
  String palettePickerSearchExample(String code) {
    return 'Código ou nome, p. ex. $code';
  }

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
  String swatchesClosestTo(String hex) {
    return 'Mais próximos de $hex';
  }

  @override
  String get swatchesClearSearch => 'Limpar pesquisa';

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
  String get swatchesClearSearchAndFilters => 'Limpar pesquisa e filtros';

  @override
  String get swatchesLoadingSemantics => 'A carregar cores';

  @override
  String get swatchesClosestAlternatives => 'Alternativas próximas';

  @override
  String get swatchesNoCloseAlternatives => 'Sem alternativas próximas';

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
  String get swatchesEmptyNoFavoritesTitle => 'Ainda não há favoritos';

  @override
  String get swatchesEmptyNoFavoritesBody =>
      'Toca na estrela nos detalhes de uma cor para a adicionar.';

  @override
  String get swatchesEmptyNoFavoritesAction => 'Ver todas as cores';

  @override
  String get swatchesEmptyFavoritesNotMineTitle =>
      'Nenhum favorito na tua coleção';

  @override
  String get swatchesEmptyFavoritesNotMineBody =>
      'Nenhum dos teus favoritos é um marcador que tens.';

  @override
  String get swatchesEmptyFavoritesNotMineAction => 'Ver todos os favoritos';

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
  String get missingMarkersHint =>
      'Assinala os teus marcadores em A minha coleção para veres quais usar';

  @override
  String get allMarkersDried =>
      'Todos os teus marcadores estão secos. Marca-os de novo como utilizáveis para os usar.';

  @override
  String get ideasTulipFieldTitle => 'Campo de tulipas';

  @override
  String get ideasTulipFieldSummary =>
      'Filas de tulipas vermelhas e amarelas até ao horizonte, com verde primaveril entre elas.';

  @override
  String get ideasTulipFieldPractice =>
      'Faixas chapadas que se desfazem em pontos à medida que se aproximam.';

  @override
  String get ideasTulipFieldSubject =>
      'Filas de tulipas vistas de baixo, com um horizonte baixo.';

  @override
  String get ideasTulipFieldTip =>
      'A fila mais próxima é feita de pontos e a mais distante é uma risca: muda a marca à medida que a fila se afasta.';

  @override
  String get ideasTulipFieldStep1 =>
      'Desenha a lápis filas que se estreitam em direção a um horizonte baixo.';

  @override
  String get ideasTulipFieldStep2 =>
      'Vermelho nas primeiras filas: manchas soltas perto e uma risca contínua mais atrás.';

  @override
  String get ideasTulipFieldStep3 =>
      'Amarelo nas filas seguintes, da mesma maneira.';

  @override
  String get ideasTulipFieldStep4 =>
      'Verde claro entre as filas e ao longo do horizonte.';

  @override
  String get ideasTulipFieldStep5 =>
      'Verde mais escuro numa linha fina na base de cada fila.';

  @override
  String get ideasSummerBeachTitle => 'Na praia';

  @override
  String get ideasSummerBeachSummary =>
      'Areia, uma faixa de mar e um guarda-sol: três bandas chapadas e um acento vivo.';

  @override
  String get ideasSummerBeachPractice =>
      'Três bandas chapadas e um único acento que guia o olhar.';

  @override
  String get ideasSummerBeachSubject =>
      'Uma praia vista da areia, com um guarda-sol.';

  @override
  String get ideasSummerBeachTip =>
      'Deixa a espuma em papel branco: é a linha mais clara do mar.';

  @override
  String get ideasSummerBeachStep1 =>
      'Desenha a lápis três bandas horizontais (céu, mar e areia) e um guarda-sol na areia.';

  @override
  String get ideasSummerBeachStep2 =>
      'Areia clara, com a mão muito leve; deixa a areia molhada junto à água mais clara.';

  @override
  String get ideasSummerBeachStep3 =>
      'Azul-turquesa claro para o mar, com uma linha de papel para a espuma.';

  @override
  String get ideasSummerBeachStep4 =>
      'Azul-turquesa mais intenso no horizonte.';

  @override
  String get ideasSummerBeachStep5 =>
      'Guarda-sol vermelho e a sua pequena sombra na areia, feita com uma segunda camada da cor da areia.';

  @override
  String get ideasWatermelonSliceTitle => 'Melancia';

  @override
  String get ideasWatermelonSliceSummary =>
      'Uma fatia de melancia: polpa vermelha, casca branca, pele verde e sementes pretas.';

  @override
  String get ideasWatermelonSlicePractice =>
      'Uma mistura rápida e uma risca chapada, com a casca branca deixada em papel.';

  @override
  String get ideasWatermelonSliceSubject =>
      'Uma fatia triangular de melancia com a base curva.';

  @override
  String get ideasWatermelonSliceTip =>
      'A casca branca é papel: não lhe ponhas cor.';

  @override
  String get ideasWatermelonSliceStep1 =>
      'Desenha a lápis um triângulo com a base curva e uma faixa branca fina dentro do verde.';

  @override
  String get ideasWatermelonSliceStep2 =>
      'O vermelho claro sobre a polpa, mais pálido junto à casca.';

  @override
  String get ideasWatermelonSliceStep3 =>
      'Vermelho mais intenso em direção à ponta, misturado enquanto está húmido.';

  @override
  String get ideasWatermelonSliceStep4 =>
      'Verde na pele, com riscas verde-escuras numa segunda camada.';

  @override
  String get ideasWatermelonSliceStep5 =>
      'As sementes com o fineliner, cada uma uma pequena gota.';

  @override
  String get ideasForestMushroomsTitle => 'Cogumelos no chão da floresta';

  @override
  String get ideasForestMushroomsSummary =>
      'Um grupo de cogumelos entre folhas castanhas no outono.';

  @override
  String get ideasForestMushroomsPractice =>
      'Chapéus redondos com pequenas misturas e um chão solto e seco.';

  @override
  String get ideasForestMushroomsSubject =>
      'Três cogumelos de alturas diferentes entre folhas caídas.';

  @override
  String get ideasForestMushroomsTip =>
      'O chão da floresta pede traços castanhos soltos e interrompidos, não preenchimentos cheios.';

  @override
  String get ideasForestMushroomsStep1 =>
      'Desenha a lápis três cogumelos de alturas diferentes e algumas folhas à volta.';

  @override
  String get ideasForestMushroomsStep2 =>
      'Bege claro nos pés e na parte de baixo dos chapéus.';

  @override
  String get ideasForestMushroomsStep3 =>
      'O castanho-avermelhado nos chapéus, mais escuro no bordo.';

  @override
  String get ideasForestMushroomsStep4 => 'Castanho nas folhas e no chão.';

  @override
  String get ideasForestMushroomsStep5 =>
      'O mais escuro debaixo dos chapéus e onde os pés tocam o chão; se quiseres, pontos de gel branco nos chapéus.';

  @override
  String get ideasHarvestBasketTitle => 'Cesto da colheita';

  @override
  String get ideasHarvestBasketSummary =>
      'Maçãs, uma pera e uma pequena abóbora num cesto, cada uma de uma cor, sombreadas com um só cinzento.';

  @override
  String get ideasHarvestBasketPractice =>
      'Um só cinzento a sombrear três cores fortes para que fiquem juntas.';

  @override
  String get ideasHarvestBasketSubject =>
      'Um cesto cheio de fruta: maçãs, uma pera e uma abóbora.';

  @override
  String get ideasHarvestBasketTip =>
      'Sombreia toda a fruta com o mesmo cinzento. É isso que mantém unida uma natureza-morta cheia.';

  @override
  String get ideasHarvestBasketStep1 =>
      'Desenha a lápis o cesto e a fruta sobreposta.';

  @override
  String get ideasHarvestBasketStep2 =>
      'Vermelho para as maçãs, com o brilho deixado em papel.';

  @override
  String get ideasHarvestBasketStep3 => 'Verde-amarelado para a pera.';

  @override
  String get ideasHarvestBasketStep4 =>
      'Laranja para a abóbora, com as nervuras em linhas mais escuras numa segunda camada.';

  @override
  String get ideasHarvestBasketStep5 =>
      'O mesmo cinzento para todas as sombras e para o interior do cesto.';

  @override
  String get ideasHarvestBasketStep6 =>
      'O marcador mais escuro para as linhas do trançado do cesto.';

  @override
  String get ideasHotChocolateTitle => 'Chocolate quente';

  @override
  String get ideasHotChocolateSummary =>
      'Uma caneca de chocolate com vapor, um marshmallow e uma luva vermelha.';

  @override
  String get ideasHotChocolatePractice =>
      'Castanhos quentes, um acento vermelho e vapor levantado do fundo.';

  @override
  String get ideasHotChocolateSubject =>
      'Uma caneca de chocolate quente com um marshmallow e uma luva ao lado.';

  @override
  String get ideasHotChocolateTip =>
      'O vapor é papel ou uma forma levantada com o misturador, nunca uma linha desenhada.';

  @override
  String get ideasHotChocolateStep1 =>
      'Desenha a lápis a caneca, a superfície da bebida, um marshmallow e uma luva encostada.';

  @override
  String get ideasHotChocolateStep2 =>
      'Castanho claro no lado iluminado da caneca e na sombra do marshmallow.';

  @override
  String get ideasHotChocolateStep3 =>
      'Castanho na superfície da bebida e no lado da sombra da caneca.';

  @override
  String get ideasHotChocolateStep4 => 'Luva vermelha, em duas camadas.';

  @override
  String get ideasHotChocolateStep5 =>
      'Vapor: levanta fios do fundo com o misturador ou deixa-os em papel.';

  @override
  String get ideasLunarNewYearTitle => 'Ano Novo Lunar';

  @override
  String get ideasLunarNewYearSummary =>
      'Lanternas vermelhas com remates dourados contra uma parede vermelha.';

  @override
  String get ideasLunarNewYearPractice =>
      'Uma só família de vermelhos em três passos e um acento dourado chapado.';

  @override
  String get ideasLunarNewYearSubject =>
      'Três lanternas redondas penduradas a alturas diferentes, com borlas.';

  @override
  String get ideasLunarNewYearTip =>
      'Põe o dourado sobre o vermelho seco, nunca ao contrário.';

  @override
  String get ideasLunarNewYearStep1 =>
      'Desenha a lápis três lanternas penduradas a alturas diferentes, com borlas.';

  @override
  String get ideasLunarNewYearStep2 =>
      'Vermelho claro sobre as lanternas, mais pálido no lado iluminado.';

  @override
  String get ideasLunarNewYearStep3 =>
      'O vermelho no lado da sombra e nas nervuras, misturado enquanto está húmido.';

  @override
  String get ideasLunarNewYearStep4 =>
      'Vermelho escuro entre as nervuras e dentro dos bordos.';

  @override
  String get ideasLunarNewYearStep5 =>
      'Amarelo dourado nos bordos, nas tampas e nas borlas, deixado nítido.';

  @override
  String get ideasDiwaliLampsTitle => 'Lamparinas de Diwali';

  @override
  String get ideasDiwaliLampsSummary =>
      'Uma fila de lamparinas de barro com pequenas chamas e uma rangoli de cores vivas à volta.';

  @override
  String get ideasDiwaliLampsPractice =>
      'Um padrão chapado e saturado ao lado de uma mistura em dois passos nas lamparinas.';

  @override
  String get ideasDiwaliLampsSubject =>
      'Cinco pequenas lamparinas de barro em curva, com um padrão simétrico simples à volta.';

  @override
  String get ideasDiwaliLampsTip =>
      'Mantém o padrão chapado e de bordos duros. É o contraste com as lamparinas que o faz resultar.';

  @override
  String get ideasDiwaliLampsStep1 =>
      'Desenha a lápis cinco pequenas lamparinas em curva e um padrão simétrico simples à volta.';

  @override
  String get ideasDiwaliLampsStep2 => 'Terracota claro nas lamparinas.';

  @override
  String get ideasDiwaliLampsStep3 =>
      'Terracota mais intenso no lado da sombra.';

  @override
  String get ideasDiwaliLampsStep4 =>
      'Amarelo para cada chama e um brilho no bordo de cada lamparina.';

  @override
  String get ideasDiwaliLampsStep5 =>
      'Magenta nas secções alternadas do padrão, chapado e de bordos duros.';

  @override
  String get ideasDiwaliLampsStep6 =>
      'Azul-turquesa nas outras secções e, se quiseres, pontos de gel branco nas chamas.';

  @override
  String get ideasHanukkahCandlesTitle => 'Hanucá';

  @override
  String get ideasHanukkahCandlesSummary =>
      'Uma menorá com as velas acesas, azul e branca com chamas douradas.';

  @override
  String get ideasHanukkahCandlesPractice =>
      'Formas brancas deixadas em papel contra um fundo azul.';

  @override
  String get ideasHanukkahCandlesSubject =>
      'Uma menorá com as velas acesas em frente a um fundo azul.';

  @override
  String get ideasHanukkahCandlesTip =>
      'As velas são papel: pinta à volta delas e ficam brancas.';

  @override
  String get ideasHanukkahCandlesStep1 =>
      'Desenha a lápis a menorá e as velas; as velas ficam em papel.';

  @override
  String get ideasHanukkahCandlesStep2 => 'Fundo azul claro à volta de tudo.';

  @override
  String get ideasHanukkahCandlesStep3 =>
      'Azul mais intenso nos bordos da página, misturado para dentro.';

  @override
  String get ideasHanukkahCandlesStep4 =>
      'O azul escuro para a própria menorá.';

  @override
  String get ideasHanukkahCandlesStep5 =>
      'Chamas amarelas e um brilho suave à volta de cada uma e, depois, um núcleo de gel branco em cada chama.';

  @override
  String get ideasPaintedEggsTitle => 'Ovos pintados';

  @override
  String get ideasPaintedEggsSummary =>
      'Três ovos decorados com riscas, pontos e ziguezagues em cores de intensidade média.';

  @override
  String get ideasPaintedEggsPractice =>
      'Três maneiras de fazer um padrão: papel, forma e segunda camada.';

  @override
  String get ideasPaintedEggsSubject =>
      'Três ovos, cada um com um padrão diferente.';

  @override
  String get ideasPaintedEggsTip =>
      'As cores de intensidade média deixam ver uma segunda camada sem ficarem sujas.';

  @override
  String get ideasPaintedEggsStep1 =>
      'Desenha a lápis três ovos e um padrão diferente em cada um.';

  @override
  String get ideasPaintedEggsStep2 =>
      'Primeiro ovo: cor de base chapada, com o padrão deixado em papel.';

  @override
  String get ideasPaintedEggsStep3 =>
      'Segundo ovo: pinta só as formas do padrão; o resto fica em papel.';

  @override
  String get ideasPaintedEggsStep4 =>
      'Terceiro ovo: pinta-o e depois acrescenta o padrão com a mesma cor, numa segunda camada.';

  @override
  String get ideasPaintedEggsStep5 =>
      'Um cinzento para o lado da sombra de cada ovo e para a pequena sombra por baixo.';

  @override
  String get ideasDiaDeMuertosTitle => 'Dia dos Mortos';

  @override
  String get ideasDiaDeMuertosSummary =>
      'Cravos-de-defunto e uma caveira decorada em laranja, magenta e azul-turquesa sobre fundo escuro.';

  @override
  String get ideasDiaDeMuertosPractice =>
      'Padrão chapado e saturado sobre um fundo escuro.';

  @override
  String get ideasDiaDeMuertosSubject =>
      'Uma caveira decorada com flores à volta dos olhos e um canteiro de cravos-de-defunto por baixo.';

  @override
  String get ideasDiaDeMuertosTip =>
      'Põe o fundo escuro no fim e devagar: a tinta escura corre para as zonas claras.';

  @override
  String get ideasDiaDeMuertosStep1 =>
      'Desenha a lápis uma caveira com flores à volta dos olhos e um canteiro de cravos-de-defunto por baixo.';

  @override
  String get ideasDiaDeMuertosStep2 =>
      'Laranja claro nos cravos, cada um como um círculo irregular.';

  @override
  String get ideasDiaDeMuertosStep3 =>
      'Laranja mais intenso em traços curtos dentro de cada círculo, para as pétalas.';

  @override
  String get ideasDiaDeMuertosStep4 =>
      'Magenta para os padrões da caveira, chapado e simétrico.';

  @override
  String get ideasDiaDeMuertosStep5 =>
      'Azul-turquesa para a outra metade dos padrões da caveira.';

  @override
  String get ideasDiaDeMuertosStep6 =>
      'O marcador mais escuro para as órbitas e o fundo e, depois, detalhes com o fineliner.';

  @override
  String get ideasValentineCardTitle => 'Cartão de namorados';

  @override
  String get ideasValentineCardSummary =>
      'Um cartão com três corações, do rosa pálido ao vermelho intenso, e uma linha de sombra que os destaca do papel.';

  @override
  String get ideasValentineCardPractice =>
      'Três preenchimentos chapados e uma linha de sombra.';

  @override
  String get ideasValentineCardSubject =>
      'Três corações sobrepostos, o maior ao fundo.';

  @override
  String get ideasValentineCardTip =>
      'Desenha a sombra projetada com uma só linha fina: destaca o coração sem mais cor.';

  @override
  String get ideasValentineCardStep1 =>
      'Desenha a lápis três corações sobrepostos, o maior ao fundo.';

  @override
  String get ideasValentineCardStep2 => 'Rosa pálido no coração de trás.';

  @override
  String get ideasValentineCardStep3 => 'Rosa no do meio.';

  @override
  String get ideasValentineCardStep4 =>
      'Vermelho no da frente e uma linha fina do mesmo vermelho por baixo dos outros dois, como sombra projetada.';

  @override
  String get ideasValentineCardStep5 =>
      'Um brilho de gel branco em cada coração, em cima à esquerda.';

  @override
  String get ideasCarnivalMaskTitle => 'Máscara de Carnaval';

  @override
  String get ideasCarnivalMaskSummary =>
      'Uma máscara com penas em violeta, azul-turquesa e dourado.';

  @override
  String get ideasCarnivalMaskPractice =>
      'Toques rápidos para as penas, uma mistura para a máscara e dourado chapado.';

  @override
  String get ideasCarnivalMaskSubject =>
      'Uma meia máscara com três penas a sair de um lado.';

  @override
  String get ideasCarnivalMaskTip =>
      'Faz as penas com toques para fora a partir da haste: o bordo suave é o que as faz parecer penas.';

  @override
  String get ideasCarnivalMaskStep1 =>
      'Desenha a lápis uma meia máscara e três penas a sair de um lado.';

  @override
  String get ideasCarnivalMaskStep2 =>
      'Violeta na máscara, em duas camadas onde se curva.';

  @override
  String get ideasCarnivalMaskStep3 =>
      'Azul-turquesa nas penas, com toques para fora a partir da haste para os bordos ficarem suaves.';

  @override
  String get ideasCarnivalMaskStep4 =>
      'Dourado no bordo da máscara e nos contornos dos olhos.';

  @override
  String get ideasCarnivalMaskStep5 =>
      'O mais escuro dentro dos buracos dos olhos e, depois, pontos de gel como lantejoulas.';

  @override
  String get ideasMidsummerCrownTitle => 'Coroa de flores de verão';

  @override
  String get ideasMidsummerCrownSummary =>
      'Uma coroa de flores silvestres e folhas: azul, amarelo e rosa sobre verde.';

  @override
  String get ideasMidsummerCrownPractice =>
      'Muitos pequenos toques da ponta fina sobre uma base verde seca.';

  @override
  String get ideasMidsummerCrownSubject =>
      'Um anel de folhas com três tipos de pequenas flores silvestres.';

  @override
  String get ideasMidsummerCrownTip =>
      'Toques de cor sobre uma base seca ficam nítidos. Espera que o verde seque antes de começares as flores.';

  @override
  String get ideasMidsummerCrownStep1 =>
      'Desenha a lápis um anel de folhas e pequenas flores de três tipos.';

  @override
  String get ideasMidsummerCrownStep2 => 'Verde claro em todas as folhas.';

  @override
  String get ideasMidsummerCrownStep3 =>
      'Verde mais escuro onde as folhas se sobrepõem e por baixo.';

  @override
  String get ideasMidsummerCrownStep4 => 'Azul no primeiro tipo de flor.';

  @override
  String get ideasMidsummerCrownStep5 => 'Amarelo no segundo tipo de flor.';

  @override
  String get ideasMidsummerCrownStep6 =>
      'Rosa no terceiro, com uma minúscula segunda camada no centro de cada flor.';

  @override
  String get ideasEidNightTitle => 'Noite de Eid';

  @override
  String get ideasEidNightSummary =>
      'Uma lua crescente e uma lanterna suspensa contra um céu azul-turquesa e violeta escuro.';

  @override
  String get ideasEidNightPractice =>
      'Uma mistura húmida limpa do azul-turquesa ao violeta, com dourado por cima.';

  @override
  String get ideasEidNightSubject =>
      'Uma lua crescente e uma lanterna com padrões contra um céu noturno.';

  @override
  String get ideasEidNightTip =>
      'Mistura o azul-turquesa no violeta enquanto ambos estão húmidos. Depois de secar, o céu fica limpo.';

  @override
  String get ideasEidNightStep1 =>
      'Desenha a lápis o crescente e uma lanterna com padrões; ambos ficam em papel por agora.';

  @override
  String get ideasEidNightStep2 =>
      'Azul-turquesa pelo céu, mais claro junto à lua.';

  @override
  String get ideasEidNightStep3 =>
      'Azul-turquesa mais intenso em direção aos bordos.';

  @override
  String get ideasEidNightStep4 =>
      'Violeta misturado nos cantos de cima enquanto o azul-turquesa ainda está húmido.';

  @override
  String get ideasEidNightStep5 =>
      'Dourado no crescente e na armação da lanterna; os vidros ficam claros e, depois, estrelas de gel branco.';

  @override
  String get ideasHoliColoursTitle => 'Holi';

  @override
  String get ideasHoliColoursSummary =>
      'Nuvens de pó colorido sobre branco: bordos suaves, centros duros, quatro cores vivas.';

  @override
  String get ideasHoliColoursPractice =>
      'Cor sem bordo: o misturador dissolve um bordo no papel.';

  @override
  String get ideasHoliColoursSubject =>
      'Quatro nuvens sobrepostas de pó colorido sobre papel branco.';

  @override
  String get ideasHoliColoursTip =>
      'Deixa cada nuvem secar antes de juntares a seguinte, senão todas as cores ficam sujas.';

  @override
  String get ideasHoliColoursStep1 =>
      'Rabisca uma nuvem solta com a primeira cor, mais densa no meio.';

  @override
  String get ideasHoliColoursStep2 =>
      'Puxa os bordos com o misturador para o papel branco até desaparecerem.';

  @override
  String get ideasHoliColoursStep3 =>
      'Uma segunda nuvem a sobrepor-se um pouco à primeira; onde se encontram, deixa-as misturar.';

  @override
  String get ideasHoliColoursStep4 =>
      'Uma terceira nuvem, mais pequena, num espaço livre.';

  @override
  String get ideasHoliColoursStep5 =>
      'Uma quarta nuvem no último espaço livre e, depois, faz saltar alguns pontos de cada cor à volta.';

  @override
  String get ideasSummerIceCreamTitle => 'Gelado';

  @override
  String get ideasSummerIceCreamSummary =>
      'Três bolas de sabores diferentes num cone.';

  @override
  String get ideasSummerIceCreamPractice =>
      'Três misturas redondas e um só cinzento a sombrear todas.';

  @override
  String get ideasSummerIceCreamSubject =>
      'Três bolas empilhadas num cone com uma grelha de bolacha.';

  @override
  String get ideasSummerIceCreamTip =>
      'Usa o mesmo cinzento em todas as bolas: é isso que mantém juntas três cores diferentes.';

  @override
  String get ideasSummerIceCreamStep1 =>
      'Desenha a lápis um cone com uma grelha de bolacha e três bolas empilhadas.';

  @override
  String get ideasSummerIceCreamStep2 =>
      'O primeiro sabor na bola de baixo, com um brilho de papel deixado nela.';

  @override
  String get ideasSummerIceCreamStep3 =>
      'O segundo sabor na bola do meio, com o seu próprio brilho.';

  @override
  String get ideasSummerIceCreamStep4 => 'O terceiro sabor na bola de cima.';

  @override
  String get ideasSummerIceCreamStep5 =>
      'O mesmo cinzento claro na parte de baixo de cada bola e onde se sobrepõem.';

  @override
  String get ideasSummerIceCreamStep6 =>
      'O cone em bege, com as linhas da grelha numa segunda camada.';

  @override
  String get ideasNewYearFireworksTitle => 'Fogos de Ano Novo';

  @override
  String get ideasNewYearFireworksSummary =>
      'Três explosões de fogo de artifício sobre um céu escuro, cada uma de uma cor.';

  @override
  String get ideasNewYearFireworksPractice =>
      'Cor viva sobre um preenchimento escuro, com as linhas deixadas em papel.';

  @override
  String get ideasNewYearFireworksSubject =>
      'Três explosões de fogo de artifício com linhas de luz a irradiar de cada centro.';

  @override
  String get ideasNewYearFireworksTip =>
      'Preenche o céu à volta das linhas, não por cima: o papel branco é o que faz o fogo de artifício brilhar.';

  @override
  String get ideasNewYearFireworksStep1 =>
      'Desenha a lápis três centros e linhas de luz a irradiar de cada um; as linhas ficam em papel por agora.';

  @override
  String get ideasNewYearFireworksStep2 =>
      'Preenche o céu de escuro, contornando as linhas com a ponta fina (podem ficar irregulares).';

  @override
  String get ideasNewYearFireworksStep3 =>
      'Traça as linhas da primeira explosão com a primeira cor, pressionando mais nas pontas.';

  @override
  String get ideasNewYearFireworksStep4 =>
      'As linhas da segunda explosão com a segunda cor.';

  @override
  String get ideasNewYearFireworksStep5 =>
      'As linhas da terceira explosão com a terceira cor.';

  @override
  String get ideasNewYearFireworksStep6 =>
      'Gel branco no centro de cada explosão e algumas faíscas nas pontas.';

  @override
  String get ideasCozyLampTitle => 'Cantinho acolhedor';

  @override
  String get ideasCozyLampSummary =>
      'Uma poltrona debaixo de uma lâmpada ao fim do dia: um charco de luz quente e sombras castanhas suaves.';

  @override
  String get ideasCozyLampPractice =>
      'Planear uma zona iluminada e deixar o resto da sala cair num castanho quente.';

  @override
  String get ideasCozyLampSubject =>
      'Uma poltrona, um candeeiro de pé e uma parede por trás.';

  @override
  String get ideasCozyLampTip =>
      'Não metas o castanho mais escuro no círculo de luz: a lâmpada não chega a nenhum canto.';

  @override
  String get ideasCozyLampStep1 =>
      'Desenha a lápis a poltrona, a lâmpada e o círculo de luz que ela deita no chão e na parede.';

  @override
  String get ideasCozyLampStep2 =>
      'Preenche o círculo de luz com o amarelo pálido e desfá-lo com o misturador incolor.';

  @override
  String get ideasCozyLampStep3 =>
      'Colore o resto da sala com o bege quente claro, de forma plana e uniforme.';

  @override
  String get ideasCozyLampStep4 =>
      'Põe o castanho quente na poltrona e no lado da sala que fica longe da lâmpada.';

  @override
  String get ideasCozyLampStep5 =>
      'Usa o castanho escuro nos cantos e debaixo da poltrona, e tira-o do círculo de luz.';

  @override
  String get ideasFoggyMorningTitle => 'Nevoeiro';

  @override
  String get ideasFoggyMorningSummary =>
      'Árvores a desaparecerem no nevoeiro: as mais perto mais escuras, as mais longe mais pálidas.';

  @override
  String get ideasFoggyMorningPractice =>
      'Profundidade com um véu pálido por cima de formas escuras.';

  @override
  String get ideasFoggyMorningSubject =>
      'Três filas de árvores ao longo de um caminho, cada uma mais longe.';

  @override
  String get ideasFoggyMorningTip =>
      'Um véu pálido sobre uma forma escura é o nevoeiro mais simples que há: a tinta de baixo fica.';

  @override
  String get ideasFoggyMorningStep1 =>
      'Desenha a lápis três filas de árvores, cada uma mais longe, e marca onde começa o chão.';

  @override
  String get ideasFoggyMorningStep2 =>
      'Colore a fila mais distante só com o marcador mais pálido, sem nenhum detalhe.';

  @override
  String get ideasFoggyMorningStep3 =>
      'Colore a fila do meio com o tom base e suaviza o seu bordo inferior para o chão com o misturador.';

  @override
  String get ideasFoggyMorningStep4 =>
      'Desenha as árvores mais próximas com o marcador escuro e acrescenta alguns ramos.';

  @override
  String get ideasFoggyMorningStep5 =>
      'Passa um véu do marcador pálido por cima de todas as filas, para que o nevoeiro cubra toda a cena.';

  @override
  String get ideasRainyWindowTitle => 'Chuva no vidro';

  @override
  String get ideasRainyWindowSummary =>
      'Luzes desfocadas vistas através de um vidro molhado, com gotas a escorrerem.';

  @override
  String get ideasRainyWindowPractice =>
      'Luzes a brilhar atrás do vidro e marcas nítidas por cima.';

  @override
  String get ideasRainyWindowSubject =>
      'Uma janela à noite com candeeiros lá fora e três gotas no vidro.';

  @override
  String get ideasRainyWindowTip =>
      'As luzes têm de secar por completo antes de o azul passar por cima, senão as cores misturam-se.';

  @override
  String get ideasRainyWindowStep1 =>
      'Desenha a lápis a moldura da janela e algumas manchas de luz desfocadas lá fora, e marca o percurso de três gotas.';

  @override
  String get ideasRainyWindowStep2 =>
      'Colore as luzes quentes como manchas macias e desfaz os seus bordos com o misturador.';

  @override
  String get ideasRainyWindowStep3 =>
      'Cobre todo o vidro com o azul claro, a contornar as luzes.';

  @override
  String get ideasRainyWindowStep4 =>
      'Junta o azul base para os cantos e deixa os percursos das gotas um pouco mais claros.';

  @override
  String get ideasRainyWindowStep5 =>
      'Colore a moldura de escuro e põe uma meia-lua escura do lado de cada gota oposto à luz.';

  @override
  String get ideasRainyWindowStep6 =>
      'Quando estiver seco, junta um toque de gel branco do lado iluminado de cada gota.';

  @override
  String get ideasEerieForestTitle => 'Bosque inquietante';

  @override
  String get ideasEerieForestSummary =>
      'Árvores finas ao anoitecer, em verdes doentios, com um céu violeta entre elas.';

  @override
  String get ideasEerieForestPractice =>
      'Deixar que duas cores se misturem onde se tocam, de propósito.';

  @override
  String get ideasEerieForestSubject =>
      'Troncos altos e finos sobre um horizonte baixo ao anoitecer.';

  @override
  String get ideasEerieForestTip =>
      'O verde e o violeta ficam cinzentos onde se tocam. Esse cinzento é o ambiente, não um erro.';

  @override
  String get ideasEerieForestStep1 =>
      'Desenha a lápis troncos altos e finos e um horizonte baixo.';

  @override
  String get ideasEerieForestStep2 =>
      'Põe um verde-amarelo pálido ao longo do horizonte, entre os troncos.';

  @override
  String get ideasEerieForestStep3 =>
      'Colore o violeta por cima e funde-o com o verde enquanto ainda está húmido.';

  @override
  String get ideasEerieForestStep4 =>
      'Colore o verde do chão e da parte de baixo dos troncos.';

  @override
  String get ideasEerieForestStep5 =>
      'Usa o verde mais escuro nos troncos com traços irregulares, e junta sombras longas pelo chão.';

  @override
  String get ideasGoldenHourTitle => 'Hora dourada';

  @override
  String get ideasGoldenHourSummary =>
      'Uma parede branca e uma porta ao fim da tarde: luz laranja, sombras violetas longas.';

  @override
  String get ideasGoldenHourPractice =>
      'Um véu quente por cima de tudo, com sombras frias de bordo nítido por cima.';

  @override
  String get ideasGoldenHourSubject =>
      'Uma parede com uma porta, uma planta e a sombra longa que a planta deita na parede.';

  @override
  String get ideasGoldenHourTip =>
      'A parede aqui não é branca: com esta luz é laranja. Pinta-a assim.';

  @override
  String get ideasGoldenHourStep1 =>
      'Desenha a lápis uma parede com uma porta e uma planta, e a sombra longa que a planta deita na parede.';

  @override
  String get ideasGoldenHourStep2 =>
      'Cobre toda a parede com o laranja pálido: essa é a parede branca com esta luz.';

  @override
  String get ideasGoldenHourStep3 =>
      'Põe o laranja mais forte debaixo da verga e na porta.';

  @override
  String get ideasGoldenHourStep4 =>
      'Junta o cinzento-violeta na sombra da planta e no vão da porta, com um bordo nítido.';

  @override
  String get ideasGoldenHourStep5 =>
      'Reserva o marcador mais escuro só para o fundo do vão da porta.';

  @override
  String get ideasStormySeaTitle => 'Mar tempestuoso';

  @override
  String get ideasStormySeaSummary =>
      'Ondas cinzento-esverdeadas debaixo de um céu escuro, com papel branco para a espuma.';

  @override
  String get ideasStormySeaPractice =>
      'Água plana e pálida contra um céu pesado, com a espuma deixada em papel.';

  @override
  String get ideasStormySeaSubject =>
      'Um horizonte baixo, duas ondas grandes e a espuma a quebrar nelas.';

  @override
  String get ideasStormySeaTip =>
      'A espuma é papel que não tocaste: planeia onde ela quebra antes de colorares a água.';

  @override
  String get ideasStormySeaStep1 =>
      'Desenha a lápis o horizonte baixo, duas ondas grandes e onde a espuma quebra. A espuma fica em papel.';

  @override
  String get ideasStormySeaStep2 =>
      'Cobre a água com o cinzento-esverdeado pálido, a contornar a espuma.';

  @override
  String get ideasStormySeaStep3 =>
      'Põe a água mais escura nos vales e debaixo de cada crista.';

  @override
  String get ideasStormySeaStep4 =>
      'Preenche o céu com o marcador escuro, mais escuro em cima, e a água mais profunda debaixo da onda que quebra.';

  @override
  String get ideasStormySeaStep5 =>
      'Quando estiver seco, junta gel branco para a espuma que salta das cristas: só alguns pontos.';

  @override
  String get ideasCandleFlameTitle => 'À luz da vela';

  @override
  String get ideasCandleFlameSummary =>
      'Uma vela numa mesa numa sala escura: tudo quente, e nada longe da chama à vista.';

  @override
  String get ideasCandleFlamePractice =>
      'Anéis concêntricos de cor quente, fundidos uns nos outros ainda húmidos.';

  @override
  String get ideasCandleFlameSubject =>
      'Uma vela no seu castiçalho, com a mesa e a parede do fundo por trás.';

  @override
  String get ideasCandleFlameTip =>
      'Só se vê o que a chama toca: o fundo da sala pode ser quase uma mancha escura.';

  @override
  String get ideasCandleFlameStep1 =>
      'Desenha a lápis a vela, a sua chama e um círculo de luz na mesa. O núcleo da chama fica em papel.';

  @override
  String get ideasCandleFlameStep2 =>
      'Colore o halo da chama e a parte da mesa mais próxima com o amarelo, desfeito para fora com o misturador.';

  @override
  String get ideasCandleFlameStep3 =>
      'Põe o laranja quente no lado iluminado da vela e no anel seguinte da mesa.';

  @override
  String get ideasCandleFlameStep4 =>
      'Colore de castanho tudo o que fica para lá do círculo de luz.';

  @override
  String get ideasCandleFlameStep5 =>
      'Usa o castanho mais escuro para o fundo da sala e o lado na sombra da vela, com um bordo suave contra a luz.';

  @override
  String get ideasDesertNoonTitle => 'Meio-dia no deserto';

  @override
  String get ideasDesertNoonSummary =>
      'Areia, uma rocha e uma sombra dura debaixo de um céu branqueado.';

  @override
  String get ideasDesertNoonPractice =>
      'Um preenchimento plano e pálido contra uma sombra dura e escura.';

  @override
  String get ideasDesertNoonSubject =>
      'Um horizonte alto, uma única rocha e a sua sombra curta mesmo por baixo.';

  @override
  String get ideasDesertNoonTip =>
      'Deixa uma faixa de papel branco no horizonte: é essa faixa que faz o céu parecer quente.';

  @override
  String get ideasDesertNoonStep1 =>
      'Desenha a lápis um horizonte alto, uma rocha e a sua sombra curta mesmo por baixo.';

  @override
  String get ideasDesertNoonStep2 =>
      'Cobre a areia por baixo do horizonte com o amarelo pálido, numa passagem muito leve.';

  @override
  String get ideasDesertNoonStep3 =>
      'Colore o céu com o azul pálido e deixa-o mais claro perto do horizonte.';

  @override
  String get ideasDesertNoonStep4 =>
      'Põe o laranja no lado na sombra da rocha e nas ondulações da areia.';

  @override
  String get ideasDesertNoonStep5 =>
      'Usa o azul-violeta só na sombra que a rocha deita, com um bordo duro.';

  @override
  String get ideasBokehLightsTitle => 'Luzes desfocadas';

  @override
  String get ideasBokehLightsSummary =>
      'Um fundo de círculos de luz suaves e desfocados.';

  @override
  String get ideasBokehLightsPractice =>
      'Fazer um disco suave com o misturador num campo plano.';

  @override
  String get ideasBokehLightsSubject =>
      'Um campo escuro com uma dúzia de luzes desfocadas de tamanhos diferentes.';

  @override
  String get ideasBokehLightsTip =>
      'Apoia o misturador de lado: uma ponta afiada desenha uma linha, não um disco.';

  @override
  String get ideasBokehLightsStep1 =>
      'Preenche toda a área com a cor base, em traços planos.';

  @override
  String get ideasBokehLightsStep2 =>
      'Escurece os cantos e funde o escuro para dentro enquanto a tinta está húmida.';

  @override
  String get ideasBokehLightsStep3 =>
      'Deixa secar e depois apoia a ponta larga do misturador de lado em círculos de tamanhos diferentes.';

  @override
  String get ideasBokehLightsStep4 =>
      'Toca o marcador claro no centro de alguns discos, para brilharem.';

  @override
  String get ideasBokehLightsStep5 =>
      'Põe um ponto de gel branco dentro de dois ou três discos, não em todos.';

  @override
  String get ideasRetroPosterTitle => 'Cartaz retro';

  @override
  String get ideasRetroPosterSummary =>
      'Três cores planas, um pouco poeirentas, e uma escura, sem misturar nada.';

  @override
  String get ideasRetroPosterPractice =>
      'Preenchimentos planos e bordos duros, como se vê um cartaz impresso.';

  @override
  String get ideasRetroPosterSubject =>
      'Um farol, um carro ou uma garrafa desenhados como poucas formas planas grandes.';

  @override
  String get ideasRetroPosterTip =>
      'Deixa entre as cores um fio de papel branco, como se a impressão tivesse escorregado um pouco.';

  @override
  String get ideasRetroPosterStep1 =>
      'Desenha a lápis um motivo simples em formas planas grandes: um farol, um carro, uma garrafa.';

  @override
  String get ideasRetroPosterStep2 =>
      'Preenche as formas maiores de forma plana, numa passagem.';

  @override
  String get ideasRetroPosterStep3 =>
      'Preenche as formas seguintes e deixa um fio de papel entre as cores.';

  @override
  String get ideasRetroPosterStep4 =>
      'Usa a terceira cor nas formas mais pequenas.';

  @override
  String get ideasRetroPosterStep5 =>
      'Desenha as sombras como formas planas à parte, com o marcador escuro.';

  @override
  String get ideasRetroPosterStep6 =>
      'Acrescenta algumas linhas de fineliner onde o cartaz impresso as teria.';

  @override
  String get ideasFreshCitrusTitle => 'Fresco e cítrico';

  @override
  String get ideasFreshCitrusSummary =>
      'Um limão, uma lima e um copo de água, com muito papel branco e no máximo duas camadas.';

  @override
  String get ideasFreshCitrusPractice => 'Cor viva sobre branco, acabada cedo.';

  @override
  String get ideasFreshCitrusSubject =>
      'Um limão, uma lima e um copo de água numa mesa.';

  @override
  String get ideasFreshCitrusTip =>
      'Para depois de duas camadas: uma terceira tira o frescor à cor.';

  @override
  String get ideasFreshCitrusStep1 =>
      'Desenha a lápis a fruta e o copo, e mantém a composição arejada.';

  @override
  String get ideasFreshCitrusStep2 =>
      'Colore o limão de amarelo numa passagem, deixando um brilho branco.';

  @override
  String get ideasFreshCitrusStep3 =>
      'Colore a lima de verde, também numa passagem.';

  @override
  String get ideasFreshCitrusStep4 =>
      'O amarelo mais escuro no lado da sombra do limão e uma segunda passagem de verde no lado da sombra da lima.';

  @override
  String get ideasFreshCitrusStep5 =>
      'Usa o azul pálido para a água no copo e uma sombra pequena por baixo de cada fruta.';

  @override
  String get ideasTropicalNoonTitle => 'Meio-dia tropical';

  @override
  String get ideasTropicalNoonSummary =>
      'Folhas grandes, uma flor rosa vivo e um pedaço de céu azul, saturados e de bordo duro.';

  @override
  String get ideasTropicalNoonPractice =>
      'Cor forte e plana com sobreposições nítidas, sem misturar nada.';

  @override
  String get ideasTropicalNoonSubject =>
      'Duas ou três folhas grandes sobrepostas, uma flor e o céu nas falhas.';

  @override
  String get ideasTropicalNoonTip =>
      'Deixa o bordo de cada folha nítido: é a sobreposição que dá a profundidade aqui.';

  @override
  String get ideasTropicalNoonStep1 =>
      'Desenha a lápis duas ou três folhas grandes sobrepostas, uma flor e o céu nas falhas.';

  @override
  String get ideasTropicalNoonStep2 =>
      'Colore as folhas de verde claro, a seguir as nervuras.';

  @override
  String get ideasTropicalNoonStep3 =>
      'Põe o verde médio nas folhas de trás e por baixo das outras, com bordos duros onde se sobrepõem.';

  @override
  String get ideasTropicalNoonStep4 =>
      'Colore a flor de rosa vivo, com duas camadas.';

  @override
  String get ideasTropicalNoonStep5 =>
      'Colore o céu azul nas falhas, mesmo até ao bordo das folhas.';

  @override
  String get ideasGreenhouseLightTitle => 'Na estufa';

  @override
  String get ideasGreenhouseLightSummary =>
      'Plantas atrás do vidro numa luz verde e húmida, com vidros cinzento-claros.';

  @override
  String get ideasGreenhouseLightPractice =>
      'Um véu pálido sobre uma cena, como o vidro a vela.';

  @override
  String get ideasGreenhouseLightSubject =>
      'Uma parede de vidro com as suas barras e vasos de plantas por trás.';

  @override
  String get ideasGreenhouseLightTip =>
      'O véu verde vai no fim: é a luz húmida do lugar, não a cor das plantas.';

  @override
  String get ideasGreenhouseLightStep1 =>
      'Desenha a lápis uma parede de vidro com as suas barras e vasos de plantas por trás.';

  @override
  String get ideasGreenhouseLightStep2 =>
      'Colore as plantas com o verde base, mais suave quanto mais longe estiverem do vidro.';

  @override
  String get ideasGreenhouseLightStep3 =>
      'Reserva o verde escuro só para as folhas mais próximas.';

  @override
  String get ideasGreenhouseLightStep4 =>
      'Usa o cinzento claro para as barras e para os reflexos nos vidros.';

  @override
  String get ideasGreenhouseLightStep5 =>
      'Depois de seco, passa um véu do verde pálido por toda a zona do vidro: a luz lá dentro é verde.';

  @override
  String get ideasDustyAtticTitle => 'Sótão empoeirado';

  @override
  String get ideasDustyAtticSummary =>
      'Cinzentos quentes, um baú velho e um feixe de luz com poeira dentro.';

  @override
  String get ideasDustyAtticPractice =>
      'Uma sala cinzenta com um único sítio brilhante deixado por tocar.';

  @override
  String get ideasDustyAtticSubject =>
      'Uma janela pequena e alta, o feixe de luz que deita e um baú velho lá dentro.';

  @override
  String get ideasDustyAtticTip =>
      'Deixa o feixe de luz ser a coisa mais brilhante da imagem: é o único papel branco que sobra.';

  @override
  String get ideasDustyAtticStep1 =>
      'Desenha a lápis uma janela pequena e alta, o feixe de luz que deita e um baú lá dentro.';

  @override
  String get ideasDustyAtticStep2 =>
      'Cobre tudo com o cinzento quente mais claro, exceto o interior do feixe de luz.';

  @override
  String get ideasDustyAtticStep3 =>
      'Põe o cinzento quente médio nas paredes longe da janela e nos lados do baú.';

  @override
  String get ideasDustyAtticStep4 =>
      'Usa o cinzento mais escuro nos cantos e por baixo do baú.';

  @override
  String get ideasDustyAtticStep5 =>
      'Junta um véu amarelo pálido ténue dentro do feixe de luz.';

  @override
  String get ideasDustyAtticStep6 =>
      'Quando estiver seco, junta alguns pontos de gel branco de poeira no feixe de luz.';

  @override
  String get ideasColourGreyBlackTitle => 'Cor, cinzento e preto';

  @override
  String get ideasColourGreyBlackSummary =>
      'Só três marcadores: uma cor, um cinzento e um muito escuro.';

  @override
  String get ideasColourGreyBlackPractice =>
      'Colocar a luz com o menor número de marcadores possível.';

  @override
  String get ideasColourGreyBlackSubject =>
      'Uma bicicleta, uma bota ou uma chaleira de uma só cor.';

  @override
  String get ideasColourGreyBlackTip =>
      'Com três pontas não há nada para decidir senão para onde vai a luz. Planeia a luz primeiro.';

  @override
  String get ideasColourGreyBlackStep1 =>
      'Escolhe um motivo com uma cor principal e marca a lápis de onde vem a luz.';

  @override
  String get ideasColourGreyBlackStep2 =>
      'Pinta o motivo todo com a cor e dá duas camadas onde ele se afasta da luz.';

  @override
  String get ideasColourGreyBlackStep3 =>
      'Usa o cinzento para a sombra projetada e para tudo o que não é o motivo.';

  @override
  String get ideasColourGreyBlackStep4 =>
      'Guarda o marcador escuro para as linhas de contacto e para os cantos mais fundos.';

  @override
  String get ideasColourGreyBlackStep5 =>
      'Afasta-te um pouco: o desenho lê-se com só três valores, e o cinzento mantém tudo junto.';

  @override
  String get ideasAnalogousTrioTitle => 'Três vizinhas';

  @override
  String get ideasAnalogousTrioSummary =>
      'Três cores que ficam lado a lado na roda cromática, e nada do outro lado.';

  @override
  String get ideasAnalogousTrioPractice =>
      'Montar um esquema com tons vizinhos.';

  @override
  String get ideasAnalogousTrioSubject =>
      'Um girassol, o mar ou um campo de uma só cor.';

  @override
  String get ideasAnalogousTrioTip =>
      'Cores vizinhas fundem-se húmidas sem ficar cinzentas. Deixa-as húmidas e deixa-as misturar.';

  @override
  String get ideasAnalogousTrioStep1 =>
      'Escolhe um motivo que seja naturalmente de uma cor, como um girassol ou o mar, e desenha-o.';

  @override
  String get ideasAnalogousTrioStep2 =>
      'Cobre a maior parte do motivo com a cor do meio.';

  @override
  String get ideasAnalogousTrioStep3 =>
      'Põe a vizinha do lado iluminado e funde-a na cor do meio enquanto estiver húmida.';

  @override
  String get ideasAnalogousTrioStep4 =>
      'Usa a outra vizinha nas sombras, longe da luz.';

  @override
  String get ideasAnalogousTrioStep5 =>
      'Junta o tom escuro da cor do meio só nos sítios mais fundos e deixa o resto nas três.';

  @override
  String get ideasTriadTitle => 'Uma tríade';

  @override
  String get ideasTriadSummary =>
      'Três cores igualmente espaçadas na roda: uma manda e duas apoiam.';

  @override
  String get ideasTriadPractice =>
      'Usar um esquema de três cores com uma cor a mandar.';

  @override
  String get ideasTriadSubject =>
      'Um cartaz, uma capa de livro ou uma flor grande com pequenos detalhes.';

  @override
  String get ideasTriadTip =>
      'Mantém as três cores separadas no papel. Um mesmo cinzento por cima das três une o esquema.';

  @override
  String get ideasTriadStep1 =>
      'Decide qual das três cores manda: essa leva a maior parte do papel.';

  @override
  String get ideasTriadStep2 =>
      'Pinta as zonas principais com a cor que manda.';

  @override
  String get ideasTriadStep3 =>
      'Usa a segunda cor em cerca de um quarto do desenho e nunca a deixes tocar a primeira enquanto estiver húmida.';

  @override
  String get ideasTriadStep4 =>
      'Usa a terceira cor só em alguns pontos pequenos.';

  @override
  String get ideasTriadStep5 =>
      'Sombreia as três cores com o mesmo cinzento para que pertençam umas às outras.';

  @override
  String get ideasSplitComplementTitle => 'Complementar dividida';

  @override
  String get ideasSplitComplementSummary =>
      'Uma família de cores e as duas cores de cada lado do seu oposto.';

  @override
  String get ideasSplitComplementPractice =>
      'Equilibrar uma família principal com duas cores perto do seu oposto.';

  @override
  String get ideasSplitComplementSubject =>
      'Um vaso com duas flores ou uma chávena com dois objetos pequenos ao lado.';

  @override
  String get ideasSplitComplementTip =>
      'Um quase-oposto lê-se como choque ou como harmonia conforme a quantidade que usares.';

  @override
  String get ideasSplitComplementStep1 =>
      'Desenha um motivo com uma zona grande e duas pequenas, como um vaso com duas flores.';

  @override
  String get ideasSplitComplementStep2 =>
      'Cobre a zona grande com o tom claro da família principal.';

  @override
  String get ideasSplitComplementStep3 =>
      'Junta a sua sombra onde a luz não chega.';

  @override
  String get ideasSplitComplementStep4 =>
      'Usa um dos dois opostos na primeira zona pequena.';

  @override
  String get ideasSplitComplementStep5 =>
      'Usa o outro oposto na segunda zona pequena e mantém as duas separadas.';

  @override
  String get ideasTwoGrayTemperaturesTitle => 'Cinzentos quentes e frios';

  @override
  String get ideasTwoGrayTemperaturesSummary =>
      'Pinta a mesma pedra duas vezes, uma com cinzentos quentes e outra com cinzentos frios.';

  @override
  String get ideasTwoGrayTemperaturesPractice =>
      'Distinguir a olho um cinzento quente de um cinzento frio.';

  @override
  String get ideasTwoGrayTemperaturesSubject =>
      'A mesma pedra ou um pano dobrado, desenhados duas vezes lado a lado.';

  @override
  String get ideasTwoGrayTemperaturesTip =>
      'A maioria das marcas vende os cinzentos quentes, frios e neutros como famílias à parte. Escolhe uma família para cada metade.';

  @override
  String get ideasTwoGrayTemperaturesStep1 =>
      'Desenha a mesma pedra duas vezes a lápis, lado a lado, e marca a luz em cada uma.';

  @override
  String get ideasTwoGrayTemperaturesStep2 =>
      'Primeira pedra: o cinzento quente claro por toda a parte.';

  @override
  String get ideasTwoGrayTemperaturesStep3 =>
      'Junta o cinzento quente mais escuro do lado da sombra e escurece o contacto com o chão.';

  @override
  String get ideasTwoGrayTemperaturesStep4 =>
      'Segunda pedra: o cinzento frio claro por toda a parte.';

  @override
  String get ideasTwoGrayTemperaturesStep5 =>
      'Junta da mesma maneira o cinzento frio mais escuro e compara: uma pedra parece estar ao sol e a outra à sombra.';

  @override
  String get ideasGrayPlusAccentTitle => 'Cinzento com um acento';

  @override
  String get ideasGrayPlusAccentSummary =>
      'Tudo a cinzento, menos uma coisa pequena a cor.';

  @override
  String get ideasGrayPlusAccentPractice =>
      'Fazer com que uma só cor carregue o desenho inteiro.';

  @override
  String get ideasGrayPlusAccentSubject =>
      'Uma rua com uma porta vermelha ou um chapéu-de-chuva amarelo numa cidade cinzenta.';

  @override
  String get ideasGrayPlusAccentTip =>
      'O acento quer ser o mais forte possível: duas camadas do mesmo marcador.';

  @override
  String get ideasGrayPlusAccentStep1 =>
      'Desenha uma cena com um objeto para onde queiras levar o olhar, como uma porta vermelha numa rua.';

  @override
  String get ideasGrayPlusAccentStep2 =>
      'Cobre tudo menos esse objeto com o cinzento claro.';

  @override
  String get ideasGrayPlusAccentStep3 =>
      'Põe o cinzento médio nas sombras, como se a cena fosse uma fotografia.';

  @override
  String get ideasGrayPlusAccentStep4 =>
      'Usa o cinzento mais escuro nas janelas, por baixo dos beirados e nas linhas de contacto.';

  @override
  String get ideasGrayPlusAccentStep5 =>
      'Pinta só o objeto, com duas camadas para o acento ficar o mais forte possível.';

  @override
  String get ideasEarthTonesTitle => 'Tons terrosos';

  @override
  String get ideasEarthTonesSummary =>
      'Castanhos, ocres e um verde-oliva, nada de vivo.';

  @override
  String get ideasEarthTonesPractice =>
      'Sobrepor cores de baixa saturação sem que fiquem baças.';

  @override
  String get ideasEarthTonesSubject => 'Pão, um cesto ou um campo lavrado.';

  @override
  String get ideasEarthTonesTip =>
      'As cores de baixa saturação sobrepõem-se bem, porque o papel continua a iluminá-las por baixo.';

  @override
  String get ideasEarthTonesStep1 =>
      'Desenha algo que veio da terra, como pão, um cesto ou um campo lavrado.';

  @override
  String get ideasEarthTonesStep2 =>
      'Passa o ocre claro por tudo como primeira camada.';

  @override
  String get ideasEarthTonesStep3 =>
      'Junta o castanho onde a forma se afasta da luz.';

  @override
  String get ideasEarthTonesStep4 =>
      'Põe o verde-oliva em tudo o que for verde e deixa o ocre por baixo abafá-lo.';

  @override
  String get ideasEarthTonesStep5 =>
      'Guarda o castanho mais escuro só para os sítios mais fundos.';

  @override
  String get ideasJewelTonesTitle => 'Tons de joia';

  @override
  String get ideasJewelTonesSummary =>
      'Cores profundas e saturadas com um acento dourado, como uma caixa de veludo.';

  @override
  String get ideasJewelTonesPractice =>
      'Pintar cores escuras saturadas que mantenham o brilho.';

  @override
  String get ideasJewelTonesSubject =>
      'Algumas pedras ou garrafas simples com um brilho planeado em cada uma.';

  @override
  String get ideasJewelTonesTip =>
      'A tinta escura saturada continua brilhante no papel para marcadores. Um ponto de gel branco por cima dá o aspeto de vidro.';

  @override
  String get ideasJewelTonesStep1 =>
      'Desenha algumas pedras ou garrafas simples e planeia um brilho em cada uma.';

  @override
  String get ideasJewelTonesStep2 =>
      'Cobre a forma maior com o azul-esverdeado profundo, em duas camadas.';

  @override
  String get ideasJewelTonesStep3 =>
      'Usa o violeta profundo na forma seguinte.';

  @override
  String get ideasJewelTonesStep4 => 'Usa o vermelho profundo na mais pequena.';

  @override
  String get ideasJewelTonesStep5 =>
      'Junta o amarelo-dourado às monturas ou às tampas e depois um ponto seco de gel branco em cada brilho.';

  @override
  String get ideasLowKeyTitle => 'Só marcadores escuros';

  @override
  String get ideasLowKeySummary =>
      'Desenha com marcadores mais escuros do que o cinzento médio e deixa alguns pedaços de papel levarem toda a luz.';

  @override
  String get ideasLowKeyPractice =>
      'Pintar uma imagem escura, deixando a luz de fora de propósito.';

  @override
  String get ideasLowKeySubject =>
      'Um gato com os olhos acesos, um candeeiro num quarto escuro ou um perfil.';

  @override
  String get ideasLowKeyTip =>
      'A tinta de álcool escura cobre por igual numa passagem, por isso as formas brancas que deixares ficam limpas.';

  @override
  String get ideasLowKeyStep1 =>
      'Planeia o desenho como algumas formas de papel que ficam brancas sobre um fundo escuro: os olhos de um gato, um candeeiro, um perfil.';

  @override
  String get ideasLowKeyStep2 =>
      'Cobre tudo menos as formas brancas com o marcador menos escuro.';

  @override
  String get ideasLowKeyStep3 => 'Usa o marcador médio nas sombras grandes.';

  @override
  String get ideasLowKeyStep4 =>
      'Põe o marcador mais escuro nos bordos das formas claras, para brilharem por contraste.';

  @override
  String get ideasLowKeyStep5 =>
      'Põe gel branco só num ou dois pontos, não mais.';

  @override
  String get ideasComplementGradientTitle => 'Pelo meio';

  @override
  String get ideasComplementGradientSummary =>
      'Funde duas cores opostas uma na outra e vê o cinzento que fazem onde se encontram.';

  @override
  String get ideasComplementGradientPractice =>
      'Misturar duas cores no papel e ler o resultado.';

  @override
  String get ideasComplementGradientSubject =>
      'Uma tira longa de papel onde as duas cores se encontram ao meio.';

  @override
  String get ideasComplementGradientTip =>
      'Opostos húmidos misturam-se no papel de imediato. Mantém as duas cores húmidas e deixa-as encontrar-se ao meio.';

  @override
  String get ideasComplementGradientStep1 =>
      'Fixa com fita uma tira longa de papel.';

  @override
  String get ideasComplementGradientStep2 =>
      'Preenche o terço esquerdo e deixa a cor desfazer-se para o meio.';

  @override
  String get ideasComplementGradientStep3 =>
      'Preenche o terço direito e esbate-o para o meio enquanto a primeira cor ainda estiver húmida.';

  @override
  String get ideasComplementGradientStep4 =>
      'Compara o meio lamacento com um traço do teu cinzento ao lado.';

  @override
  String get ideasComplementGradientStep5 =>
      'Repete a tira pondo primeiro o cinzento ao meio e esbatendo as duas cores nele: um caminho mais limpo.';

  @override
  String get ideasWarmLightCoolShadowTitle => 'Luz quente, sombra fria';

  @override
  String get ideasWarmLightCoolShadowSummary =>
      'Um objeto, o lado iluminado em cores quentes e o lado na sombra em cores frias.';

  @override
  String get ideasWarmLightCoolShadowPractice =>
      'Sobrepor quente e frio por cima de uma mesma cor base.';

  @override
  String get ideasWarmLightCoolShadowSubject =>
      'Uma fruta redonda, um ovo ou uma bola.';

  @override
  String get ideasWarmLightCoolShadowTip =>
      'Deixa uma faixa fina da base pura entre o quente e o frio: assim a forma continua a rodar.';

  @override
  String get ideasWarmLightCoolShadowStep1 =>
      'Desenha um objeto redondo e marca de onde vem a luz.';

  @override
  String get ideasWarmLightCoolShadowStep2 =>
      'Cobre o objeto todo com a sua própria cor.';

  @override
  String get ideasWarmLightCoolShadowStep3 =>
      'Passa a cor quente por cima da metade iluminada e funde-a na base enquanto estiver húmida.';

  @override
  String get ideasWarmLightCoolShadowStep4 =>
      'Passa a cor fria por cima da metade na sombra e deixa uma faixa fina de base pura entre as duas.';

  @override
  String get ideasWarmLightCoolShadowStep5 =>
      'Guarda o marcador mais escuro só para o contacto com o chão.';

  @override
  String get ideasVividAndMutedTitle => 'Vivo e abafado';

  @override
  String get ideasVividAndMutedSummary =>
      'Pinta a mesma flor com um par vivo e depois com um par abafado do mesmo matiz.';

  @override
  String get ideasVividAndMutedPractice =>
      'Distinguir uma cor viva da sua versão abafada.';

  @override
  String get ideasVividAndMutedSubject =>
      'A mesma flor desenhada duas vezes, lado a lado.';

  @override
  String get ideasVividAndMutedTip =>
      'A maioria das gamas tem uma versão viva e uma versão poeirenta de cada tom. Escolher entre as duas é todo o exercício.';

  @override
  String get ideasVividAndMutedStep1 =>
      'Desenha a mesma flor duas vezes a lápis, lado a lado.';

  @override
  String get ideasVividAndMutedStep2 => 'Primeira flor: o tom claro e vivo.';

  @override
  String get ideasVividAndMutedStep3 => 'Junta a sombra viva do mesmo matiz.';

  @override
  String get ideasVividAndMutedStep4 =>
      'Segunda flor: o tom claro e abafado do mesmo matiz.';

  @override
  String get ideasVividAndMutedStep5 =>
      'Junta a sua sombra abafada e decide depois qual das flores ia em primeiro plano num desenho e qual no fundo.';

  @override
  String get ideasOneMarkerBlenderTitle => 'Um marcador e o misturador';

  @override
  String get ideasOneMarkerBlenderSummary =>
      'Quatro valores com um só marcador escuro, diluindo-o com o misturador incolor.';

  @override
  String get ideasOneMarkerBlenderPractice =>
      'Diluir a tinta para obter valores mais claros sem outro marcador.';

  @override
  String get ideasOneMarkerBlenderSubject =>
      'Quatro quadrados pequenos de papel colados lado a lado.';

  @override
  String get ideasOneMarkerBlenderTip =>
      'O misturador é solvente puro: transforma um só marcador escuro na sua própria família clara.';

  @override
  String get ideasOneMarkerBlenderStep1 =>
      'Cola quatro quadrados pequenos de papel lado a lado.';

  @override
  String get ideasOneMarkerBlenderStep2 =>
      'Preenche o primeiro quadrado com o marcador à intensidade máxima.';

  @override
  String get ideasOneMarkerBlenderStep3 =>
      'Segundo quadrado: um traço de marcador e depois o misturador por cima enquanto estiver húmido.';

  @override
  String get ideasOneMarkerBlenderStep4 =>
      'Terceiro quadrado: primeiro o misturador, depois o marcador no misturador húmido. Quarto: toca a ponta do marcador na ponta do misturador e pinta só com o misturador.';

  @override
  String get ideasOneMarkerBlenderStep5 =>
      'Alinha-os: uma escada de quatro degraus com um só marcador.';

  @override
  String get ideasColourWheelTitle => 'A tua roda cromática';

  @override
  String get ideasColourWheelSummary =>
      'Dispõe doze dos teus marcadores em roda e encontra as falhas da tua coleção.';

  @override
  String get ideasColourWheelPractice =>
      'Ler uma roda cromática com os marcadores que tens.';

  @override
  String get ideasColourWheelSubject =>
      'Um círculo com cerca de dez centímetros de diâmetro, dividido em doze setores.';

  @override
  String get ideasColourWheelTip =>
      'Uma roda de marcadores é ao mesmo tempo uma lista de compras e um guia de mistura numa só página.';

  @override
  String get ideasColourWheelStep1 =>
      'Decalca um círculo à volta de uma chávena e divide-o em doze setores.';

  @override
  String get ideasColourWheelStep2 =>
      'Escolhe o marcador mais próximo do amarelo puro, depois do vermelho e depois do azul, e preenche esses setores de quatro em quatro.';

  @override
  String get ideasColourWheelStep3 =>
      'Preenche os setores entre eles com os marcadores mais próximos que tens: laranja, verde, violeta e depois os seis intermédios.';

  @override
  String get ideasColourWheelStep4 =>
      'Escreve o código de cada marcador por baixo do seu setor. Um setor vazio ou duvidoso é um marcador que talvez queiras a seguir.';

  @override
  String get ideasDeepSkinTitle => 'Tons de pele escuros';

  @override
  String get ideasDeepSkinSummary =>
      'Pinta um rosto em tons de pele profundos, com uma luz quente e um blush avermelhado.';

  @override
  String get ideasDeepSkinPractice =>
      'Sombrear pele profunda com uma gama longa de valores num só tom.';

  @override
  String get ideasDeepSkinSubject =>
      'Um rosto de três quartos, iluminado de frente.';

  @override
  String get ideasDeepSkinTip =>
      'A pele profunda precisa de uma gama longa de claridade num só tom, e é para isso que as famílias de marcadores são feitas.';

  @override
  String get ideasDeepSkinStep1 =>
      'Desenha um rosto a lápis e marca a testa, o nariz e as maçãs do rosto como os planos iluminados.';

  @override
  String get ideasDeepSkinStep2 =>
      'Cobre todo o rosto com o castanho mais claro.';

  @override
  String get ideasDeepSkinStep3 =>
      'Enquanto a primeira camada estiver húmida, junta o castanho avermelhado nas bochechas e nos lábios.';

  @override
  String get ideasDeepSkinStep4 =>
      'Junta o castanho base em todo o rosto menos nos planos iluminados.';

  @override
  String get ideasDeepSkinStep5 =>
      'Usa o marcador mais escuro debaixo das sobrancelhas, do nariz, do lábio inferior e do queixo, e deixa os planos iluminados só com a primeira camada.';

  @override
  String get ideasBlackObjectTitle => 'Preto sem preto';

  @override
  String get ideasBlackObjectSummary =>
      'Pinta um gato preto ou uma bota preta com azuis e violetas escuros e guarda o marcador preto para o fim.';

  @override
  String get ideasBlackObjectPractice =>
      'Construir um objeto escuro com cores escuras em vez de preto.';

  @override
  String get ideasBlackObjectSubject =>
      'Um gato preto, uma bota ou uma chaleira brilhante.';

  @override
  String get ideasBlackObjectTip =>
      'Um marcador preto chapado mata o volume. As cores escuras sobrepostas mantêm-no.';

  @override
  String get ideasBlackObjectStep1 =>
      'Desenha a lápis o objeto e a forma dos seus reflexos: as coisas pretas refletem o céu e a divisão.';

  @override
  String get ideasBlackObjectStep2 =>
      'Usa o cinzento-azulado frio e claro nos reflexos e nas faces de cima.';

  @override
  String get ideasBlackObjectStep3 =>
      'Cobre a maior parte do objeto com o azul escuro.';

  @override
  String get ideasBlackObjectStep4 => 'Usa o violeta escuro na parte de baixo.';

  @override
  String get ideasBlackObjectStep5 =>
      'Guarda o marcador mais escuro para as pregas mais fundas e acrescenta um brilho de gel branco se a superfície for brilhante.';

  @override
  String get ideasWhiteObjectTitle => 'Branco sem branco';

  @override
  String get ideasWhiteObjectSummary =>
      'Uma chávena ou um ovo branco com cinzentos pálidos, uma sombra com cor e muito papel por tocar.';

  @override
  String get ideasWhiteObjectPractice =>
      'Pintar um objeto branco sem pintar por cima do papel.';

  @override
  String get ideasWhiteObjectSubject =>
      'Uma chávena branca, um ovo ou um guardanapo dobrado.';

  @override
  String get ideasWhiteObjectTip =>
      'Um objeto branco é sobretudo papel. Os marcadores agradecem que o deixes em paz.';

  @override
  String get ideasWhiteObjectStep1 =>
      'Desenha a lápis o objeto e marca o lado iluminado: esse lado fica em papel.';

  @override
  String get ideasWhiteObjectStep2 =>
      'Usa o marcador com cor muito pálida só no lado na sombra.';

  @override
  String get ideasWhiteObjectStep3 =>
      'Põe o cinzento claro lá dentro, para a parte mais escura.';

  @override
  String get ideasWhiteObjectStep4 =>
      'Usa o cinzento frio um pouco mais escuro só ao longo do bordo mais longe da luz e onde o objeto toca a mesa.';

  @override
  String get ideasWhiteObjectStep5 =>
      'Acrescenta um toque da cor da mesa refletido na parte de baixo do objeto.';

  @override
  String get ideasFeatheredEdgeTitle => 'Bordo esbatido';

  @override
  String get ideasFeatheredEdgeSummary =>
      'Faz um lado de uma forma desaparecer no papel branco e mantém o outro lado nítido.';

  @override
  String get ideasFeatheredEdgePractice =>
      'Um bordo suave ao lado de um duro: a maneira mais simples de dar luz a uma forma.';

  @override
  String get ideasFeatheredEdgeSubject =>
      'Uma folha, uma pétala ou uma dobra de tecido.';

  @override
  String get ideasFeatheredEdgeTip =>
      'Levanta a ponta à medida que avanças: a tinta vai-se esgotando sozinha no traço.';

  @override
  String get ideasFeatheredEdgeStep1 =>
      'Desenha a lápis uma folha e decide que bordo está na luz.';

  @override
  String get ideasFeatheredEdgeStep2 =>
      'Pinta o bordo escuro com a cor base em traços curtos que apontam todos para o lado iluminado.';

  @override
  String get ideasFeatheredEdgeStep3 =>
      'Passa o marcador claro do centro para fora sobre as pontas desses traços, levantando a ponta para que cada traço se apague.';

  @override
  String get ideasFeatheredEdgeStep4 =>
      'Volta a passar pela união, sempre da cor para o branco.';

  @override
  String get ideasFeatheredEdgeStep5 =>
      'Compara os dois bordos: um suave, outro duro. É esse contraste que faz a forma ler-se.';

  @override
  String get ideasTipToTipTitle => 'Ponta contra ponta';

  @override
  String get ideasTipToTipSummary =>
      'Carrega uma cor escura na ponta de um marcador claro e faz um degradê numa só passagem.';

  @override
  String get ideasTipToTipPractice =>
      'Pedir tinta emprestada de um marcador a outro para um degradê rápido.';

  @override
  String get ideasTipToTipSubject =>
      'Uma tira de papel com a largura de dois dedos.';

  @override
  String get ideasTipToTipTip =>
      'Mantém o marcador escuro quieto: a ponta clara só pega tinta na ponta.';

  @override
  String get ideasTipToTipStep1 =>
      'Fixa com fita uma tira com cerca de dois dedos de largura.';

  @override
  String get ideasTipToTipStep2 =>
      'Mantém o marcador escuro quieto e encosta-lhe a ponta do marcador claro durante uns segundos.';

  @override
  String get ideasTipToTipStep3 =>
      'Começa pelo fundo da tira com a ponta carregada: os primeiros traços são escuros e depois volta a cor do marcador.';

  @override
  String get ideasTipToTipStep4 =>
      'Rabisca a ponta num papel à parte até voltar a sair limpa: o marcador claro não se estraga.';

  @override
  String get ideasTipToTipStep5 =>
      'Repete numa segunda tira, carregando a ponta durante mais tempo: a parte escura chega mais longe.';

  @override
  String get ideasBlenderPatternTitle => 'Padrões com o misturador';

  @override
  String get ideasBlenderPatternSummary =>
      'Levanta pontos e linhas de uma cor chapada com o misturador incolor.';

  @override
  String get ideasBlenderPatternPractice =>
      'Mover tinta em vez de a apagar: pontos, linhas e padrões.';

  @override
  String get ideasBlenderPatternSubject =>
      'Um quadrado de cor onde desenhar o padrão.';

  @override
  String get ideasBlenderPatternTip =>
      'Espera entre toques: duas marcas demasiado perto juntam-se.';

  @override
  String get ideasBlenderPatternStep1 =>
      'Preenche um quadrado com a cor base e deixa secar bem.';

  @override
  String get ideasBlenderPatternStep2 =>
      'Pressiona a ponta fina do misturador na cor e mantém um segundo: abre-se um ponto claro com um bordo mais escuro.';

  @override
  String get ideasBlenderPatternStep3 =>
      'Desenha uma linha com a ponta larga: a tinta empurrada acumula-se nos bordos.';

  @override
  String get ideasBlenderPatternStep4 =>
      'Faz um padrão: pontos, riscas ou uma fila de escamas.';

  @override
  String get ideasBlenderPatternStep5 =>
      'Espera entre os toques, senão os pontos juntam-se.';

  @override
  String get ideasOneMarkerLayersTitle => 'Um marcador, três camadas';

  @override
  String get ideasOneMarkerLayersSummary =>
      'Sombreia um cubo com um único marcador sobrepondo uma, duas e três passagens.';

  @override
  String get ideasOneMarkerLayersPractice =>
      'Que alcance tem um marcador quando as camadas secam umas sobre as outras.';

  @override
  String get ideasOneMarkerLayersSubject =>
      'Um cubo com a luz a vir de um canto de cima.';

  @override
  String get ideasOneMarkerLayersTip =>
      'Deixa secar cada camada: uma segunda passagem húmida move a tinta em vez de a escurecer.';

  @override
  String get ideasOneMarkerLayersStep1 =>
      'Desenha a lápis um cubo, com a luz a vir de um canto de cima.';

  @override
  String get ideasOneMarkerLayersStep2 =>
      'Uma passagem em cada face. Deixa secar.';

  @override
  String get ideasOneMarkerLayersStep3 =>
      'Uma segunda passagem nas duas faces afastadas da luz.';

  @override
  String get ideasOneMarkerLayersStep4 =>
      'Uma terceira passagem só na face mais escura e ao longo das arestas de baixo.';

  @override
  String get ideasOneMarkerLayersStep5 =>
      'Olha para os três valores: é este o alcance de um só marcador.';

  @override
  String get ideasStipplePeelTitle => 'Casca pontilhada';

  @override
  String get ideasStipplePeelSummary =>
      'Constrói a textura picada da casca de um citrino com pontos por cima de uma mistura.';

  @override
  String get ideasStipplePeelPractice =>
      'Pontilhar por cima de uma mistura seca, sem a manchar.';

  @override
  String get ideasStipplePeelSubject =>
      'Uma laranja com um brilho suave na parte de cima.';

  @override
  String get ideasStipplePeelTip => 'Usa a ponta fina: dá pintas limpas.';

  @override
  String get ideasStipplePeelStep1 =>
      'Desenha a lápis uma laranja e um brilho suave na parte de cima.';

  @override
  String get ideasStipplePeelStep2 =>
      'Preenche a laranja deixando o brilho mais claro.';

  @override
  String get ideasStipplePeelStep3 =>
      'Mistura a cor base na metade da sombra enquanto está húmida.';

  @override
  String get ideasStipplePeelStep4 =>
      'Depois de secar, toca com a ponta fina do marcador escuro em pontos soltos: mais apertados na sombra e quase nenhum junto ao brilho.';

  @override
  String get ideasStipplePeelStep5 =>
      'Toca alguns pontos claros dentro dos escuros para os quebrar.';

  @override
  String get ideasClearGlassTitle => 'Um copo transparente';

  @override
  String get ideasClearGlassSummary =>
      'Pinta um copo de beber vazio com cinzentos e quase mais nada.';

  @override
  String get ideasClearGlassPractice =>
      'Cinzento e papel branco: a maneira mais leve de desenhar vidro.';

  @override
  String get ideasClearGlassSubject =>
      'Um copo com o bordo, o pé e dois brilhos verticais.';

  @override
  String get ideasClearGlassTip =>
      'O vidro é mais escuro onde é mais grosso: no bordo e no pé.';

  @override
  String get ideasClearGlassStep1 =>
      'Desenha a lápis o copo e marca o bordo, o pé e dois brilhos verticais que ficam em papel branco.';

  @override
  String get ideasClearGlassStep2 =>
      'Pinta o copo com o cinzento mais claro, deixando os brilhos e quase todo o centro em branco.';

  @override
  String get ideasClearGlassStep3 =>
      'Escurece o bordo, o pé grosso e o bordo mais afastado: o vidro é mais escuro onde é mais grosso.';

  @override
  String get ideasClearGlassStep4 =>
      'Põe uma mancha de cor atrás do copo e deixa uma versão mais pálida dela ver-se através do vidro, por cima do cinzento claro.';

  @override
  String get ideasClearGlassStep5 =>
      'Gel branco no bordo e na base para os brilhos mais nítidos.';

  @override
  String get ideasPolishedMetalTitle => 'Metal polido';

  @override
  String get ideasPolishedMetalSummary =>
      'Faz uma colher parecer de metal com bandas de cinzento de bordo duro e uma cor refletida.';

  @override
  String get ideasPolishedMetalPractice =>
      'Bandas de bordo duro e uma escala de valores longa: é assim que o metal se lê.';

  @override
  String get ideasPolishedMetalSubject =>
      'Uma colher com as bandas do seu reflexo já desenhadas.';

  @override
  String get ideasPolishedMetalTip =>
      'O metal não tem transições suaves: mantém duros os bordos das bandas.';

  @override
  String get ideasPolishedMetalStep1 =>
      'Desenha a lápis a colher e os seus reflexos como bandas: uma escura a cruzar a taça, uma clara ao lado, sem transições suaves.';

  @override
  String get ideasPolishedMetalStep2 =>
      'Preenche a taça e o cabo com o cinzento mais claro.';

  @override
  String get ideasPolishedMetalStep3 =>
      'Põe as bandas escuras de bordo duro, a seguir a curva da taça.';

  @override
  String get ideasPolishedMetalStep4 =>
      'Põe o cinzento mais escuro mesmo ao lado da banda mais clara: o metal vive desse contraste.';

  @override
  String get ideasPolishedMetalStep5 =>
      'Deixa uma mancha da cor da mesa refletir-se na metade de baixo da taça e põe gel branco no brilho mais nítido.';

  @override
  String get ideasCastShadowTitle => 'A sombra sobre a mesa';

  @override
  String get ideasCastShadowSummary =>
      'Desenha uma chávena e acerta na sua sombra projetada: escura no contacto, suave mais longe.';

  @override
  String get ideasCastShadowPractice =>
      'Sombras projetadas: a linha de contacto, o esbatimento e o cinzento que as desenha.';

  @override
  String get ideasCastShadowSubject =>
      'Uma chávena numa mesa, com a luz a vir de um lado.';

  @override
  String get ideasCastShadowTip =>
      'A sombra começa onde o objeto toca a mesa, não onde acaba a luz.';

  @override
  String get ideasCastShadowStep1 =>
      'Desenha a lápis uma chávena e a forma da sua sombra na mesa, mais comprida do lado oposto à luz.';

  @override
  String get ideasCastShadowStep2 =>
      'Pinta a chávena e sombreia o lado afastado da luz com o mesmo marcador, numa segunda camada.';

  @override
  String get ideasCastShadowStep3 =>
      'Preenche a sombra projetada com o cinzento: começa na base da chávena e levanta a ponta à medida que te afastas.';

  @override
  String get ideasCastShadowStep4 =>
      'Acrescenta uma linha escura fina onde a chávena toca a mesa.';

  @override
  String get ideasCastShadowStep5 =>
      'Suaviza o bordo distante da sombra com um segundo toque leve de cinzento enquanto o primeiro ainda está húmido.';

  @override
  String get ideasSoftCloudsTitle => 'Nuvens suaves';

  @override
  String get ideasSoftCloudsSummary =>
      'Pinta o céu à volta das nuvens e deixa as nuvens em papel.';

  @override
  String get ideasSoftCloudsPractice =>
      'Pintar em negativo: a forma é o papel que não tocaste.';

  @override
  String get ideasSoftCloudsSubject =>
      'Duas ou três nuvens com o topo arredondado e a base mais achatada.';

  @override
  String get ideasSoftCloudsTip =>
      'Trabalha à volta das nuvens com a ponta larga: os bordos ficam um pouco irregulares.';

  @override
  String get ideasSoftCloudsStep1 =>
      'Desenha a lápis, muito ao de leve, duas ou três nuvens: topo arredondado, base mais achatada.';

  @override
  String get ideasSoftCloudsStep2 =>
      'Preenche o céu com o azul claro, trabalhando à volta das nuvens com a ponta larga para que os bordos fiquem um pouco irregulares.';

  @override
  String get ideasSoftCloudsStep3 =>
      'Escurece o céu para cima e mistura com o azul claro enquanto está húmido.';

  @override
  String get ideasSoftCloudsStep4 =>
      'Sombreia a parte de baixo de cada nuvem com o cinzento claro, deixando o topo branco.';

  @override
  String get ideasSoftCloudsStep5 =>
      'Suaviza com o misturador qualquer bordo duro do céu contra uma nuvem, empurrando a cor para fora.';

  @override
  String get ideasStillWaterTitle => 'Reflexo em água parada';

  @override
  String get ideasStillWaterSummary =>
      'Desenha uma árvore à beira do rio e a sua cópia ao contrário, um pouco mais escura, na água.';

  @override
  String get ideasStillWaterPractice =>
      'Sobrepor uma cor a outra: é assim que se faz um reflexo.';

  @override
  String get ideasStillWaterSubject =>
      'Uma árvore à margem com o seu reflexo na água abaixo.';

  @override
  String get ideasStillWaterTip =>
      'Pinta o reflexo só com traços horizontais: a água mexe-se de lado.';

  @override
  String get ideasStillWaterStep1 =>
      'Desenha a lápis uma linha de horizonte, uma árvore simples por cima e a sua imagem espelhada por baixo.';

  @override
  String get ideasStillWaterStep2 =>
      'Pinta a árvore e o seu reflexo com o mesmo marcador, o reflexo só com traços horizontais.';

  @override
  String get ideasStillWaterStep3 =>
      'Estende o azul claro por toda a área da água, reflexo incluído, com longos traços horizontais.';

  @override
  String get ideasStillWaterStep4 =>
      'Escurece a água junto à margem e no bordo distante; algumas linhas horizontais partidas de cor base sobre o reflexo.';

  @override
  String get ideasStillWaterStep5 =>
      'Põe o azul escuro onde a margem toca a água e traça duas ou três linhas finas de gel branco para as ondulações.';

  @override
  String get ideasTwistedRibbonTitle => 'Fita torcida';

  @override
  String get ideasTwistedRibbonSummary =>
      'Mistura um degradê que curva com uma fita que se torce por cima e por baixo de si.';

  @override
  String get ideasTwistedRibbonPractice =>
      'Repetir uma mistura curta em cada curva de uma forma.';

  @override
  String get ideasTwistedRibbonSubject =>
      'Uma fita com duas torções, por cima e por baixo de si.';

  @override
  String get ideasTwistedRibbonTip =>
      'Mistura ao longo da curva da fita, nunca a direito.';

  @override
  String get ideasTwistedRibbonStep1 =>
      'Desenha a lápis uma fita com duas torções e marca que troços se veem à frente e quais por trás.';

  @override
  String get ideasTwistedRibbonStep2 =>
      'Preenche cada troço com o marcador claro.';

  @override
  String get ideasTwistedRibbonStep3 =>
      'Em cada troço, põe a cor base do lado que curva para longe de ti, com traços que sigam a curva e não a direito.';

  @override
  String get ideasTwistedRibbonStep4 =>
      'Escurece só onde um troço passa por baixo de outro, numa banda estreita mesmo no cruzamento.';

  @override
  String get ideasTwistedRibbonStep5 =>
      'Passa o misturador em cada banda onde o degradê pareça escalonado.';

  @override
  String get ideasNoLineLeafTitle => 'Pintar sem contorno';

  @override
  String get ideasNoLineLeafSummary =>
      'Pinta uma folha a partir de um esboço a lápis e deixa os bordos da cor fazerem o contorno.';

  @override
  String get ideasNoLineLeafPractice =>
      'Desenhar sem fineliner: o bordo da cor é o contorno.';

  @override
  String get ideasNoLineLeafSubject =>
      'Uma folha simples com a nervura central.';

  @override
  String get ideasNoLineLeafTip =>
      'Apaga o lápis com uma borracha macia até quase não se ver.';

  @override
  String get ideasNoLineLeafStep1 =>
      'Desenha a folha e a nervura central muito ao de leve a lápis e apaga quase todo o grafite com uma borracha macia até quase não o veres.';

  @override
  String get ideasNoLineLeafStep2 =>
      'Preenche a folha e para exatamente na linha a lápis.';

  @override
  String get ideasNoLineLeafStep3 =>
      'Sombreia metade da folha e a base enquanto a primeira camada ainda está húmida.';

  @override
  String get ideasNoLineLeafStep4 =>
      'Define o bordo do lado da sombra com uma linha fina do marcador mais escuro, em vez de um fineliner.';

  @override
  String get ideasNoLineLeafStep5 =>
      'Apaga o lápis que ainda se veja quando a tinta estiver seca.';

  @override
  String get ideasShortFurTitle => 'Pelo curto';

  @override
  String get ideasShortFurSummary =>
      'Pinta a orelha de um gato com traços curtos em duas direções.';

  @override
  String get ideasShortFurPractice =>
      'Traços curtos que seguem a direção do pelo.';

  @override
  String get ideasShortFurSubject =>
      'Uma orelha de gato com umas setas a mostrarem para onde cresce o pelo.';

  @override
  String get ideasShortFurTip =>
      'Faz traços rápidos da raiz para fora: apoia, move depressa e levanta.';

  @override
  String get ideasShortFurStep1 =>
      'Desenha a lápis a orelha e a direção do pelo com umas setas.';

  @override
  String get ideasShortFurStep2 =>
      'Preenche a orelha com o marcador claro, fazendo traços rápidos para fora no bordo para que fique peludo e não sólido.';

  @override
  String get ideasShortFurStep3 =>
      'Traços rápidos curtos de cor base do bordo interior para fora, a seguir as setas.';

  @override
  String get ideasShortFurStep4 =>
      'Menos traços rápidos, e mais escuros, dentro da orelha e na base onde ela se junta à cabeça.';

  @override
  String get ideasShortFurStep5 =>
      'Volta a passar o marcador claro pelas uniões para misturar as camadas e suavizar os traços mais escuros.';

  @override
  String get ideasWoodGrainTitle => 'Tábua de madeira';

  @override
  String get ideasWoodGrainSummary =>
      'Uma tábua com veios e um nó, em três castanhos.';

  @override
  String get ideasWoodGrainPractice =>
      'Traços longos que seguem a forma do material.';

  @override
  String get ideasWoodGrainSubject =>
      'Uma tábua de madeira com um nó perto de uma das pontas.';

  @override
  String get ideasWoodGrainTip =>
      'Os veios contornam o nó: desenha as linhas curvas, nunca direitas.';

  @override
  String get ideasWoodGrainStep1 =>
      'Desenha a lápis uma tábua com um nó; os veios contornam o nó como a água contorna uma pedra.';

  @override
  String get ideasWoodGrainStep2 =>
      'Preenche a tábua com traços longos ao longo dos veios.';

  @override
  String get ideasWoodGrainStep3 =>
      'Linhas longas e ligeiramente onduladas de cor base ao longo dos veios, que se juntam perto do nó.';

  @override
  String get ideasWoodGrainStep4 =>
      'Algumas linhas mais escuras e os anéis do nó; escurece o bordo de baixo da tábua.';

  @override
  String get ideasWoodGrainStep5 =>
      'Volta a passar o marcador claro pelas linhas para suavizar as zonas onde parecem desenhadas por cima.';

  @override
  String get ideasBrickWallTitle => 'Parede de tijolos';

  @override
  String get ideasBrickWallSummary =>
      'Um troço de parede de tijolos de cores ligeiramente diferentes e argamassa clara.';

  @override
  String get ideasBrickWallPractice =>
      'Preenchimentos planos, tijolo a tijolo, e o cinzento da argamassa.';

  @override
  String get ideasBrickWallSubject =>
      'Um troço de parede com uns vinte tijolos.';

  @override
  String get ideasBrickWallTip =>
      'Deixa a argamassa como papel: é mais clara do que qualquer tijolo.';

  @override
  String get ideasBrickWallStep1 =>
      'Desenha a lápis a grelha da argamassa e deixa-a por agora como papel.';

  @override
  String get ideasBrickWallStep2 =>
      'Preenche cada tijolo com o marcador claro, deixando cada tijolo secar como uma forma à parte.';

  @override
  String get ideasBrickWallStep3 =>
      'Passa a cor base por cerca de metade dos tijolos, escolhidos ao acaso, para que a parede não fique uniforme.';

  @override
  String get ideasBrickWallStep4 =>
      'Sombreia o bordo de baixo de cada tijolo, mais umas lascas e alguns tijolos mais escuros.';

  @override
  String get ideasBrickWallStep5 =>
      'Preenche as juntas de argamassa com o cinzento claro.';

  @override
  String get ideasFoldedClothTitle => 'Tecido dobrado';

  @override
  String get ideasFoldedClothSummary =>
      'Sombreia as dobras de um pano pendurado com quatro valores e uma só direção de luz.';

  @override
  String get ideasFoldedClothPractice =>
      'O mesmo degradê repetido em cada dobra.';

  @override
  String get ideasFoldedClothSubject =>
      'Um pano pendurado num cordão, com três ou quatro dobras.';

  @override
  String get ideasFoldedClothTip =>
      'A linha mais escura só vai para onde o tecido se vira sobre si próprio.';

  @override
  String get ideasFoldedClothStep1 =>
      'Desenha a lápis um pano pendurado num cordão, com três ou quatro dobras, e marca o topo de cada dobra.';

  @override
  String get ideasFoldedClothStep2 => 'Preenche o pano.';

  @override
  String get ideasFoldedClothStep3 =>
      'Cor base do lado de cada dobra afastado da luz, misturada no claro enquanto estiver húmida.';

  @override
  String get ideasFoldedClothStep4 =>
      'Sombra no fundo de cada dobra, onde o pano se vira.';

  @override
  String get ideasFoldedClothStep5 =>
      'Uma linha escura fina só mesmo no fundo das dobras mais fundas; passa o misturador em cada salto duro das partes redondas.';

  @override
  String get ideasWaterDropsTitle => 'Gotas numa folha';

  @override
  String get ideasWaterDropsSummary =>
      'Três gotas de água numa folha, cada uma com sombra, bordo escuro e brilho.';

  @override
  String get ideasWaterDropsPractice =>
      'Algumas marcas nítidas por cima de uma mistura já acabada.';

  @override
  String get ideasWaterDropsSubject => 'Uma folha com três gotas de água.';

  @override
  String get ideasWaterDropsTip =>
      'A gota inverte a luz: sombreia o lado que olha para ela.';

  @override
  String get ideasWaterDropsStep1 =>
      'Desenha a lápis uma folha e três gotas; marca em cada gota um pequeno brilho do lado iluminado.';

  @override
  String get ideasWaterDropsStep2 =>
      'Pinta toda a folha, gotas incluídas; as gotas são a folha vista através da água.';

  @override
  String get ideasWaterDropsStep3 =>
      'Sombreia a folha e, dentro de cada gota, o lado virado para a luz, porque a gota age como uma lupa e inverte-a.';

  @override
  String get ideasWaterDropsStep4 =>
      'Uma meia-lua escura fina do lado oposto de cada gota e uma pequena sombra projetada por baixo.';

  @override
  String get ideasWaterDropsStep5 =>
      'Gel branco: um ponto duro por gota do lado iluminado e um fio mais claro e ténue no lado oposto.';

  @override
  String get ideasStrawberrySeedsTitle => 'Morango';

  @override
  String get ideasStrawberrySeedsSummary =>
      'Um morango cujas sementes ficam em pequenas cavidades, com uma coroa verde.';

  @override
  String get ideasStrawberrySeedsPractice =>
      'Textura feita de pequenas marcas: cavidades, sementes e coroa.';

  @override
  String get ideasStrawberrySeedsSubject =>
      'Um morango com uma grelha solta de sementes.';

  @override
  String get ideasStrawberrySeedsTip =>
      'Marca as cavidades enquanto a cor ainda está húmida: o anel mais escuro forma-se sozinho.';

  @override
  String get ideasStrawberrySeedsStep1 =>
      'Desenha a lápis o morango e uma grelha solta de pontos de semente, mais juntos perto da ponta.';

  @override
  String get ideasStrawberrySeedsStep2 =>
      'Preenche o fruto deixando um brilho suave.';

  @override
  String get ideasStrawberrySeedsStep3 =>
      'Mistura a cor base à volta; enquanto estiver húmido, pressiona um ponto um pouco mais escuro por cima de cada semente.';

  @override
  String get ideasStrawberrySeedsStep4 =>
      'Escurece a metade de baixo e a cavidade por cima de cada semente.';

  @override
  String get ideasStrawberrySeedsStep5 =>
      'Pinta as folhas e o pedúnculo com o verde e põe um pontinho de gel claro em cada cavidade para a semente.';

  @override
  String get ideasPaletteMixingTitle => 'Misturar numa paleta';

  @override
  String get ideasPaletteMixingSummary =>
      'Cria uma terceira cor misturando dois marcadores numa superfície de plástico e apanha-a com o misturador.';

  @override
  String get ideasPaletteMixingPractice =>
      'Misturar duas tintas fora do papel, com o misturador a servir de pincel.';

  @override
  String get ideasPaletteMixingSubject =>
      'Uma tampa de plástico ou um cartão de mistura, mais um papel à parte.';

  @override
  String get ideasPaletteMixingTip =>
      'O misturador só transporta o que está húmido: não deixes secar as poças.';

  @override
  String get ideasPaletteMixingStep1 =>
      'Rabisca o primeiro marcador numa superfície que não absorve, como um cartão de mistura, uma tampa de plástico ou um saco de plástico.';

  @override
  String get ideasPaletteMixingStep2 =>
      'Rabisca o segundo marcador ao lado, para que as duas poças se toquem.';

  @override
  String get ideasPaletteMixingStep3 =>
      'Apanha a mistura com a ponta larga do misturador incolor e pinta uma amostra; ao lado, pinta uma amostra de cada marcador sozinho.';

  @override
  String get ideasPaletteMixingStep4 =>
      'Experimenta uma segunda mistura com mais de uma das cores.';

  @override
  String get ideasPaletteMixingStep5 =>
      'Anota que misturas gostarias de ter como marcador.';

  @override
  String get ideasLongHairTitle => 'Cabelo longo';

  @override
  String get ideasLongHairSummary =>
      'Uma cascata de cabelo com uma faixa de luz e mechas que seguem a cabeça.';

  @override
  String get ideasLongHairPractice =>
      'Traços longos que se afinam e uma faixa de luz que é só papel.';

  @override
  String get ideasLongHairSubject =>
      'Uma cascata de cabelo com poucas mechas grandes e uma faixa de luz.';

  @override
  String get ideasLongHairTip =>
      'Apoia menos dentro da faixa de luz: o papel faz o trabalho.';

  @override
  String get ideasLongHairStep1 =>
      'Desenha a lápis o cabelo em poucas mechas grandes, não em fios soltos, e uma faixa curva onde a luz bate.';

  @override
  String get ideasLongHairStep2 =>
      'Preenche todo o cabelo, apoiando menos dentro da faixa de luz.';

  @override
  String get ideasLongHairStep3 =>
      'Traços longos da risca para baixo, cada um levantando a ponta ao chegar à faixa de luz, e depois das pontas para cima.';

  @override
  String get ideasLongHairStep4 =>
      'Escurece entre as mechas e por baixo da orelha e do pescoço.';

  @override
  String get ideasLongHairStep5 =>
      'Algumas mechas finas do marcador mais escuro e depois dois ou três fios finos de gel branco só dentro da faixa de luz.';

  @override
  String get ideasOverlapGlazesTitle => 'Camadas sobrepostas';

  @override
  String get ideasOverlapGlazesSummary =>
      'Sobrepõe três círculos transparentes e vê que cores novas aparecem.';

  @override
  String get ideasOverlapGlazesPractice =>
      'Camadas transparentes: cada sobreposição é uma mistura a sério.';

  @override
  String get ideasOverlapGlazesSubject =>
      'Três círculos sobrepostos, como um diagrama de Venn.';

  @override
  String get ideasOverlapGlazesTip =>
      'A ordem conta: a cor mais clara por cima fica sempre diferente.';

  @override
  String get ideasOverlapGlazesStep1 =>
      'Desenha a lápis três círculos que se sobrepõem como um diagrama de Venn.';

  @override
  String get ideasOverlapGlazesStep2 =>
      'Preenche o primeiro círculo e deixa secar bem.';

  @override
  String get ideasOverlapGlazesStep3 =>
      'Preenche o segundo, sobreposição incluída; a sobreposição torna-se uma terceira cor.';

  @override
  String get ideasOverlapGlazesStep4 =>
      'Preenche o terceiro círculo; o meio, onde os três se encontram, é a mistura mais escura.';

  @override
  String get ideasOverlapGlazesStep5 =>
      'Repete com os marcadores noutra ordem: a cor mais clara por cima fica sempre diferente.';

  @override
  String get ideasFadedBackgroundTitle => 'Fundo esbatido';

  @override
  String get ideasFadedBackgroundSummary =>
      'Dá a um desenho um halo de cor que se esvai no branco muito antes do bordo do papel.';

  @override
  String get ideasFadedBackgroundPractice =>
      'Uma vinheta feita de traços circulares e do misturador.';

  @override
  String get ideasFadedBackgroundSubject =>
      'Uma chávena, um pássaro ou outro motivo pequeno no meio da página.';

  @override
  String get ideasFadedBackgroundTip =>
      'Para antes de chegar ao bordo do papel: o halo esvai-se sozinho.';

  @override
  String get ideasFadedBackgroundStep1 =>
      'Desenha a lápis um motivo simples, como uma chávena ou um pássaro, no meio da página.';

  @override
  String get ideasFadedBackgroundStep2 =>
      'Pinta um anel de cor base à volta do motivo, com cerca de um dedo de largura, em traços circulares.';

  @override
  String get ideasFadedBackgroundStep3 =>
      'Leva o marcador claro do anel para fora em círculos sobrepostos até ficar pálido.';

  @override
  String get ideasFadedBackgroundStep4 =>
      'Segue com o misturador para além da cor, empurrando o que resta para o papel para não ficar nenhum bordo.';

  @override
  String get ideasFadedBackgroundStep5 =>
      'Acaba o motivo para que fique mais escuro do que o halo.';

  @override
  String get ideasHatchShadingTitle => 'Sombreado a hachuras';

  @override
  String get ideasHatchShadingSummary =>
      'Sombreia uma maçã só com linhas, sem misturar: hachuras para o tom médio e hachuras cruzadas para a sombra.';

  @override
  String get ideasHatchShadingPractice =>
      'Hachuras e hachuras cruzadas: linhas que se leem como um tom.';

  @override
  String get ideasHatchShadingSubject => 'Uma maçã com o brilho marcado.';

  @override
  String get ideasHatchShadingTip =>
      'Mantém as linhas paralelas e bem espaçadas: o olho faz o resto.';

  @override
  String get ideasHatchShadingStep1 =>
      'Desenha a lápis uma maçã e marca o brilho.';

  @override
  String get ideasHatchShadingStep2 =>
      'Preenche a maçã de forma chapada e deixa secar.';

  @override
  String get ideasHatchShadingStep3 =>
      'Hachura a metade da sombra com linhas paralelas da ponta fina, mais apertadas quanto mais longe da luz.';

  @override
  String get ideasHatchShadingStep4 =>
      'Cruza a zona mais escura com um segundo conjunto de linhas noutro ângulo e acrescenta a sombra de contacto por baixo da maçã.';

  @override
  String get ideasHatchShadingStep5 =>
      'Afasta-te um pouco: à distância as linhas tornam-se um tom.';

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
  String get ideasSeasonSpring => 'Primavera';

  @override
  String get ideasSeasonSummer => 'Verão';

  @override
  String get ideasSeasonAutumn => 'Outono';

  @override
  String get ideasSeasonWinter => 'Inverno';

  @override
  String get ideasSectionAnyTime => 'Qualquer época';

  @override
  String ideasSeeAllSemantic(int count, String category) {
    return 'Ver as $count ideias em $category';
  }

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
  String get matchEmptyPhotoTitle => 'Encontra uma cor a partir de uma foto';

  @override
  String get matchEmptyPhotoMessage =>
      'Tira uma foto, toca numa cor e vê os marcadores mais próximos.';

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
  String get matchTakePhotoButton => 'Tirar uma foto';

  @override
  String get matchChooseGalleryButton => 'Escolher da galeria';

  @override
  String get matchValuesButton => 'Valores';

  @override
  String get matchValuesTooltip =>
      'Mostra a foto e as correspondências em tons de cinzento para verificar o contraste de valores';

  @override
  String get matchPhotoSampleHint =>
      'Toca duas vezes para tirar a cor do centro da foto. Usa as ações para mover o ponto.';

  @override
  String get matchSampleMiddle => 'Tirar a cor do centro da foto';

  @override
  String get matchMoveLeft => 'Mover o ponto para a esquerda';

  @override
  String get matchMoveRight => 'Mover o ponto para a direita';

  @override
  String get matchMoveUp => 'Mover o ponto para cima';

  @override
  String get matchMoveDown => 'Mover o ponto para baixo';

  @override
  String matchSampleSpoken(
    String hex,
    String code,
    String name,
    String quality,
  ) {
    return 'Cor tirada $hex. Marcador mais próximo: $code, $name, $quality.';
  }

  @override
  String matchSampleSpokenNone(String hex) {
    return 'Cor tirada $hex.';
  }

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
  String get settingsAiOnDeviceNotEnabledIos =>
      'Para usar a IA no dispositivo, ativa o Apple Intelligence em Definições → Apple Intelligence e Siri.';

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
      'touchTwin':
          '$input não é um código de marcador da Touch Twin. Experimenta $example.',
      'promarker':
          '$input não é um código de marcador da Promarker. Experimenta $example.',
      'prismacolor':
          '$input não é um código de marcador da Prismacolor Premier. Experimenta $example.',
      'spectrumNoir':
          '$input não é um código de marcador da Spectrum Noir. Experimenta $example.',
      'promarkerBrush':
          '$input não é um código de marcador da Promarker Brush. Experimenta $example.',
      'arrtx':
          '$input não é um código de marcador da Arrtx. Experimenta $example.',
      'kurecolor':
          '$input não é um código de marcador da ZIG Kurecolor. Experimenta $example.',
      'graphit':
          '$input não é um código de marcador da Graph\'it. Experimenta $example.',
      'marvyLePlume':
          '$input não é um código de marcador da Marvy Le Plume. Experimenta $example.',
      'blickBrush':
          '$input não é um código de marcador da Blick Studio Brush. Experimenta $example.',
      'artistsLoft':
          '$input não é um código de marcador da Artist\'s Loft. Experimenta $example.',
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
      'touchTwin': 'Ainda não há marcadores Touch Twin na tua coleção. Junta-os em A minha coleção.',
      'promarker': 'Ainda não há marcadores Promarker na tua coleção. Junta-os em A minha coleção.',
      'prismacolor': 'Ainda não há marcadores Prismacolor Premier na tua coleção. Junta-os em A minha coleção.',
      'spectrumNoir': 'Ainda não há marcadores Spectrum Noir na tua coleção. Junta-os em A minha coleção.',
      'promarkerBrush': 'Ainda não há marcadores Promarker Brush na tua coleção. Junta-os em A minha coleção.',
      'arrtx': 'Ainda não há marcadores Arrtx na tua coleção. Junta-os em A minha coleção.',
      'kurecolor': 'Ainda não há marcadores ZIG Kurecolor na tua coleção. Junta-os em A minha coleção.',
      'graphit': 'Ainda não há marcadores Graph\'it na tua coleção. Junta-os em A minha coleção.',
      'marvyLePlume': 'Ainda não há marcadores Marvy Le Plume na tua coleção. Junta-os em A minha coleção.',
      'blickBrush': 'Ainda não há marcadores Blick Studio Brush na tua coleção. Junta-os em A minha coleção.',
      'artistsLoft': 'Ainda não há marcadores Artist\'s Loft na tua coleção. Junta-os em A minha coleção.',
      'other': 'Ainda não há marcadores na tua coleção. Junta-os em A minha coleção.',
    });
    return '$_temp0';
  }

  @override
  String paletteMissingBase(String example) {
    return 'Escolhe um marcador base, como $example, ou escolhe Cenas como tipo de paleta.';
  }

  @override
  String paletteBaseDried(String code) {
    return '$code está seco. Marca-o como utilizável em Detalhes ou escolhe outro.';
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
  String get errInvalidBaseColor =>
      'O marcador de base não está na tua coleção.';

  @override
  String get errBaseDried =>
      'O marcador de base está seco. Marca-o como utilizável ou escolhe outro.';

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
  String get settingsLinesTitle => 'Séries que tens';

  @override
  String get settingsLinesHint =>
      'Escolhe todas as séries da Ohuhu que tenhas. Se desativares uma série, os seus packs saem da tua seleção.';

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
  String get swatchesLines => 'Séries';

  @override
  String get swatchesLabelLine => 'Série';

  @override
  String get swatchesAllLines => 'Todas as séries';

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
  String get collectionIndividualMarkersShort => 'Assinala os que tens';

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
  String get collectionImportCodesTitle => 'Importar códigos';

  @override
  String get collectionImportCodesHint => 'Cola uma lista de códigos';

  @override
  String get collectionDecoRange => 'Gama DecoTime';

  @override
  String get collectionWholeRange => 'Toda a gama';

  @override
  String get collectionSearchHint => 'Procurar código ou nome';

  @override
  String get collectionTickVisible => 'Marcar tudo';

  @override
  String collectionTickManyTitle(int count) {
    return 'Marcar $count marcadores?';
  }

  @override
  String get collectionTickManyBody =>
      'Todos contam como marcadores que tens. Podes tirá-los outra vez com «Tirar tudo».';

  @override
  String get collectionUntickVisible => 'Tirar tudo';

  @override
  String collectionRemoveMarkersTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Remover $count marcadores?',
      one: 'Remover 1 marcador?',
    );
    return '$_temp0';
  }

  @override
  String collectionRemoveFromTitle(int count, String name) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$name: remover $count marcadores?',
      one: '$name: remover 1 marcador?',
    );
    return '$_temp0';
  }

  @override
  String get collectionRemoveMarkersBody =>
      'Os marcadores que já tens saem da tua coleção. Podes voltar a juntá-los quando quiseres.';

  @override
  String get collectionRemoveConfirm => 'Remover';

  @override
  String get collectionReplaceTitle => 'Substituir a tua coleção?';

  @override
  String get collectionReplaceBody =>
      'Quando a configuração acaba, os conjuntos e marcadores que tens agora são substituídos pelos que escolheres aqui.';

  @override
  String get collectionReplaceConfirm => 'Substituir';

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
  String get toolsMapTitle => 'Mapa de cores';

  @override
  String get toolsMapHint =>
      'Onde ficam os teus marcadores por tom e luminosidade, e onde há lacunas.';

  @override
  String get toolsTranslateTitle => 'Traduzir uma receita';

  @override
  String get toolsTranslateHint =>
      'Converte os códigos de um tutorial nos teus marcadores mais parecidos.';

  @override
  String get toolsBlendsTitle => 'As minhas receitas';

  @override
  String get toolsBlendsHint =>
      'Misturas que guardas: marcadores por ordem, uma nota e uma foto.';

  @override
  String get toolsTransferTitle => 'Exportar e importar';

  @override
  String get toolsTransferHint =>
      'Partilha os teus marcadores como lista ou CSV, ou adiciona muitos por código.';

  @override
  String get toolsMapIntro =>
      'Cada ponto é um marcador que tens. As zonas tracejadas não têm nenhum.';

  @override
  String get toolsMapShowRange => 'Mostrar toda a gama';

  @override
  String get toolsMapShowRangeHint =>
      'Pontos ténues com todos os marcadores das tuas marcas, para ver o que falta.';

  @override
  String get toolsMapAxes =>
      'Da esquerda para a direita: tom. De cima para baixo: de claro a escuro.';

  @override
  String get toolsMapGreysTitle => 'Cinzentos e neutros';

  @override
  String get toolsMapGreysAxis =>
      'Da esquerda para a direita: de escuro a claro.';

  @override
  String get toolsMapFamiliesTitle => 'Por tom';

  @override
  String get toolsHueRed => 'Vermelho';

  @override
  String get toolsHueOrange => 'Laranja';

  @override
  String get toolsHueYellow => 'Amarelo';

  @override
  String get toolsHueGreen => 'Verde';

  @override
  String get toolsHueTeal => 'Turquesa';

  @override
  String get toolsHueBlue => 'Azul';

  @override
  String get toolsHueViolet => 'Violeta';

  @override
  String get toolsHueMagenta => 'Magenta';

  @override
  String toolsFamilyBands(int light, int mid, int dark) {
    return 'Claros $light · Médios $mid · Escuros $dark';
  }

  @override
  String get toolsMapDriedNote => 'Os marcadores secos ficam de fora.';

  @override
  String toolsMapSummary(String markers, int empty, int cells) {
    return 'Mapa de cores de $markers. $empty de $cells zonas não têm nenhum marcador. A lista abaixo mostra os mesmos marcadores por tom.';
  }

  @override
  String get toolsMarkerOwned => 'Na tua coleção';

  @override
  String get toolsMarkerNotOwned => 'Não está na tua coleção';

  @override
  String get toolsTranslateIntro =>
      'Escreve ou cola os códigos de um tutorial, na marca que ele usa. Vírgulas, espaços e listas funcionam.';

  @override
  String get toolsTranslateBrand => 'Marca da receita';

  @override
  String get toolsTranslateCodes => 'Códigos';

  @override
  String get toolsTranslateResults => 'Tradução';

  @override
  String get toolsTranslateEmpty => 'Os códigos que escreveres aparecem aqui.';

  @override
  String get toolsTranslateMine => 'O mais parecido que tens';

  @override
  String get toolsTranslateNotOwned => 'Não tens';

  @override
  String get toolsTranslateMissing => 'Nada parecido na tua coleção.';

  @override
  String toolsTranslateUnknown(String brand) {
    return 'Não existe em $brand';
  }

  @override
  String get toolsCopyList => 'Copiar lista';

  @override
  String get toolsShareList => 'Partilhar lista';

  @override
  String get toolsListCopied => 'Lista copiada.';

  @override
  String get toolsShareFailed => 'Não foi possível partilhar a lista.';

  @override
  String get toolsBlendsNew => 'Nova receita';

  @override
  String get toolsBlendsEditTitle => 'Editar receita';

  @override
  String get toolsBlendsEmptyTitle => 'Ainda não há receitas';

  @override
  String get toolsBlendsEmptyBody =>
      'Guarda as misturas de que gostas: marcadores por ordem, uma nota e uma foto.';

  @override
  String get toolsBlendsName => 'Nome da receita';

  @override
  String get toolsBlendsMarkersTitle => 'Marcadores, por ordem';

  @override
  String get toolsBlendsMarkersHelp => 'Arrasta a pega para mudar a ordem.';

  @override
  String get toolsBlendsDrag => 'Arrastar para reordenar';

  @override
  String toolsBlendsRemoveMarker(String code) {
    return 'Remover $code';
  }

  @override
  String get toolsBlendsNote => 'Nota';

  @override
  String get toolsBlendsPhotoTitle => 'Foto do resultado';

  @override
  String get toolsBlendsPhotoHelp => 'Opcional. Fica neste telemóvel.';

  @override
  String get toolsBlendsPhotoSemantic => 'Foto da receita';

  @override
  String get toolsBlendsSave => 'Guardar receita';

  @override
  String get toolsBlendsDelete => 'Apagar receita';

  @override
  String get toolsBlendsDeleteTitle => 'Apagar esta receita?';

  @override
  String get toolsBlendsDeleteBody =>
      'A receita e a sua foto serão removidas deste telemóvel.';

  @override
  String get toolsTransferExport => 'Exportar';

  @override
  String toolsTransferBrands(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count marcas',
      one: '1 marca',
    );
    return '$_temp0';
  }

  @override
  String toolsTransferExportBrands(String brands) {
    return 'Inclui todas as marcas que tens: $brands.';
  }

  @override
  String get toolsTransferCsv => 'Partilhar como CSV';

  @override
  String get toolsTransferImport => 'Importar por código';

  @override
  String get toolsTransferImportHelp =>
      'Escolhe a marca e cola os respetivos códigos. Nada é adicionado até carregares no botão.';

  @override
  String get toolsTransferNew => 'Marcadores novos';

  @override
  String get toolsTransferAlready => 'Já são teus';

  @override
  String get toolsTransferUnknown => 'Não reconhecidos';

  @override
  String toolsTransferAdd(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Adicionar $count marcadores',
      one: 'Adicionar 1 marcador',
      zero: 'Adicionar marcadores',
    );
    return '$_temp0';
  }

  @override
  String toolsTransferAdded(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count marcadores adicionados.',
      one: '1 marcador adicionado.',
    );
    return '$_temp0';
  }

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
  String get paletteEaselTitle => 'Modo cavalete';

  @override
  String get paletteEaselExit => 'Sair do modo cavalete';

  @override
  String get paletteShareTextButton => 'Partilhar como texto';

  @override
  String paletteTextHeader(String brand, String title) {
    return 'Paleta do Ink Lab · $brand · $title';
  }

  @override
  String get paletteImportTitle => 'Importar de texto';

  @override
  String get paletteImportHint =>
      'Cola uma paleta partilhada ou uma lista de códigos de marcadores.';

  @override
  String get paletteImportPaste => 'Colar';

  @override
  String get paletteImportAction => 'Carregar paleta';

  @override
  String get paletteImportNothing =>
      'Não foi encontrado nenhum código de marcador neste texto.';

  @override
  String paletteImportNoneKnown(String brand, String codes) {
    return 'Nenhum destes códigos é um marcador $brand: $codes.';
  }

  @override
  String paletteImportNoneKnownMixed(String codes) {
    return 'Nenhum destes códigos pertence às tuas marcas: $codes.';
  }

  @override
  String paletteImportOtherBrand(String brand) {
    return 'Esta paleta é da $brand. Muda a marca nas Definições para a importar.';
  }

  @override
  String paletteImportDone(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Paleta importada com $count marcadores.',
      one: 'Paleta importada com 1 marcador.',
    );
    return '$_temp0';
  }

  @override
  String paletteImportUnknown(String codes) {
    return 'Não reconhecidos: $codes.';
  }

  @override
  String get paletteImportRepeated =>
      'Os códigos repetidos foram contados uma só vez.';

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
  String collectionLooseTicked(int loose, int sets) {
    return '$loose avulsos marcados · $sets nos teus conjuntos';
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
  String get onboardingStepFirst => 'Passo 1';

  @override
  String onboardingMarkersTicked(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count assinalados',
      one: '1 assinalado',
    );
    return '$_temp0';
  }

  @override
  String onboardingMarkersNoneTicked(String range) {
    return 'Nenhum assinalado · $range';
  }

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
      'Ainda não escolheste conjuntos: Comparar e Amostras mostram toda a gama; Paleta e Ideias precisam dos marcadores que tens';

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
  String get wishlistSubtitle => 'Adiciona a partir do detalhe de uma cor';

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
    return 'Até escolheres conjuntos, Comparar e Amostras mostram toda a gama $brand. Paleta e Ideias precisam dos marcadores que tens.';
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
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count terminadas',
      one: '1 terminada',
    );
    return '$_temp0';
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
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'A mostrar os últimos $count meses.',
      one: 'A mostrar o último mês.',
    );
    return '$_temp0';
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

  @override
  String get settingsLicences => 'Licenças de código aberto';

  @override
  String get settingsLicencesSubtitle =>
      'As licenças do código, dos tipos de letra e dos pacotes que a app usa';

  @override
  String get settingsLicencesLegalese =>
      'Código do Ink Lab: licença MIT. Textos, ideias e documentação: CC BY-SA 4.0. Tipos de letra incluídos: licença SIL Open Font 1.1.';

  @override
  String get settingsSendFeedback => 'Enviar comentários';

  @override
  String get settingsSendFeedbackSubtitle =>
      'Abre a tua app de e-mail com a versão da app e do sistema. Tu decides se a envias.';

  @override
  String get settingsRateApp => 'Avaliar o Ink Lab';

  @override
  String get settingsRateAppSubtitle =>
      'Uma avaliação ajuda outras pessoas a encontrar a app';

  @override
  String settingsFeedbackNoMail(String address) {
    return 'Não foi encontrada nenhuma app de e-mail. O endereço $address foi copiado.';
  }

  @override
  String get settingsErrorLogShare => 'Partilhar registo de erros';

  @override
  String get settingsErrorLogShareSubtitle =>
      'Detalhes técnicos dos erros da app, sem o teu diário nem a tua chave da API. Nada é enviado se não o partilhares.';

  @override
  String get settingsErrorLogClear => 'Limpar registo de erros';

  @override
  String get settingsErrorLogCleared => 'O registo de erros foi limpo';

  @override
  String get settingsErrorLogShareFailed =>
      'Não foi possível partilhar o registo de erros';

  @override
  String settingsLastBackup(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.yMMMd(localeName);
    final String dateString = dateDateFormat.format(date);

    return 'Última cópia: $dateString';
  }

  @override
  String get settingsNoBackupYet => 'Ainda sem cópia de segurança';

  @override
  String get settingsBackupReminderNever =>
      'Tens dados na app e ainda não fizeste nenhuma cópia. Guarda um ficheiro de cópia para não os perderes se mudares ou repuseres o telemóvel.';

  @override
  String get settingsBackupReminderOld =>
      'A tua última cópia tem mais de um mês. Guarda um ficheiro novo para manter o teu trabalho mais recente em segurança.';

  @override
  String get collectionTouchTwinHint =>
      'Assinala os marcadores Touch Twin que tens.';

  @override
  String get onboardingTouchTwinLine =>
      '202 cores · Assinala os marcadores que tens';

  @override
  String get collectionPromarkerHint =>
      'Assinala os marcadores Promarker que tens.';

  @override
  String get onboardingPromarkerLine =>
      '148 cores · Assinala os marcadores que tens';

  @override
  String get collectionPrismacolorHint =>
      'Assinala os marcadores Prismacolor Premier que tens.';

  @override
  String get onboardingPrismacolorLine =>
      '200 cores · Assinala os marcadores que tens';

  @override
  String get collectionSpectrumNoirHint =>
      'Assinala os marcadores Spectrum Noir que tens.';

  @override
  String get onboardingSpectrumNoirLine =>
      '216 cores · Assinala os marcadores que tens';

  @override
  String get collectionPromarkerBrushHint =>
      'Assinala os marcadores Promarker Brush que tens.';

  @override
  String get onboardingPromarkerBrushLine =>
      '72 cores · Assinala os marcadores que tens';

  @override
  String get collectionArrtxHint => 'Assinala os marcadores Arrtx que tens.';

  @override
  String get onboardingArrtxLine =>
      '328 cores · Assinala os marcadores que tens';

  @override
  String get collectionKurecolorHint =>
      'Assinala os marcadores ZIG Kurecolor que tens.';

  @override
  String get onboardingKurecolorLine =>
      '136 cores · Assinala os marcadores que tens';

  @override
  String get collectionGraphitHint =>
      'Assinala os marcadores Graph\'it que tens.';

  @override
  String get onboardingGraphitLine =>
      '168 cores · Assinala os marcadores que tens';

  @override
  String get collectionMarvyLePlumeHint =>
      'Assinala os marcadores Marvy Le Plume que tens.';

  @override
  String get onboardingMarvyLePlumeLine =>
      '144 cores · Assinala os marcadores que tens';

  @override
  String get collectionBlickBrushHint =>
      'Assinala os marcadores Blick Studio Brush que tens.';

  @override
  String get onboardingBlickBrushLine =>
      '96 cores · Assinala os marcadores que tens';

  @override
  String get collectionArtistsLoftHint =>
      'Assinala os marcadores Artist\'s Loft que tens.';

  @override
  String get onboardingArtistsLoftLine =>
      '56 cores · Assinala os marcadores que tens';

  @override
  String get shortcutMatchLabel => 'Comparar uma cor';

  @override
  String get shortcutNewPaletteLabel => 'Nova paleta';

  @override
  String get shortcutSearchSwatchesLabel => 'Pesquisar amostras';

  @override
  String get brandSearchHint => 'Procurar marca';

  @override
  String get brandGroupPopular => 'Populares';

  @override
  String get brandGroupMore => 'Mais marcas';

  @override
  String get brandSearchEmpty => 'Nenhuma marca corresponde à tua pesquisa.';

  @override
  String get brandGroupOwned => 'As tuas marcas';

  @override
  String brandOwnedLine(int owned, int total) {
    String _temp0 = intl.Intl.pluralLogic(
      owned,
      locale: localeName,
      other: '$owned de $total teus',
      one: '1 de $total teu',
    );
    return '$_temp0';
  }

  @override
  String get navRailExpand => 'Expandir o menu';

  @override
  String get navRailCollapse => 'Recolher o menu';

  @override
  String get inkLevelTitle => 'Nível de tinta';

  @override
  String get inkLevelFull => 'Cheio';

  @override
  String get commonRunningOut => 'A acabar';

  @override
  String get refillNoteTitle => 'Nota de recarga';

  @override
  String get refillNoteEmpty => 'Adiciona uma nota, como «recarregado a 3 nov»';

  @override
  String get refillNoteHint => 'Recarregado a 3 nov';

  @override
  String get refillNoteSave => 'Guardar';

  @override
  String get refillNoteRemove => 'Remover nota';

  @override
  String get swatchPhotoTitle => 'Amostra real';

  @override
  String get swatchPhotoEmpty => 'Adiciona uma foto da tua amostra em papel';

  @override
  String get swatchPhotoHas => 'A tua amostra em papel';

  @override
  String get swatchPhotoView => 'Ver foto';

  @override
  String get swatchPhotoTake => 'Tirar uma foto';

  @override
  String get swatchPhotoChoose => 'Escolher da galeria';

  @override
  String get swatchPhotoSaved => 'Foto guardada';

  @override
  String get swatchPhotoSaveFailed =>
      'Não foi possível guardar a foto. Tenta outra.';

  @override
  String get swatchPhotoRemoved => 'Foto removida';

  @override
  String get swatchShadowLightTitle => 'Sombra e luz';

  @override
  String get swatchShadow => 'Sombra';

  @override
  String get swatchLight => 'Luz';

  @override
  String get swatchShadowLightNone => 'Nenhum na tua coleção';

  @override
  String get swatchBlendWith => 'Misturar com…';

  @override
  String get swatchBlendTitle => 'Misturar com';

  @override
  String get swatchBlendSearchHint => 'Pesquisar marcadores';

  @override
  String get swatchBlendNoMarkers =>
      'Não tens outros marcadores para misturar.';

  @override
  String get swatchBlendNoResults =>
      'Nenhum marcador corresponde à tua pesquisa.';

  @override
  String get swatchBlendSteps => 'Pelo meio, da tua coleção';

  @override
  String get swatchBlendNothingBetween =>
      'Estes dois estão suficientemente perto para se misturarem diretamente.';

  @override
  String get swatchBlendNoneBetween =>
      'Nenhum dos teus marcadores fica entre eles.';

  @override
  String swatchBlendBuy(String code) {
    return 'Salto grande. Para o preencher, o marcador mais próximo que não tens é $code.';
  }

  @override
  String swatchBlendStripSemantics(String from, String to) {
    return 'Gradiente de $from para $to';
  }

  @override
  String swatchDuplicatesTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Já tens $count marcadores muito parecidos com este',
      one: 'Já tens 1 marcador muito parecido com este',
    );
    return '$_temp0';
  }

  @override
  String get swatchDuplicatesHint => 'Quase a mesma cor: um novo traz pouco.';

  @override
  String swatchDuplicatesMore(int count) {
    return 'e mais $count';
  }

  @override
  String get swatchDuplicatesNone =>
      'Nada na tua coleção é muito parecido: traria uma cor nova.';

  @override
  String wishlistDuplicateNote(String codes) {
    return 'Muito parecido com $codes da tua coleção';
  }

  @override
  String wishlistRunningOutCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count marcadores a acabar',
      one: '1 marcador a acabar',
      zero: 'Nada está a acabar',
    );
    return '$_temp0';
  }

  @override
  String get wishlistRunningOutHint =>
      'Continuam a ser usados. Junta-os à lista quando quiseres comprar ou recarregar.';

  @override
  String swatchesAllBrands(int count) {
    return 'Todas as marcas ($count)';
  }

  @override
  String get swatchesOtherBrandsYours => 'As tuas marcas';

  @override
  String get inkLevelFullNote =>
      'Cheio: Comparar, Paleta e Ideias podem sugeri-lo.';

  @override
  String get inkLevelRunningOutNote =>
      'A acabar: continua a ser usado em todo o lado. Aparece no grupo «A acabar» da tua lista de desejos.';

  @override
  String get swatchesDetailPaneEmpty =>
      'Toca num marcador para veres aqui os detalhes.';

  @override
  String get collectionMixBrands => 'Misturar as minhas marcas';

  @override
  String collectionMoreBrands(String first, String second, int count) {
    return '$first, $second e mais $count';
  }

  @override
  String collectionBrandsCount(int count) {
    return '$count marcas';
  }

  @override
  String get paletteChanged => 'Paleta alterada';

  @override
  String get paletteReplaceTitle => 'Substituir esta paleta?';

  @override
  String get paletteReplaceBody =>
      'A paleta no ecrã será substituída, com as tuas alterações e as tuas cores fixadas. Poderás anular logo a seguir.';

  @override
  String get paletteReplaceButton => 'Substituir';

  @override
  String get paletteAmbiguousBase =>
      'Este código existe em mais de uma das tuas marcas. Escolhe a marca na lista.';

  @override
  String get paletteChainWholeRangeNoteMixed =>
      'A mostrar toda a gama das tuas marcas, também marcadores que não tens.';

  @override
  String paletteBaseOtherBrand(String code, String brand, String example) {
    return '$code é um marcador da $brand, e a $brand não está em uso neste momento. Experimenta $example ou muda a marca em A minha coleção.';
  }

  @override
  String get paletteImportTooFew =>
      'Adiciona pelo menos dois códigos de marcadores diferentes e reconhecidos para importar uma paleta.';
}
