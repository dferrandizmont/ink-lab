import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart' show rootBundle;

/// A licence text bundled as an asset and the packages it covers.
typedef BundledLicence = ({String asset, List<String> packages});

/// The licence files that ship with the bundled fonts (`assets/fonts/`).
///
/// Inter has no file of its own: its copyright line and the full SIL Open
/// Font Licence 1.1 are in `LICENSE-OFL.md`, which lists all three fonts.
const List<BundledLicence> bundledFontLicences = <BundledLicence>[
  (asset: 'assets/fonts/LICENSE-OFL.md', packages: <String>['Inter']),
  (asset: 'assets/fonts/OFL-Archivo.txt', packages: <String>['Archivo']),
  (
    asset: 'assets/fonts/OFL-JetBrainsMono.txt',
    packages: <String>['JetBrains Mono'],
  ),
];

/// Adds the licences of the bundled fonts to the registry behind Flutter's
/// licence page. Nothing is read now: the registry calls the loader only when
/// the page is opened, so startup is not slowed down. A file that cannot be
/// read is skipped.
void registerBundledLicences({
  Future<String> Function(String asset) loadString = _loadAsset,
  List<BundledLicence> licences = bundledFontLicences,
}) {
  for (final BundledLicence licence in licences) {
    LicenseRegistry.addLicense(() async* {
      final String text;
      try {
        text = await loadString(licence.asset);
      } catch (_) {
        return;
      }
      yield LicenseEntryWithLineBreaks(licence.packages, text);
    });
  }
}

Future<String> _loadAsset(String asset) => rootBundle.loadString(asset);
