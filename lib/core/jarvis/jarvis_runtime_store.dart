import 'package:flutter/foundation.dart';

import '../stores/connection_store.dart';
import 'jarvis_runtime.dart';

/// Bridges the active connection to the JARVIS runtime without exposing
/// connection lifecycle details to product screens.
///
/// The store deliberately keeps the runtime nullable: JARVIS can be launched
/// before a backend is configured, while the UI can still present onboarding
/// and connection controls.
class JarvisRuntimeStore extends ChangeNotifier {
  ConnectionStore _connection;
  JarvisRuntime? _runtime;

  JarvisRuntimeStore(this._connection) {
    _connection.addListener(_sync);
    _sync();
  }

  ConnectionStore get connection => _connection;
  JarvisRuntime? get runtime => _runtime;
  bool get isReady => _runtime != null;
  String? get endpoint => _runtime?.agent.endpoint;

  void bindConnection(ConnectionStore connection) {
    if (identical(_connection, connection)) {
      _sync();
      return;
    }
    _connection.removeListener(_sync);
    _connection = connection;
    _connection.addListener(_sync);
    _sync();
  }

  void _sync() {
    final api = _connection.api;
    final next = api == null ? null : JarvisRuntime(api: api);
    final changed = (next == null) != (_runtime == null) ||
        (next?.agent.endpoint != _runtime?.agent.endpoint);
    _runtime = next;
    if (changed) notifyListeners();
  }

  @override
  void dispose() {
    _connection.removeListener(_sync);
    super.dispose();
  }
}
