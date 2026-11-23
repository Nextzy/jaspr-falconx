import 'package:jaspr/jaspr.dart';
import 'package:jaspr_falconx/src/rendering/request_info.dart';
import 'package:jaspr_falmodel/jaspr_falmodel.dart';

/// Returns the HTTP status for a page whose data failed to load.
///
/// 404 when [error], or a [CommonException] in its `originalException` chain,
/// is a missing record: the CMS answered 403 (Directus, unknown id) or 404,
/// or the type is [BusinessErrorType.notFound]. 503 for every other failure
/// (5xx, timeout, network, unexpected), so crawlers retry.
int pageErrorStatus(CommonException error) =>
    _chain(error).any(_isMissingRecord) ? 404 : 503;

/// Sets the response status for [error] from [pageErrorStatus].
///
/// A 503 also gets `retry-after: 60`. Like [setResponseStatus], it does
/// nothing in the browser.
void applyPageErrorStatus(BuildContext context, CommonException error) {
  final status = pageErrorStatus(error);
  setResponseStatus(context, status);
  if (status == 503) setResponseHeader(context, 'retry-after', '60');
}

/// Returns whether [error] is a missing record, which logs one info line
/// instead of an error with a stack trace.
bool isExpectedPageFailure(CommonException error) =>
    pageErrorStatus(error) == 404;

const _maxChainDepth = 8;

/// Yields [error] and each [CommonException] it wraps, outermost first.
///
/// Stops at [_maxChainDepth] so a cyclic chain ends.
Iterable<CommonException> _chain(CommonException error) sync* {
  Object? current = error;
  for (var depth = 0; depth < _maxChainDepth; depth++) {
    if (current is! CommonException) return;
    yield current;
    current = current.originalException;
  }
}

bool _isMissingRecord(CommonException error) {
  final status = _cmsStatus(error);
  return status == 403 ||
      status == 404 ||
      error.type == BusinessErrorType.notFound;
}

/// Returns the status the CMS answered with, or null for a non-CMS failure.
int? _cmsStatus(CommonException error) {
  if (error is NetworkException) return error.statusCode;
  // `requiredResultData` rethrows a plain `CommonException` that keeps only
  // the type, so read the status from the type too.
  final type = error.type;
  return type is NetworkErrorType ? type.statusCode : null;
}
