import 'dart:math';

const _deviceIdByteCount = 16;
final _deviceIdPattern = RegExp(r'^[0-9a-f]{32}$');

/// Returns the only device attributes monitoring sends to its handlers.
Map<String, Object> deviceAttributes({
  required String userAgent,
  required String language,
  required int screenWidth,
  required int screenHeight,
}) => {
  'platform': 'web',
  'browser_name': _browserName(userAgent),
  'language': language,
  'screen_width': screenWidth,
  'screen_height': screenHeight,
};

String _browserName(String userAgent) {
  final ua = userAgent.toLowerCase();
  if (ua.contains('firefox')) return 'Firefox';
  if (ua.contains('samsungbrowser')) return 'Samsung Internet';
  if (ua.contains('opera') || ua.contains('opr')) return 'Opera';
  if (ua.contains('trident')) return 'Internet Explorer';
  if (ua.contains('edge')) return 'Edge';
  if (ua.contains('chrome')) return 'Chrome';
  if (ua.contains('safari')) return 'Safari';
  return 'Unknown';
}

/// Returns 32 lowercase hex characters drawn from [random].
///
/// Pass `Random.secure()` in production; the id carries no browser traits.
String generateDeviceId(Random random) {
  final bytes = List<int>.generate(
    _deviceIdByteCount,
    (_) => random.nextInt(256),
  );
  return bytes.map((byte) => byte.toRadixString(16).padLeft(2, '0')).join();
}

/// Returns whether [value] has the format [generateDeviceId] produces.
bool isDeviceId(String value) => _deviceIdPattern.hasMatch(value);
