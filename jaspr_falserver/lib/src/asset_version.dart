import 'package:jaspr/server.dart';

/// First path segment that marks a build-versioned asset.
const String kVersionPrefix = '_v';

/// Returns [path] under `_v/<buildId>/`, or [path] unchanged when [buildId] is
/// null or empty. One leading `/` is dropped.
String versionedPath(String path, String? buildId) {
  final clean = path.startsWith('/') ? path.substring(1) : path;
  if (buildId == null || buildId.isEmpty) return clean;
  return '$kVersionPrefix/$buildId/$clean';
}

/// Splits `_v/<id>/<rest>` into its id and rest, or returns null when [path]
/// is not a versioned path. A leading `/` is accepted.
({String id, String rest})? splitVersion(String path) {
  final clean = path.startsWith('/') ? path.substring(1) : path;
  final segments = clean.split('/');
  if (segments.length < 3 || segments.first != kVersionPrefix) return null;
  final id = segments[1];
  final rest = segments.sublist(2).join('/');
  if (id.isEmpty || rest.isEmpty) return null;
  return (id: id, rest: rest);
}

/// Copies [base] with its client script path moved under the build version.
ServerOptions versionedServerOptions(ServerOptions base, String? buildId) {
  final clientId = base.clientId;
  return ServerOptions(
    clientId: clientId == null ? null : versionedPath(clientId, buildId),
    clients: base.clients,
    stylesId: base.stylesId,
    styles: base.styles,
  );
}
