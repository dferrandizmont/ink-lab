import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:ink_lab/core/app_version.dart';

void main() {
  test('appVersion matches the version in pubspec.yaml', () {
    final String pubspec = File('pubspec.yaml').readAsStringSync();
    final RegExpMatch? match = RegExp(
      r'^version:\s*([0-9]+\.[0-9]+\.[0-9]+)(\+\d+)?\s*$',
      multiLine: true,
    ).firstMatch(pubspec);

    expect(match, isNotNull, reason: 'pubspec.yaml has no version');
    expect(appVersion, match!.group(1));
  });
}
