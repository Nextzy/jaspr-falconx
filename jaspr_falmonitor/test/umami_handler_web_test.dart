@TestOn('browser')
library;

import 'package:jaspr_falmonitor/lib.dart';
import 'package:test/test.dart';
import 'package:universal_web/web.dart' as web;

const _trackerSelector = 'script[data-website-id="w"]';
const _missingScriptUrl = 'https://127.0.0.1:9/missing.js';

const _option = UmamiAnalyticOption(
  websiteId: 'w',
  scriptUrl: _missingScriptUrl,
);

class _MemoryOutput extends LogOutput {
  final lines = <String>[];

  @override
  void output(OutputEvent event) => lines.addAll(event.lines);
}

void main() {
  late _MemoryOutput logs;

  setUp(() {
    logs = _MemoryOutput();
    Log.setup(output: logs, printer: SimplePrinter());
    UmamiHandler.resetTrackerLoad();
    web.Element? stale;
    while ((stale = web.document.head!.querySelector(_trackerSelector)) !=
        null) {
      stale?.remove();
    }
  });

  test('calls do nothing and log while window.umami is missing', () async {
    final handler = UmamiHandler.instance..option = const UmamiAnalyticOption();

    await handler.setupUserIdentifier(userId: 'u');
    await handler.captureEvent(type: 't');
    await handler.captureScreenView('/');

    final warnings = logs.lines.where((l) => l.contains('window.umami'));
    expect(warnings.length, 3);
  });

  test(
    'initial adds one deferred tracker script and completes on error',
    () async {
      await UmamiHandler.instance.initial(_option);

      final scripts = web.document.head!.querySelectorAll(_trackerSelector);
      expect(scripts.length, 1);
      final script = scripts.item(0)! as web.HTMLScriptElement;
      expect(script.defer, isTrue);
      expect(script.getAttribute('src'), _missingScriptUrl);
    },
  );

  test('a second initial does not add a second script', () async {
    await UmamiHandler.instance.initial(_option);
    await UmamiHandler.instance
        .initial(_option)
        .timeout(const Duration(seconds: 5));

    final scripts = web.document.head!.querySelectorAll(_trackerSelector);
    expect(scripts.length, 1);
  });
}
