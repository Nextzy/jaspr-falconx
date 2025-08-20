import 'package:jaspr/jaspr.dart';
import 'package:jaspr_falstore/lib.dart';
import 'package:universal_web/web.dart' as web;

/// A singleton class that provides key-value storage functionality for web
/// applications.
/// 
/// This class wraps the browser's localStorage API and provides a simple
/// interface for storing, retrieving, and managing key-value pairs on the
/// client side.
/// 
/// Note: This storage is only available in web environments (when kIsWeb is
/// true).
class KeyValueStorage {
  const KeyValueStorage._singleton();

  static const KeyValueStorage instance = KeyValueStorage._singleton();

  /// Saves a value with the specified key to localStorage.
  /// 
  /// Returns true if the save was successful, false otherwise.
  /// Returns false if data is null or if not running in a web
  /// environment.
  bool save(String key, {required String? data}) {
    if (kIsWeb) {
      // Use on client only
      if (data == null) return false;
      web.window.localStorage.setItem(key, data);
      return true;
    } else {
      return false;
    }
  }

  /// Loads a value from localStorage for the specified key.
  /// 
  /// Returns null if the key doesn't exist or if not running in a web
  /// environment.
  String? load(String key) {
    if (kIsWeb) {
      // Use on client only
      return web.window.localStorage.getItem(key);
    }

    return null;
  }

  /// Loads a value from localStorage with a fallback default value.
  /// 
  /// If the key doesn't exist or the environment is not web,
  /// returns the provided defaultData.
  String loadSafe(
    String key, {
    required String defaultData,
  }) {
    if (kIsWeb) {
      // Use on client only
      return load(key) ?? defaultData;
    } else {
      return defaultData;
    }
  }

  /// Deletes a single key-value pair from localStorage.
  void delete({required String key}) {
    if (kIsWeb) {
      // Use on client only
      web.window.localStorage.removeItem(key);
    }
  }

  /// Clears all key-value pairs from localStorage.
  void deleteAll() {
    if (kIsWeb) {
      // Use on client only
      web.window.localStorage.clear();
    }
  }
}
