import 'package:jaspr_falmonitor/src/umami/option.dart';

/// Returns the attributes of the Umami tracker `<script>` for [option].
///
/// Requires `scriptUrl` and `websiteId`; names follow the Umami tracker
/// configuration.
Map<String, String> umamiScriptAttributes(UmamiAnalyticOption option) {
  final hostUrl = option.hostUrl;
  final autoTrack = option.autoTrack;
  final domains = option.domains;
  return {
    'src': option.scriptUrl!,
    'data-website-id': option.websiteId!,
    'data-host-url': ?hostUrl,
    if (autoTrack != null) 'data-auto-track': '$autoTrack',
    if (domains != null) 'data-domains': domains.join(','),
  };
}
