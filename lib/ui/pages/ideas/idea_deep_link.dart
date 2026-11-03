import 'dart:async';
import 'dart:io' show Platform;

import 'package:flutter/widgets.dart';
import 'package:home_widget/home_widget.dart';

import '../../../core/ideas_engine.dart';

/// The idea the home-screen widget asked to open, or `null`.
///
/// Tapping the "Idea of the day" widget opens the app with `inklab://idea/<id>`.
/// [openIdeaFromWidgetUri] puts the id here; the app shell then switches to the
/// Ideas tab and the Ideas page opens that idea's sheet and consumes the value
/// by setting it back to `null`, so a link is acted on once.
///
/// Module-level and tiny, like `paletteDraft`: the pages are parameterless and
/// talk to each other through a shared notifier.
final ValueNotifier<String?> ideaDeepLink = ValueNotifier<String?>(null);

/// The id of the idea named by a widget link (`inklab://idea/<id>`), or `null`
/// when [uri] is not such a link or names an idea the catalogue does not have.
String? ideaIdFromWidgetUri(Uri? uri) {
  if (uri == null || uri.scheme != 'inklab' || uri.host != 'idea') return null;
  final List<String> segments = uri.pathSegments
      .where((String s) => s.isNotEmpty)
      .toList();
  if (segments.length != 1) return null;
  final String id = segments.single;
  return IdeasEngine.byId(id) == null ? null : id;
}

/// Hands a widget link to the app: sets [ideaDeepLink] when [uri] names a known
/// idea, ignores it otherwise. Returns whether it was accepted.
bool openIdeaFromWidgetUri(Uri? uri) {
  final String? id = ideaIdFromWidgetUri(uri);
  if (id == null) return false;
  ideaDeepLink.value = id;
  return true;
}

/// Listens to the widget taps: the one that launched the app and the ones that
/// arrive while it runs. Android only, unless the sources are injected.
///
/// [initial] and [clicks] default to the `home_widget` plugin; tests pass
/// fakes. Failures are swallowed: a broken link never breaks the app. Returns
/// the subscription so the caller can cancel it (`null` when nothing listens).
Future<StreamSubscription<Uri?>?> listenToIdeaWidgetLinks({
  Future<Uri?> Function()? initial,
  Stream<Uri?>? clicks,
}) async {
  final bool injected = initial != null || clicks != null;
  if (!injected && !_isAndroid) return null;
  final Future<Uri?> Function() launchLink =
      initial ?? HomeWidget.initiallyLaunchedFromHomeWidget;
  bool opened = false;
  try {
    opened = openIdeaFromWidgetUri(await launchLink());
  } catch (_) {
    // No launch link; the app opens normally.
  }
  if (!opened && !injected) {
    // A tap that restores an activity whose process had died reaches
    // MainActivity.onNewIntent, after the first look: look once more when
    // the first frame is on screen.
    try {
      await WidgetsBinding.instance.endOfFrame;
      openIdeaFromWidgetUri(await launchLink());
    } catch (_) {
      // Still no link; the app opens normally.
    }
  }
  try {
    return (clicks ?? HomeWidget.widgetClicked).listen(
      openIdeaFromWidgetUri,
      onError: (Object _) {},
    );
  } catch (_) {
    return null;
  }
}

bool get _isAndroid {
  try {
    return Platform.isAndroid;
  } catch (_) {
    return false;
  }
}
