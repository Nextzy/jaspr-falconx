import 'package:jaspr/server.dart';
import 'package:jaspr_falmodel/jaspr_falmodel.dart';

/// Loads data on the server and renders [builder] with it.
///
/// A failed load sets `cache-control: no-store` on the response so an error
/// page is never cached, then renders [errorBuilder].
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
        context.setHeader('cache-control', 'no-store');
        return errorBuilder(context, result.exception);
      },
    );
  }
}
