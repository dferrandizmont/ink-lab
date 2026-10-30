import 'package:flutter_test/flutter_test.dart';
import 'package:ink_lab/ui/pages/palette/ai_report.dart';

const String _apiKey = 'sk-or-v1-abcdef0123456789abcdef0123456789';

String _body({List<AiReportItem>? items, String model = 'model-a'}) =>
    AiReport.body(
      appVersion: '0.6.1',
      provider: 'OpenRouter',
      model: model,
      brand: 'Ohuhu',
      context: 'complementary',
      baseCode: 'B08',
      items:
          items ??
          const <AiReportItem>[
            AiReportItem(code: 'B09', role: 'Shadow', reason: 'deep tone'),
            AiReportItem(code: 'R12', role: 'Accent', reason: 'warm pop'),
          ],
    );

void main() {
  test('the address encodes spaces as %20 and targets the developer', () {
    final Uri uri = AiReport.mailto(
      subject: AiReport.subject(AiReportReason.wrong),
      body: _body(),
    );
    final String text = uri.toString();
    expect(text, startsWith('mailto:dev@mainshai.com?subject='));
    expect(text, contains('Ink%20Lab%3A%20AI%20suggestion%20report%20(wrong)'));
    expect(text, isNot(contains('+')));
    expect(uri.queryParameters['subject'], contains('(wrong)'));
  });

  test('the body names the model, codes, roles and reasons', () {
    final String body = _body();
    expect(body, contains('App version: 0.6.1'));
    expect(body, contains('AI provider: OpenRouter'));
    expect(body, contains('Model: model-a'));
    expect(body, contains('Base marker: B08'));
    expect(body, contains('- B09 | Shadow | deep tone'));
    expect(body, contains('- R12 | Accent | warm pop'));
    expect(body, endsWith('Anything to add:\n'));
  });

  test('long fields are truncated', () {
    final String body = _body(
      items: <AiReportItem>[
        AiReportItem(code: 'B09', role: 'Shadow', reason: 'x' * 900),
      ],
    );
    expect(body, isNot(contains('x' * 250)));
    expect(body, contains('…'));
  });

  test('the body stays under the length limit with many suggestions', () {
    final String body = _body(
      items: <AiReportItem>[
        for (var i = 0; i < 40; i++)
          AiReportItem(code: 'C$i', role: 'Role', reason: 'y' * 300),
      ],
    );
    expect(body.length, lessThanOrEqualTo(AiReport.maxBodyLength));
    expect(body, endsWith('Anything to add:\n'));
  });

  test('a secret never passed in is never in the address', () {
    final Uri uri = AiReport.mailto(
      subject: AiReport.subject(AiReportReason.offensive),
      body: _body(),
    );
    expect(Uri.decodeFull(uri.toString()), isNot(contains(_apiKey)));
    expect(uri.toString(), isNot(contains('sk-or')));
  });

  test('model text cannot add mail headers or lines to the address', () {
    final Uri uri = AiReport.mailto(
      subject: 's',
      body: AiReport.body(
        appVersion: '0.6.2',
        provider: 'OpenRouter',
        model: 'm',
        brand: 'Ohuhu',
        context: 'complementary',
        baseCode: 'R1',
        items: const <AiReportItem>[
          AiReportItem(
            code: 'B2',
            role: 'Accent',
            reason: 'x&cc=evil@x.com\r\nBcc: evil@x.com',
          ),
        ],
      ),
    );
    final String text = uri.toString();
    expect(text, isNot(contains('&cc=')));
    expect(text, isNot(contains('evil@x.com')));
    expect('&'.allMatches(text).length, 1);
  });
}
