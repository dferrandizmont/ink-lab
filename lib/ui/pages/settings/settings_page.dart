import 'package:flutter/material.dart';

import '../../../app_scope.dart';
import '../../../core/models.dart';
import '../../../data/data.dart';
import '../../theme/app_typography.dart';
import '../../theme/tokens.dart';
import '../../widgets/page_header.dart';
import 'about_section.dart';
import 'ai_section.dart';
import 'appearance_section.dart';
import 'backup_section.dart';
import 'brand_section.dart';
import 'favorites_section.dart';
import 'labels_section.dart';
import 'language_section.dart';
import 'owned_markers_section.dart';
import 'packs_section.dart';
import 'saved_palettes_section.dart';
import 'settings_target.dart';
import 'constants.dart';
import 'settings_widgets.dart';
import '../../../l10n/l10n.dart';

/// The settings screen.
///
/// Every change is persisted through the repositories of [AppScope]: the
/// collection settings, the favorites, the saved palettes and the AI
/// settings all live in the local store.
class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  /// Key of the page body, handy for tests and for state restoration.
  static const Key pageKey = Key('settings-page');

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  AppScope? _scope;
  Stream<AppSettingsState>? _settingsChanges;
  Stream<AiSettings>? _aiChanges;
  final Map<MarkerBrand, Stream<List<SavedPalette>>> _paletteStreams =
      <MarkerBrand, Stream<List<SavedPalette>>>{};
  final GlobalKey _ownedKey = GlobalKey(debugLabel: 'settings-owned-markers');

  @override
  void initState() {
    super.initState();
    settingsTarget.addListener(_scheduleTarget);
    _scheduleTarget();
  }

  @override
  void dispose() {
    settingsTarget.removeListener(_scheduleTarget);
    super.dispose();
  }

  void _scheduleTarget() {
    if (settingsTarget.value == null) return;
    // After the frame: the tab may be built in the same frame it is opened.
    WidgetsBinding.instance.addPostFrameCallback((_) => _onTarget());
  }

  /// Scrolls to the part of the page another tab asked for, then consumes the
  /// request.
  void _onTarget() {
    final SettingsTarget? target = settingsTarget.value;
    if (target == null || !mounted) return;
    final BuildContext? targetContext = switch (target) {
      SettingsTarget.ownedMarkers => _ownedKey.currentContext,
    };
    if (targetContext == null) return;
    settingsTarget.value = null;
    Scrollable.ensureVisible(
      targetContext,
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeOut,
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // `dependOnInheritedWidgetOfExactType` (instead of `AppScope.of`) so the
    // page can also be hosted where no scope is available yet: it then shows
    // a short message instead of throwing.
    final AppScope? scope = context
        .dependOnInheritedWidgetOfExactType<AppScope>();
    if (scope != null && !identical(scope, _scope)) {
      _scope = scope;
      _paletteStreams.clear();
      // The streams are captured once: a new stream object on every build
      // would make the StreamBuilder resubscribe on every frame.
      _settingsChanges = scope.settings.changes;
      _aiChanges = scope.aiSettings.changes;
    }
  }

  /// The palettes of [brand].
  ///
  /// The stream is kept per brand, so the same stream object is used every
  /// time the page is rebuilt.
  Stream<List<SavedPalette>> _palettesOf(AppScope scope, MarkerBrand brand) =>
      _paletteStreams.putIfAbsent(
        brand,
        () => scope.savedPalettes.watch(brand),
      );

  @override
  Widget build(BuildContext context) {
    final AppScope? scope = _scope;
    if (scope == null) {
      return Center(
        key: SettingsPage.pageKey,
        child: Padding(
          padding: const EdgeInsets.all(InkSpacing.s24),
          child: Text(
            context.l10n.settingsUnavailable,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      );
    }
    return StreamBuilder<AppSettingsState>(
      stream: _settingsChanges,
      initialData: scope.settings.state,
      builder:
          (BuildContext context, AsyncSnapshot<AppSettingsState> snapshot) {
            final AppSettingsState state =
                snapshot.data ?? scope.settings.state;
            final InkColors ink = InkColors.of(context);
            return ListView(
              key: SettingsPage.pageKey,
              padding: const EdgeInsets.only(bottom: InkSpacing.pageBottom),
              children: <Widget>[
                InkPageHeader(
                  title: context.l10n.settingsTitle,
                  subtitleWidget: Text.rich(
                    TextSpan(
                      children: <InlineSpan>[
                        const TextSpan(text: '${SettingsConstants.appName} '),
                        TextSpan(
                          text: SettingsConstants.appVersion,
                          style: AppTypography.data.copyWith(color: ink.fg2),
                        ),
                      ],
                    ),
                    style: AppTypography.secondary.copyWith(color: ink.fg2),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: InkSpacing.pageMargin,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      SettingsGroup(
                        title: context.l10n.settingsCollectionGroup,
                        children: <Widget>[
                          BrandSection(scope: scope, state: state),
                          PacksSection(scope: scope, state: state),
                          OwnedMarkersSection(
                            key: _ownedKey,
                            scope: scope,
                            state: state,
                          ),
                        ],
                      ),
                      const SizedBox(height: InkSpacing.section),
                      SettingsGroup(
                        title: context.l10n.settingsDisplayGroup,
                        children: <Widget>[
                          LabelsSection(scope: scope, state: state),
                          AppearanceSection(scope: scope, state: state),
                          LanguageSection(scope: scope, state: state),
                        ],
                      ),
                      const SizedBox(height: InkSpacing.section),
                      SettingsGroup(
                        title: context.l10n.settingsDataGroup,
                        children: <Widget>[
                          SavedPalettesSection(
                            scope: scope,
                            state: state,
                            palettes: _palettesOf(scope, state.brand),
                          ),
                          FavoritesSection(scope: scope, state: state),
                          BackupSection(scope: scope),
                        ],
                      ),
                      const SizedBox(height: InkSpacing.section),
                      AiSettingsSection(scope: scope, changes: _aiChanges!),
                      const SizedBox(height: InkSpacing.section),
                      SettingsGroup(
                        title: context.l10n.settingsAboutTitle,
                        children: const <Widget>[AboutSection()],
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
    );
  }
}
