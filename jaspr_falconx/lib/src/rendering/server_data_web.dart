import 'package:jaspr/jaspr.dart';
import 'package:jaspr_falmodel/jaspr_falmodel.dart';

/// Loads data on the server and renders [builder] with it.
///
/// Server only: building it in the browser throws [UnsupportedError].
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
    throw UnsupportedError('ServerData renders on the server only');
  }
}
