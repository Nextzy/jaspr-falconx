import 'dart:convert';

import 'package:jaspr/jaspr.dart' show kIsWeb;
import 'package:jaspr_falconx/src/states/json_codec.dart';
import 'package:jaspr_riverpod/jaspr_riverpod.dart';
import 'package:jaspr_riverpod/misc.dart';

/// Bundles the three pieces needed for a hydrated, auto-disposed, keyed data
/// fetch into one declaration:
///   - `FutureProvider.autoDispose.family<T?, K>` (the Riverpod machinery,
///     including per-request disposal that bounds memory)
///   - `syncWith(id, codec)` (the `jaspr_riverpod` hydration bridge that
///     ships the server-fetched value to the client without a second fetch)
///   - JSON codec (the on-the-wire encoding)
///
/// Replaces the previous `PreloadComponentNotifier` + `ControllerXxxRegistry`
/// pair. Riverpod's family caching + `autoDispose` makes the process-wide
/// registry obsolete.
///
/// Usage:
/// ```dart
/// final projectDetail = PreloadFamily<Project?, ({String id, String locale})>(
///   fetch: (key) async {
///     final r = await GetProjectDetailUsecase()(
///       id: key.id, languageCode: key.locale);
///     return r.when((p) => p, (e, _) => throw e);
///   },
///   fromJson: Project.fromDynamic,
///   keyToString: (k) => 'project-${k.id}-${k.locale}',
/// );
///
/// // In *RootSyncs (registered in ProviderScope.sync):
/// projectDetail.syncFor((id: id, locale: locale))
///
/// // In page:
/// final async = ref.watch(projectDetail.provider((id: id, locale: locale)));
/// ```
class PreloadFamily<T, K> {
  PreloadFamily({
    required Future<T?> Function(K key) fetch,
    required T Function(dynamic json) fromJson,
    required String Function(K key) keyToString,
  }) : provider = FutureProvider.autoDispose.family<T?, K>((ref, key) {
         // On the server, pin the element so it survives the gap between
         // `_preloadSyncProviders`' one-shot `read(provider.future)` and
         // the page's `context.watch`. Without this, autoDispose collects
         // the element after the read returns; the page then mounts a
         // fresh element that re-issues the fetch, renders
         // `AsyncValue.loading`, and — when the second fetch finally
         // resolves — calls `markNeedsBuild` on the server binding,
         // throwing "Scheduling a frame is not supported on the server".
         // The per-request `ProviderContainer` is disposed when the SSR
         // tree unmounts, so server-side keepAlive is bounded.
         if (!kIsWeb) ref.keepAlive();
         return fetch(key);
       }),
       _codec = jsonCodec<T>(fromJson),
       _keyToString = keyToString;

  /// The underlying Riverpod family. Pages call `ref.watch(provider(key))`.
  final FutureProviderFamily<T?, K> provider;
  final Codec<T?, Object?> _codec;
  final String Function(K) _keyToString;

  /// Returns the [ProviderSync] to register in `ProviderScope.sync` so that
  /// the value fetched on the server is hydrated to the client without a
  /// second fetch.
  ProviderSync syncFor(K key) =>
      provider(key).syncWith(_keyToString(key), codec: _codec);
}

/// List variant of [PreloadFamily] for providers that return `List<T>`.
/// Empty list (not null) represents absent data.
class PreloadListFamily<T, K> {
  PreloadListFamily({
    required Future<List<T>> Function(K key) fetch,
    required T Function(dynamic json) fromJson,
    required String Function(K key) keyToString,
  }) : provider = FutureProvider.autoDispose.family<List<T>, K>((ref, key) {
         // See `PreloadFamily` for why server-side autoDispose must be
         // pinned during SSR.
         if (!kIsWeb) ref.keepAlive();
         return fetch(key);
       }),
       _codec = jsonListCodec<T>(fromJson),
       _keyToString = keyToString;

  final FutureProviderFamily<List<T>, K> provider;
  final Codec<List<T>, Object?> _codec;
  final String Function(K) _keyToString;

  ProviderSync syncFor(K key) =>
      provider(key).syncWith(_keyToString(key), codec: _codec);
}
