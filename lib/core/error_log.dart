import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';

/// Where [ErrorLog] keeps its text. The app uses [FileErrorLogStorage]; tests
/// use [MemoryErrorLogStorage] (widget tests cannot do real file I/O).
abstract interface class ErrorLogStorage {
  /// Size in bytes of the current file; 0 when there is none.
  Future<int> currentLength();

  /// Whether the current or the previous file holds any text.
  Future<bool> hasContent();

  /// Adds [text] at the end of the current file.
  Future<void> append(String text);

  /// Turns the current file into the previous one, replacing the old
  /// previous one.
  Future<void> rotate();

  /// The previous file followed by the current one.
  Future<String> readAll();

  /// Deletes both files.
  Future<void> clear();
}

/// [ErrorLogStorage] on two files in a folder of the app: `ink-lab-errors.log`
/// and, after a rotation, `ink-lab-errors.1.log`.
final class FileErrorLogStorage implements ErrorLogStorage {
  FileErrorLogStorage(this._directory);

  static const String currentName = 'ink-lab-errors.log';
  static const String previousName = 'ink-lab-errors.1.log';

  final Future<Directory> Function() _directory;
  Directory? _resolved;

  Future<File> _file(String name) async {
    Directory? dir = _resolved;
    if (dir == null) {
      dir = await _directory();
      if (!await dir.exists()) await dir.create(recursive: true);
      _resolved = dir;
    }
    return File('${dir.path}${Platform.pathSeparator}$name');
  }

  @override
  Future<int> currentLength() async {
    final File file = await _file(currentName);
    return await file.exists() ? await file.length() : 0;
  }

  @override
  Future<bool> hasContent() async {
    for (final String name in <String>[currentName, previousName]) {
      final File file = await _file(name);
      if (await file.exists() && await file.length() > 0) return true;
    }
    return false;
  }

  @override
  Future<void> append(String text) async {
    final File file = await _file(currentName);
    await file.writeAsString(text, mode: FileMode.append, flush: true);
  }

  @override
  Future<void> rotate() async {
    final File current = await _file(currentName);
    final File previous = await _file(previousName);
    if (await previous.exists()) await previous.delete();
    if (await current.exists()) await current.rename(previous.path);
  }

  @override
  Future<String> readAll() async {
    final StringBuffer text = StringBuffer();
    for (final String name in <String>[previousName, currentName]) {
      final File file = await _file(name);
      if (!await file.exists()) continue;
      final List<int> bytes = await file.readAsBytes();
      text.write(utf8.decode(bytes, allowMalformed: true));
    }
    return text.toString();
  }

  @override
  Future<void> clear() async {
    for (final String name in <String>[currentName, previousName]) {
      final File file = await _file(name);
      if (await file.exists()) await file.delete();
    }
  }
}

/// [ErrorLogStorage] in memory (tests and previews).
final class MemoryErrorLogStorage implements ErrorLogStorage {
  String current = '';
  String previous = '';

  @override
  Future<int> currentLength() async => utf8.encode(current).length;

  @override
  Future<bool> hasContent() async => current.isNotEmpty || previous.isNotEmpty;

  @override
  Future<void> append(String text) async => current += text;

  @override
  Future<void> rotate() async {
    previous = current;
    current = '';
  }

  @override
  Future<String> readAll() async => previous + current;

  @override
  Future<void> clear() async {
    current = '';
    previous = '';
  }
}

/// A small local log of the errors the app did not handle.
///
/// It exists so the user can send the technical details of a crash by hand:
/// nothing is uploaded and nothing leaves the phone unless the user shares
/// the text. Every entry is a header (time, app version, platform, where the
/// error was caught), the error and a trimmed stack.
///
/// The log never holds what the user wrote or drew: only the first line of an
/// error message is kept and [redact] cleans it (see there for the rules).
/// [record] never throws and never blocks the caller; writes are queued so
/// entries never interleave. The text is rotated at about [maxBytes], keeping
/// one previous file.
class ErrorLog {
  ErrorLog({
    required this.storage,
    required this.appVersion,
    required this.platform,
    DateTime Function()? clock,
    this.maxBytes = defaultMaxBytes,
  }) : _clock = clock ?? DateTime.now;

  /// Size at which the current file becomes the previous one.
  static const int defaultMaxBytes = 200 * 1024;

  /// Longest error message kept (first line only), in characters.
  static const int maxMessageChars = 300;

  /// Most stack lines kept, longest line and total stack length.
  static const int maxStackLines = 40;
  static const int maxStackLineChars = 200;
  static const int maxStackChars = 4000;

  /// The same error repeated inside this time is written once.
  static const Duration repeatWindow = Duration(seconds: 30);

  final ErrorLogStorage storage;
  final String appVersion;
  final String platform;
  final int maxBytes;
  final DateTime Function() _clock;

  final ValueNotifier<bool> _hasContent = ValueNotifier<bool>(false);
  Future<void> _tail = Future<void>.value();
  String? _lastBody;
  DateTime? _lastAt;

  /// Whether the log holds any text. Starts `false` until [refresh] has read
  /// the files; changes after [record] and [clear].
  ValueListenable<bool> get hasContent => _hasContent;

  /// Reads the files to know whether there is anything to share. Never
  /// throws.
  Future<void> refresh() => _enqueue(() async {
    _hasContent.value = await storage.hasContent();
  });

  /// Adds [error] with its [stack] to the log. Never throws; [source] says
  /// where it was caught ("flutter", "platform", "zone").
  Future<void> record(Object error, StackTrace? stack, {String? source}) {
    final String entry;
    final String body;
    final DateTime now;
    try {
      now = _clock();
      body = '${_describe(error)}\n${_trimStack(stack)}';
      final DateTime? lastAt = _lastAt;
      if (body == _lastBody &&
          lastAt != null &&
          now.difference(lastAt) < repeatWindow) {
        return _tail;
      }
      _lastBody = body;
      _lastAt = now;
      final String where = source == null ? '' : ' | ${_clip(source, 80)}';
      entry =
          '-- ${now.toUtc().toIso8601String()} | Ink Lab $appVersion | '
          '${redact(_clip(platform, 100))}$where\n$body\n\n';
    } catch (_) {
      return _tail;
    }
    return _enqueue(() async {
      final int size = utf8.encode(entry).length;
      final int length = await storage.currentLength();
      if (length > 0 && length + size > maxBytes) await storage.rotate();
      await storage.append(entry);
      _hasContent.value = true;
    });
  }

  /// The whole log (older text first), or an empty string. Never throws.
  Future<String> read() async {
    try {
      await _tail;
      return await storage.readAll();
    } catch (_) {
      return '';
    }
  }

  /// Deletes the log. Never throws.
  Future<void> clear() => _enqueue(() async {
    await storage.clear();
    _lastBody = null;
    _lastAt = null;
    _hasContent.value = false;
  });

  Future<void> _enqueue(Future<void> Function() job) {
    _tail = _tail.then((_) => job()).catchError((Object _) {});
    return _tail;
  }

  String _describe(Object error) {
    String text;
    try {
      text = error.toString();
    } catch (_) {
      text = '';
    }
    // Only the first line: a FormatException prints the text it could not
    // read on the lines after it, and that text can be the user's own.
    final String first = text.trimLeft().split('\n').first.trim();
    final String type = error.runtimeType.toString();
    final String line = first.startsWith(type) ? first : '$type: $first';
    return redact(_clip(line, maxMessageChars));
  }

  String _trimStack(StackTrace? stack) {
    if (stack == null) return '(no stack)';
    final List<String> lines = stack
        .toString()
        .split('\n')
        .where((String line) => line.trim().isNotEmpty)
        .take(maxStackLines)
        .map((String line) => _clip(line.trim(), maxStackLineChars))
        .toList();
    String text = redact(lines.join('\n'));
    if (text.length > maxStackChars) {
      text = '${text.substring(0, maxStackChars)}\n...[truncated]';
    }
    return text;
  }

  static String _clip(String text, int max) =>
      text.length <= max ? text : '${text.substring(0, max)}...';

  // ---- Redaction -------------------------------------------------------

  static final RegExp _urlQuery = RegExp(
    r'''(https?://[^\s?#'")\]}>]+)[?#][^\s'")\]}>]*''',
  );
  static final RegExp _bearer = RegExp(r'[Bb]earer\s+\S+');
  static final RegExp _namedSecret = RegExp(
    r'(authorization|x-api-key|api[_-]?key|secret|password|token)'
    r'''(["']?\s*[:=]\s*["']?)[^\s,;"']+''',
    caseSensitive: false,
  );
  static final RegExp _skKey = RegExp(r'sk-[A-Za-z0-9._\-]{6,}');
  static final RegExp _userFolder = RegExp(
    r'(?:[A-Za-z]:)?[\\/]+(?:Users|home)[\\/]+[^\\/\s:*?"<>|]+',
    caseSensitive: false,
  );
  static final RegExp _appFolder = RegExp(
    r'/var/mobile/Containers/(?:Data|Shared)/[^\s]*?/[0-9A-Fa-f\-]{36}'
    r'|/data/(?:user/\d+|data)/[A-Za-z0-9_.]+',
  );
  static final RegExp _email = RegExp(r'[\w.+\-]+@[\w\-]+(?:\.[\w\-]+)+');
  static final RegExp _longToken = RegExp(r'[A-Za-z0-9_\-]{32,}');

  /// Removes what must not be in the log from [text].
  ///
  /// Rules, applied in this order:
  /// 1. the query string and fragment of any `http(s)://` address;
  /// 2. `Bearer <token>`;
  /// 3. values after `authorization`, `x-api-key`, `api key`, `secret`,
  ///    `password` or `token` followed by `:` or `=`;
  /// 4. OpenRouter style keys (`sk-` and six or more key characters);
  /// 5. the app folder on Android (`/data/user/0/<package>`,
  ///    `/data/data/<package>`) and iOS (`.../Application/<uuid>`), as
  ///    `<app>`;
  /// 6. the home folder of a Windows, macOS or Linux user (the folder under
  ///    the system `Users` or `home` directory), as `~`;
  /// 7. e-mail addresses;
  /// 8. any run of 32 or more letters, digits, `_` or `-` that holds a digit
  ///    (keys, hashes, UUIDs).
  static String redact(String text) {
    String result = text.replaceAllMapped(
      _urlQuery,
      (Match m) => '${m.group(1)}?[redacted]',
    );
    result = result.replaceAll(_bearer, 'Bearer [redacted]');
    result = result.replaceAllMapped(
      _namedSecret,
      (Match m) => '${m.group(1)}${m.group(2)}[redacted]',
    );
    result = result.replaceAll(_skKey, '[redacted]');
    result = result.replaceAll(_appFolder, '<app>');
    result = result.replaceAll(_userFolder, '~');
    result = result.replaceAll(_email, '[email]');
    result = result.replaceAllMapped(
      _longToken,
      (Match m) => RegExp(r'\d').hasMatch(m.group(0)!) ? '[redacted]' : m[0]!,
    );
    return result;
  }
}

/// Keeps the default error behaviour (the framework prints or presents the
/// error in debug) and also adds every framework and platform error to
/// [log].
void installErrorHandlers(ErrorLog log) {
  final FlutterExceptionHandler? previous = FlutterError.onError;
  FlutterError.onError = (FlutterErrorDetails details) {
    if (previous != null) {
      previous(details);
    } else {
      FlutterError.presentError(details);
    }
    unawaited(
      log.record(
        details.exception,
        details.stack,
        source: 'flutter (${details.library ?? 'unknown'})',
      ),
    );
  };
  final bool Function(Object, StackTrace)? previousPlatform =
      PlatformDispatcher.instance.onError;
  PlatformDispatcher.instance.onError = (Object error, StackTrace stack) {
    unawaited(log.record(error, stack, source: 'platform'));
    // false: the platform keeps its own handling (it prints in debug).
    return previousPlatform?.call(error, stack) ?? false;
  };
}

/// Runs [body] in a zone whose uncaught errors go to [log]. In debug they are
/// also printed, as they would be without the zone.
void runGuardedByErrorLog(ErrorLog log, void Function() body) {
  runZonedGuarded<void>(body, (Object error, StackTrace stack) {
    unawaited(log.record(error, stack, source: 'zone'));
    if (kDebugMode) debugPrint('Uncaught error: $error\n$stack');
  });
}
