import 'package:flutter/widgets.dart';

import 'app_localizations.dart';

export 'app_localizations.dart';
export 'core_labels.dart';
export 'ideas_text.dart';
export 'phrases.dart';

/// `context.l10n` gives the generated [AppLocalizations] of the current locale.
extension L10nContext on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this);
}
