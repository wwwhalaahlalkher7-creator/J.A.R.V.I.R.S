import '../api_client.dart';
import 'hermes_adapter.dart';
import 'memory_service.dart';

/// Small composition root for the JARVIS foundation.
///
/// The first milestone keeps runtime orchestration intentionally thin. The
/// existing Hermes session/streaming implementation remains intact while new
/// JARVIS capabilities are introduced behind stable interfaces.
class JarvisRuntime {
  final HermesAdapter agent;
  final MemoryService memory;

  JarvisRuntime({required ApiClient api, MemoryService? memory})
    : agent = HermesAdapter(api),
      memory = memory ?? EphemeralMemoryService();
}
