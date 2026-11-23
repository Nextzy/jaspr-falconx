/// Packages whose skills each package ships, keyed by the shipping package.
///
/// Mirrors each package's barrel re-exports; a test fails when they drift.
const Map<String, List<String>> shipMap = {
  'jaspr_falconx': [
    'jaspr_falconnect',
    'jaspr_falkit',
    'jaspr_falmodel',
    'jaspr_falmonitor',
    'jaspr_falstore',
    'jaspr_faltool',
  ],
  'jaspr_falconnect': ['dart_falconnect', 'jaspr_falmodel'],
  'jaspr_falmodel': ['dart_falmodel'],
  'jaspr_faltool': ['dart_faltool'],
  'jaspr_falkit': ['jaspr_falmodel'],
  'jaspr_falmonitor': [],
  'jaspr_falstore': [],
  'jaspr_falserver': [],
};

final _packageExport = RegExp(
  r'''^\s*export\s+['"]package:([a-z0-9_]+)/''',
  multiLine: true,
);

/// Returns the packages [barrelSource] re-exports that satisfy [isIncluded].
Set<String> barrelReexports(
  String barrelSource,
  bool Function(String package) isIncluded,
) => {
  for (final match in _packageExport.allMatches(barrelSource))
    if (isIncluded(match.group(1)!)) match.group(1)!,
};
