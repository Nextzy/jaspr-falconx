import 'package:jaspr/server.dart';
import 'package:jaspr_falconx/src/rendering/server_log_io_or_stub.dart';
import 'package:jaspr_falmodel/jaspr_falmodel.dart';

/// Loads data on the server and renders [builder] with it.
///
/// A failed load is written to the server log with [logServerError], sets
/// `cache-control: no-store` on the response so an error page is never
/// cached, then renders [errorBuilder]. `ServerData` sets no status code;
/// the error builder picks one.
class ServerData<T> extends StatelessComponent {
  /// Creates a server-side data loader.
  const ServerData({
    required this.load,
    required this.builder,
    required this.errorBuilder,
    super.key,
  });

  /// Loads the data.
  final Future<Result<T>> Function() load;

  /// Builds the content from loaded data.
  final Component Function(BuildContext context, T data) builder;

  /// Builds the content when [load] fails.
  final Component Function(BuildContext context, CommonException error)
  errorBuilder;

  @override
  Component build(BuildContext context) {
    return AsyncBuilder(
      builder: (context) async {
        final result = await load();
        if (result.isSuccess) {
          return builder(context, result.value);
        }
        final error = result.exception;
        logServerError(
          'ServerData<$T> load failed',
          error: error,
          stackTrace: error.stackTrace,
        );
        context.setHeader('cache-control', 'no-store');
        return errorBuilder(context, error);
      },
    );
  }
}
