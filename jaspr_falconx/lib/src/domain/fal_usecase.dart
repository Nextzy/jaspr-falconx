import 'package:jaspr_falconnect/jaspr_falconnect.dart';
import 'package:jaspr_falmodel/jaspr_falmodel.dart';

/// Base class for use cases: wraps failures into [Result] and unwraps
/// required data.
abstract class FalUsecase {
  /// Runs [execute] and converts any thrown error into a failed [Result].
  Future<Result<T>> runDomainCatching<T>(
    Future<Result<T>> Function() execute,
  ) async {
    try {
      return await execute();
    } on DioException catch (e) {
      return Result.failure(e.toException());
    } on CommonException catch (e) {
      return Result.failure(e);
    } on Exception catch (e, st) {
      return Result.failure(
        DomainLayerException(
          type: SystemErrorType.unexpected,
          originalException: e,
          stackTrace: st,
        ),
      );
    } on Object catch (e, st) {
      return Result.failure(
        DomainLayerException(
          type: SystemErrorType.unexpected,
          originalException: e,
          stackTrace: st,
        ),
      );
    }
  }

  /// Awaits [result] and returns its data through [requiredResultData].
  Future<T> requiredFutureResultData<T>(
    Future<Result<T?>> result, {
    Object? type,
    bool Function(T value)? validator,
    String? languageCode,
    String? userMessage,
    String? developerMessage,
  }) async {
    final value = await result;
    final data = requiredResultData(
      value,
      type: type,
      validator: validator,
      languageCode: languageCode,
      userMessage: userMessage,
      developerMessage: developerMessage,
    );
    return data;
  }

  /// Returns the data of [result], or throws a [CommonException] when it
  /// failed, is null, or fails [validator].
  T requiredResultData<T>(
    Result<T?> result, {
    Object? type,
    bool Function(T value)? validator,
    String? languageCode,
    String? userMessage,
    String? developerMessage,
  }) {
    return result.resolve(
      (value) {
        if (value == null || (validator != null && !validator(value))) {
          final resolveType = type ?? SystemErrorType.unexpected;

          throw DomainLayerException(
            type: resolveType,
            userMessage:
                userMessage ??
                mapUserMessage(type: type, languageCode: languageCode),
            developerMessage: developerMessage,
          );
        }
        return value;
      },
      (exception, stackTrace) {
        throw exception.copyWith(
          type: type,
          userMessage:
              userMessage ??
              exception.userMessage ??
              mapUserMessage(type: type, languageCode: languageCode),
          developerMessage: developerMessage,
        );
      },
    );
  }

  /// Maps an error [type] to a user-facing message in [languageCode].
  ///
  /// Returns null by default; override to supply app translations.
  String? mapUserMessage({
    required Object? type,
    required String? languageCode,
  }) => null;
}
