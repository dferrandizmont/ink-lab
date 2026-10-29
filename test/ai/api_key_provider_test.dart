import 'package:flutter_test/flutter_test.dart';
import 'package:ink_lab/ai/api_key_provider.dart';
import 'package:ink_lab/data/data.dart';

const _key = 'sk-or-v1-abcdef0123456789abcdef0123456789';

void main() {
  group('maskKey', () {
    test('shows only the last 4 characters', () {
      final masked = maskKey(_key);
      expect(masked, endsWith('6789'));
      expect(masked, isNot(contains('sk-or')));
      expect(masked, isNot(contains('abcdef')));
    });
    test('fully masks short values and handles empty', () {
      expect(maskKey('abcd1234'), isNot(contains('1234')));
      expect(maskKey(''), '');
    });
  });

  group('looksLikeOpenRouterKey', () {
    test('accepts a plausible key', () {
      expect(looksLikeOpenRouterKey(_key), isTrue);
    });
    test('rejects wrong prefix, short, long, whitespace, empty', () {
      expect(
        looksLikeOpenRouterKey('sk-xx-v1-abcdef0123456789abcdef'),
        isFalse,
      );
      expect(looksLikeOpenRouterKey('sk-or-short'), isFalse);
      expect(looksLikeOpenRouterKey('sk-or-${'a' * 300}'), isFalse);
      expect(looksLikeOpenRouterKey('$_key '), isFalse);
      expect(
        looksLikeOpenRouterKey('sk-or-v1-abcdef 0123456789abcdef'),
        isFalse,
      );
      expect(looksLikeOpenRouterKey(''), isFalse);
    });
  });

  group('ApiKeyProvider', () {
    test('returns null when nothing is stored or value is blank', () async {
      final secrets = InMemorySecretStore();
      final provider = ApiKeyProvider(secrets);
      expect(await provider(), isNull);
      await secrets.write(openRouterApiKeyName, '   ');
      expect(await provider(), isNull);
    });

    test('save trims, call reads, clear deletes', () async {
      final secrets = InMemorySecretStore();
      final provider = ApiKeyProvider(secrets);
      await provider.save('  $_key\n');
      expect(await secrets.read('openrouter_api_key'), _key);
      expect(await provider(), _key);
      await provider.clear();
      expect(await provider(), isNull);
    });

    test('save rejects invalid keys without echoing them', () async {
      final provider = ApiKeyProvider(InMemorySecretStore());
      await expectLater(
        provider.save('not-a-key-secret'),
        throwsA(
          isA<ArgumentError>().having(
            (e) => e.toString(),
            'message',
            isNot(contains('not-a-key-secret')),
          ),
        ),
      );
    });

    test('toString does not leak', () {
      final provider = ApiKeyProvider(
        InMemorySecretStore({'openrouter_api_key': _key}),
      );
      expect(provider.toString(), isNot(contains('abcdef')));
    });
  });
}
