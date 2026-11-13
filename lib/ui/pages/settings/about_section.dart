import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart' as launcher;

import '../../../core/error_log.dart';
import '../../../core/platform_info.dart';
import '../../../data/review_prompt.dart';
import '../../icons/ink_icons.dart';
import '../../share/share_sink.dart';
import '../../theme/app_typography.dart';
import '../../theme/tokens.dart';
import '../../widgets/ink_button.dart';
import '../../widgets/section_card.dart';
import 'constants.dart';
import 'dialogs.dart';
import 'feedback_email.dart';
import 'settings_widgets.dart';
import '../../../l10n/l10n.dart';

/// The version, the source code, the licences, the feedback, the store
/// rating and error log rows and the disclaimer of the project.
///
/// Renders rows of the "About" card; the page owns the group.
class AboutSection extends StatefulWidget {
  const AboutSection({
    super.key,
    this.errorLog,
    this.reviewPrompt,
    this.launchEmail,
    this.shareSink,
    this.showLicences,
  });

  /// The local error log, or `null` where there is none (the two error log
  /// rows are then left out).
  final ErrorLog? errorLog;

  /// Opens the app's own store page from the rating row, or `null` where
  /// there is no store (the row and its divider are then left out).
  final ReviewPrompt? reviewPrompt;

  /// Opens the email app with a prepared `mailto:` address and says whether it
  /// opened. Production uses `url_launcher`; tests inject a fake.
  final Future<bool> Function(Uri uri)? launchEmail;

  /// Where the error log goes when shared. Production opens the system share
  /// sheet; tests inject a fake.
  final ShareSink? shareSink;

  /// Opens the licences page. Production shows Flutter's `LicensePage`; tests
  /// inject a fake.
  final void Function(BuildContext context)? showLicences;

  @override
  State<AboutSection> createState() => _AboutSectionState();
}

class _AboutSectionState extends State<AboutSection> {
  /// The share sheet of the error log is open: a second tap does nothing.
  bool _sharing = false;

  late final Future<bool> Function(Uri uri) _launchEmail =
      widget.launchEmail ??
      (Uri uri) => launcher.launchUrl(
        uri,
        mode: launcher.LaunchMode.externalApplication,
      );

  late final ShareSink _share = widget.shareSink ?? const SystemShareSink();

  @override
  Widget build(BuildContext context) {
    final InkColors ink = InkColors.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        InkListRow(
          label: context.l10n.settingsVersion,
          value: SettingsConstants.appVersion,
          valueIsData: true,
        ),
        const Divider(),
        ListTile(
          contentPadding: const EdgeInsets.only(
            left: InkSpacing.cardH,
            right: 4,
          ),
          title: Text(context.l10n.settingsSourceCode),
          subtitle: Text(
            SettingsConstants.repositoryUrl,
            style: AppTypography.data.copyWith(color: ink.fg2),
          ),
          trailing: InkIconButton(
            icon: InkIcons.copy,
            tooltip: context.l10n.settingsCopyRepository,
            onPressed: () => _copyLink(context),
          ),
        ),
        const Divider(),
        ListTile(
          key: const ValueKey<String>('settings-privacy-policy'),
          contentPadding: const EdgeInsets.only(
            left: InkSpacing.cardH,
            right: 4,
          ),
          title: Text(context.l10n.settingsPrivacyPolicy),
          subtitle: Text(
            _privacyUrl(context),
            style: AppTypography.data.copyWith(color: ink.fg2),
          ),
          trailing: InkIconButton(
            icon: InkIcons.copy,
            tooltip: context.l10n.settingsCopyRepository,
            onPressed: () => _copyPrivacyLink(context),
          ),
        ),
        // The beta is a Google Play test; the App Store does not allow links
        // to other stores, so iOS leaves the row out.
        if (Theme.of(context).platform != TargetPlatform.iOS) ...<Widget>[
          const Divider(),
          ListTile(
            key: const ValueKey<String>('settings-beta'),
            contentPadding: const EdgeInsets.only(
              left: InkSpacing.cardH,
              right: 4,
            ),
            title: Text(context.l10n.settingsJoinBeta),
            subtitle: Text(
              SettingsConstants.betaGroupUrl,
              style: AppTypography.data.copyWith(color: ink.fg2),
            ),
            trailing: InkIconButton(
              icon: InkIcons.copy,
              tooltip: context.l10n.settingsCopyRepository,
              onPressed: () => _copyBetaLink(context),
            ),
          ),
        ],
        const Divider(),
        InkListRow(
          key: const ValueKey<String>('settings-licences'),
          label: context.l10n.settingsLicences,
          subtitle: context.l10n.settingsLicencesSubtitle,
          chevron: true,
          onTap: () => _openLicences(context),
        ),
        const Divider(),
        InkListRow(
          key: const ValueKey<String>('settings-feedback'),
          label: context.l10n.settingsSendFeedback,
          subtitle: context.l10n.settingsSendFeedbackSubtitle,
          chevron: true,
          onTap: () => _sendFeedback(context),
        ),
        if (widget.reviewPrompt != null) ...<Widget>[
          const Divider(),
          InkListRow(
            key: const ValueKey<String>('settings-rate'),
            label: context.l10n.settingsRateApp,
            subtitle: context.l10n.settingsRateAppSubtitle,
            chevron: true,
            onTap: () => unawaited(widget.reviewPrompt!.openStoreListing()),
          ),
        ],
        if (widget.errorLog != null)
          ValueListenableBuilder<bool>(
            valueListenable: widget.errorLog!.hasContent,
            builder: (BuildContext context, bool hasContent, Widget? _) {
              // The rows exist only while the log holds something to share.
              if (!hasContent) return const SizedBox.shrink();
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  const Divider(),
                  InkListRow(
                    key: const ValueKey<String>('settings-error-log-share'),
                    label: context.l10n.settingsErrorLogShare,
                    subtitle: context.l10n.settingsErrorLogShareSubtitle,
                    chevron: true,
                    onTap: _sharing ? null : () => _shareErrorLog(context),
                  ),
                  const Divider(),
                  InkListRow(
                    key: const ValueKey<String>('settings-error-log-clear'),
                    label: context.l10n.settingsErrorLogClear,
                    onTap: () => _clearErrorLog(context),
                  ),
                ],
              );
            },
          ),
        const Divider(),
        SettingsCaption(context.l10n.settingsDisclaimer),
      ],
    );
  }

  /// Flutter's licence page: the packages the app uses, the bundled fonts and
  /// a legalese line with the licence of the app itself.
  void _openLicences(BuildContext context) {
    final void Function(BuildContext context)? custom = widget.showLicences;
    if (custom != null) {
      custom(context);
      return;
    }
    showLicensePage(
      context: context,
      applicationName: SettingsConstants.appName,
      applicationVersion: SettingsConstants.appVersion,
      applicationLegalese: context.l10n.settingsLicencesLegalese,
    );
  }

  /// Opens the email app with the version, the platform and the system
  /// version; with no email app the address is copied instead.
  Future<void> _sendFeedback(BuildContext context) async {
    final AppLocalizations l10n = context.l10n;
    final ScaffoldMessengerState? messenger = ScaffoldMessenger.maybeOf(
      context,
    );
    final Uri uri = FeedbackEmail.mailto(
      appVersion: SettingsConstants.appVersion,
      platform: PlatformInfo.name,
      osVersion: PlatformInfo.osVersion,
    );
    bool opened;
    try {
      opened = await _launchEmail(uri);
    } catch (_) {
      opened = false;
    }
    if (opened) return;
    await Clipboard.setData(
      const ClipboardData(text: SettingsConstants.contactEmail),
    );
    messenger
      ?..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          key: const ValueKey<String>('settings-feedback-copied'),
          content: Text(
            l10n.settingsFeedbackNoMail(SettingsConstants.contactEmail),
          ),
        ),
      );
  }

  /// Hands the error log to the share sheet as a text file. Nothing is sent
  /// anywhere unless the user picks an app there.
  Future<void> _shareErrorLog(BuildContext context) async {
    final ErrorLog? log = widget.errorLog;
    if (log == null) return;
    final AppLocalizations l10n = context.l10n;
    final ScaffoldMessengerState? messenger = ScaffoldMessenger.maybeOf(
      context,
    );
    setState(() => _sharing = true);
    String? problem;
    try {
      final String text = await log.read();
      if (text.isNotEmpty) {
        await _share.shareTextFile(
          text,
          name: 'ink-lab-error-log.txt',
          subject: 'Ink Lab ${SettingsConstants.appVersion} error log',
        );
      }
    } catch (_) {
      problem = l10n.settingsErrorLogShareFailed;
    }
    if (mounted) setState(() => _sharing = false);
    if (problem != null) {
      messenger
        ?..hideCurrentSnackBar()
        ..showSnackBar(SnackBar(content: Text(problem)));
    }
  }

  Future<void> _clearErrorLog(BuildContext context) async {
    final ErrorLog? log = widget.errorLog;
    if (log == null) return;
    final AppLocalizations l10n = context.l10n;
    await log.clear();
    if (!context.mounted) return;
    showMessage(context, l10n.settingsErrorLogCleared);
  }

  /// The policy page in the language of the app.
  String _privacyUrl(BuildContext context) => SettingsConstants.privacyUrlFor(
    Localizations.localeOf(context).languageCode,
  );

  Future<void> _copyPrivacyLink(BuildContext context) async {
    await Clipboard.setData(ClipboardData(text: _privacyUrl(context)));
    if (!context.mounted) return;
    showMessage(context, context.l10n.settingsRepositoryCopied);
  }

  Future<void> _copyBetaLink(BuildContext context) async {
    await Clipboard.setData(
      const ClipboardData(text: SettingsConstants.betaGroupUrl),
    );
    if (!context.mounted) return;
    showMessage(context, context.l10n.settingsRepositoryCopied);
  }

  Future<void> _copyLink(BuildContext context) async {
    await Clipboard.setData(
      const ClipboardData(text: SettingsConstants.repositoryUrl),
    );
    if (!context.mounted) return;
    showMessage(context, context.l10n.settingsRepositoryCopied);
  }
}
