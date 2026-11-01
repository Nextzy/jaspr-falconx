import 'package:jaspr_falconnect/jaspr_falconnect.dart';
import 'package:jaspr_falmodel/jaspr_falmodel.dart';

/// Base class for repositories: wraps a thrown error into a failed [Result].
///
/// A `DioException` becomes the `NetworkException` from `toException()`, a
/// `CommonException` becomes a [DataLayerException] with the same type, and
/// any other object becomes an unexpected [DataLayerException].
abstract class FalRepository {
  /// Runs [execute] and converts any thrown error into a failed [Result].
  Future<Result<T>> runDataCatching<T>(
    Future<Result<T>> Function() execute,
  ) async {
    try {
      return await execute();
    } on DioException catch (e) {
      return Result.failure(e.toException());
    } on DataLayerException catch (e) {
      return Result.failure(e);
    } on CommonException catch (e) {
      return Result.failure(
        DataLayerException(
          type: e.type,
          userMessage: e.userMessage,
          developerMessage: e.developerMessage,
          originalException: e.originalException,
          stackTrace: e.stackTrace,
        ),
      );
    } on Object catch (e, st) {
      return Result.failure(
        DataLayerException(
          type: SystemErrorType.unexpected,
          developerMessage: e.toString(),
          originalException: e,
          stackTrace: st,
        ),
      );
    }
  }
}
