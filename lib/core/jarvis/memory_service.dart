/// Memory abstraction for JARVIS.
///
/// V0.1 deliberately has no vector-database dependency. Hermes Agent can
/// provide agent memory, while this boundary leaves room for SQLite and an
/// optional ChromaDB adapter later without coupling the UI to either choice.
abstract interface class MemoryService {
  Future<void> remember({required String key, required String content});
  Future<String?> recall(String key);
  Future<void> forget(String key);
}

/// Small deterministic implementation used by the foundation layer and tests.
/// It is intentionally not presented as durable memory.
class EphemeralMemoryService implements MemoryService {
  final Map<String, String> _items = <String, String>{};

  @override
  Future<void> remember({required String key, required String content}) async {
    final normalized = key.trim();
    if (normalized.isEmpty) return;
    _items[normalized] = content;
  }

  @override
  Future<String?> recall(String key) async => _items[key.trim()];

  @override
  Future<void> forget(String key) async => _items.remove(key.trim());
}
