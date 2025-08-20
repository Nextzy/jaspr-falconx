import 'package:jaspr_faltool/lib.dart';

class BuildConfig {
  static bool get debug => !kReleaseMode;

  static bool get release => kReleaseMode;
}
