import 'package:jaspr_falmonitor/lib.dart';

class SentryAnalyticOption extends AnalyticOption {
  const SentryAnalyticOption({
    super.enabled,
    required this.dns,
    this.sendDefaultPii = true,
  });

  final String dns;
  final bool sendDefaultPii;
}
