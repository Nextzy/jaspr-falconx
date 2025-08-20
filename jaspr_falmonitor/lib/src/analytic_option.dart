import 'package:jaspr_falmonitor/lib.dart';

abstract class AnalyticOption {
  const AnalyticOption({
    this.enabled = true,
  });

  final bool enabled;
}
