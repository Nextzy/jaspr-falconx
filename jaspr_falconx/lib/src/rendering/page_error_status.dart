import 'package:jaspr_falmodel/jaspr_falmodel.dart';

/// Returns the HTTP status for a page whose data failed to load.
///
/// 404 when the CMS answered 403 (Directus, unknown id) or 404; 503 for every
/// other failure (5xx, timeout, network, unexpected), so crawlers retry.
int pageErrorStatus(CommonException error) {
  final status = _cmsStatus(error);
  return status == 403 || status == 404 ? 404 : 503;
}

/// Returns whether [error] is a missing record, which logs one info line
/// instead of an error with a stack trace.
bool isExpectedPageFailure(CommonException error) =>
    pageErrorStatus(error) == 404;

/// Returns the status the CMS answered with, or null for a non-CMS failure.
int? _cmsStatus(CommonException error) {
  if (error is NetworkException) return error.statusCode;
  // `requiredResultData` rethrows a plain `CommonException` that keeps only
  // the type, so read the status from the type too.
  final type = error.type;
  return type is NetworkErrorType ? type.statusCode : null;
}
