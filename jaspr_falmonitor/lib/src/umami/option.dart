import 'package:jaspr_falmonitor/lib.dart';

class UmamiAnalyticOption extends AnalyticOption {
  const UmamiAnalyticOption({
    super.enabled,
    this.websiteId,
    this.scriptUrl,
    this.hostUrl,
    this.autoTrack,
    this.domains,
  });

  final String? websiteId;
  final String? scriptUrl;
  final String? hostUrl;
  final bool? autoTrack;
  final List<String>? domains;
}
