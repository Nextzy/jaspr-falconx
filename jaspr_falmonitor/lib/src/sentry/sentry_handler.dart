import 'package:jaspr_falmonitor/lib.dart';

class SentryHandler extends MonitorHandler<SentryAnalyticOption> {
  SentryHandler._();

  static final SentryHandler instance = SentryHandler._();

  @override
  Future<void> initial(SentryAnalyticOption option) async {
    this.option = option;
    if (enabled) {
      await Sentry.init((options) {
        options
          ..dsn = option.dns
          // Adds request headers and IP for users, for more info visit:
          // https://docs.sentry.io/platforms/dart/data-management/data-collected/
          ..sendDefaultPii = option.sendDefaultPii;
      });
    }
  }

  @override
  Future<void> setupUserIdentifier({
    required String userId,
    Map<String, Object>? attributes,
  }) async {
    try {
      if (enabled) {
        // Configure Sentry user context
        await Sentry.configureScope(
          (scope) {
            // Set the user with ID and additional attributes
            scope.setUser(
              SentryUser(
                id: userId,
                // Extract common user attributes
                email: attributes?['email'] as String?,
                username: attributes?['username'] as String?,
                name: attributes?['name'] as String?,
                ipAddress: attributes?['ipAddress'] as String?,
                // Convert remaining attributes to extra data
                data: attributes?.entries
                    .where((e) => !['email', 'username', 'name', 'ipAddress']
                        .contains(e.key))
                    .fold<Map<String, dynamic>>(
                  {},
                  (map, entry) => map..[entry.key] = entry.value,
                ),
              ),
            );

            // Add user-related tags for easier filtering
            if (attributes != null) {
              // Add user segment or type as tags
              if (attributes['segment'] != null) {
                scope.setTag('user.segment', attributes['segment'].toString());
              }
              if (attributes['userType'] != null) {
                scope.setTag('user.type', attributes['userType'].toString());
              }
              if (attributes['plan'] != null) {
                scope.setTag('user.plan', attributes['plan'].toString());
              }
            }
          },
        );
      }
    } catch (error, stackTrace) {
      Log.w(error, error: error, stackTrace: stackTrace);
    }
  }

  @override
  Future<void> captureError(
    Object error, {
    StackTrace? stackTrace,
    Map<String, Object>? attributes,
  }) async {
    try {
      if (enabled) {
        await Sentry.captureException(
          error,
          stackTrace: stackTrace,
          message: attributes != null
              ? SentryMessage(
                  attributes.toString(),
                  template: '%s',
                  params: [attributes], // Map will be converted to string
                )
              : null,
        );
      }
    } catch (error, stackTrace) {
      Log.w(error, error: error, stackTrace: stackTrace);
    }
  }

  @override
  Future<void> captureEvent({
    required String type,
    String? name,
    String? screenName,
    Map<String, Object>? eventAttributes,
  }) async {
    try {
      if (enabled) {
        final now = DateTime.now();
        await Sentry.captureEvent(
          SentryEvent(
            // Create a descriptive message for the user action
            message: SentryMessage(
              'User action: ${_formatActionType(type)}${name != null ? ' on $name' : ''}',
              template: 'User action: %s%s',
              params: [
                _formatActionType(type),
                if (name != null) ' on $name' else ''
              ],
              // User actions are typically info level
            ),
            level: SentryLevel.info,
            // Transaction helps group events by screen
            transaction: screenName ?? 'unknown_screen',
            // Tags for filtering in Sentry dashboard
            tags: {
              'action.type': type,
              if (name != null) 'action.target': name,
              if (screenName != null) 'screen': screenName,
              'event.category': 'user_interaction',
            },
            // Use contexts for structured data (recommended)
            contexts: Contexts()
              ..['user_action'] = {
                'action_type': type,
                'target_name': name,
                'screen': screenName,
                'timestamp': now.toIso8601String(),
                if (eventAttributes != null) 'attributes': eventAttributes,
              },
            // Add breadcrumb for user journey tracking
            breadcrumbs: [
              Breadcrumb(
                message:
                    '${_formatActionType(type)}${name != null ? ': $name' : ''}',
                category: 'ui.${_getActionCategory(type)}',
                level: SentryLevel.info,
                data: {
                  'action': type,
                  if (name != null) 'target': name,
                  if (screenName != null) 'screen': screenName,
                  ...?eventAttributes?.map((k, v) => MapEntry(k, v.toString())),
                },
                timestamp: now,
              ),
            ],
            // Custom fingerprint for grouping similar actions
            fingerprint: [
              'user_action',
              type,
              screenName ?? 'unknown_screen',
            ],
            timestamp: now,
          ),
        );
      }
    } catch (error, stackTrace) {
      Log.w(error, error: error, stackTrace: stackTrace);
    }
  }

  @override
  Future<void> captureScreenView(
    String path, {
    String? referrer,
  }) async {
    if (enabled) {
      // Sentry no setup user identifier feature
    }
  }

  // Helper to format action types for readability
  String _formatActionType(String type) {
    // Convert snake_case to readable format
    // "click_button" -> "Click button"
    // "add_to_cart" -> "Add to cart"
    return type
        .split('_')
        .map((word) => word.isNotEmpty
            ? '${word[0].toUpperCase()}${word.substring(1)}'
            : '')
        .join(' ');
  }

  // Helper to categorize actions
  String _getActionCategory(String type) {
    if (type.contains('click') || type.contains('tap')) return 'click';
    if (type.contains('add')) return 'add';
    if (type.contains('remove') || type.contains('delete')) return 'remove';
    if (type.contains('swipe') || type.contains('scroll')) return 'navigation';
    if (type.contains('search')) return 'search';
    if (type.contains('filter')) return 'filter';
    if (type.contains('share')) return 'share';
    if (type.contains('submit')) return 'submit';
    return 'action';
  }
}
