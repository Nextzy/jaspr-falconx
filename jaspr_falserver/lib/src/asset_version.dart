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

/// Copies [base] with its client script path and its standalone stylesheet
/// path moved under the build version.
///
/// This copies every `ServerOptions` field one by one (jaspr 0.23: `clientId`,
/// `clients`, `stylesId`, `styles`). When jaspr adds a field, add it here too,
/// or the copy silently drops it.
ServerOptions versionedServerOptions(ServerOptions base, String? buildId) {
  final clientId = base.clientId;
  final stylesId = base.stylesId;
  return ServerOptions(
    clientId: clientId == null ? null : versionedPath(clientId, buildId),
    clients: base.clients,
    stylesId: stylesId == null ? null : versionedPath(stylesId, buildId),
    styles: base.styles,
  );
}
