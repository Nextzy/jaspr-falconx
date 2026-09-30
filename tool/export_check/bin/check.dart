import 'dart:io';

import 'package:export_check/export_check.dart';

/// A workspace member; its package config resolves every package in this
/// repository, every `dart:` library, and jaspr.
const _workspace = '../../jaspr_falconx';

const List<LibraryRef> _subjects = [
  (uri: 'package:jaspr_falconx/jaspr_falconx.dart', root: _workspace),
  (uri: 'package:jaspr_falconnect/lib.dart', root: _workspace),
  (uri: 'package:jaspr_falkit/lib.dart', root: _workspace),
  (uri: 'package:jaspr_faltool/lib.dart', root: _workspace),
];

const List<LibraryRef> _targets = [
  (uri: 'dart:async', root: _workspace),
  (uri: 'dart:collection', root: _workspace),
  (uri: 'dart:convert', root: _workspace),
  (uri: 'dart:core', root: _workspace),
  (uri: 'dart:developer', root: _workspace),
  (uri: 'dart:ffi', root: _workspace),
  (uri: 'dart:io', root: _workspace),
  (uri: 'dart:isolate', root: _workspace),
  (uri: 'dart:js_interop', root: _workspace),
  (uri: 'dart:js_interop_unsafe', root: _workspace),
  (uri: 'dart:math', root: _workspace),
  (uri: 'dart:typed_data', root: _workspace),
  (uri: 'package:jaspr/client.dart', root: _workspace),
  (uri: 'package:jaspr/dom.dart', root: _workspace),
  (uri: 'package:jaspr/jaspr.dart', root: _workspace),
  (uri: 'package:jaspr/server.dart', root: _workspace),
];

/// jaspr, its router, and riverpod own these declarations; their collisions
/// with `dart:` libraries, such as riverpod's `AsyncError`, are theirs.
const _frameworkOwned = [
  'package:jaspr/',
  'package:jaspr_router/',
  'package:jaspr_riverpod/',
  'package:riverpod/',
];

const _shelfResponse =
    "dio's Response; it collides with shelf's from jaspr/server.dart, which "
    'no barrel exports, so server code hides it at the import.';
const _retrofitHttpResponse =
    "Retrofit's HttpResponse; code that Retrofit generates for a method "
    'returning HttpResponse<T> needs it.';

const Map<AllowlistKey, String> _allowlist = {
  (subject: 'package:jaspr_falconx/jaspr_falconx.dart', name: 'Response'):
      _shelfResponse,
  (subject: 'package:jaspr_falconnect/lib.dart', name: 'Response'):
      _shelfResponse,
  (subject: 'package:jaspr_falconx/jaspr_falconx.dart', name: 'HttpResponse'):
      _retrofitHttpResponse,
  (subject: 'package:jaspr_falconnect/lib.dart', name: 'HttpResponse'):
      _retrofitHttpResponse,
};

Future<void> main() async {
  exitCode = await runCheck(
    subjects: _subjects,
    targets: _targets,
    allowlist: _allowlist,
    frameworkOwned: _frameworkOwned,
  );
}
