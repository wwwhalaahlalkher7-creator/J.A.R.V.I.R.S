import '../api_client.dart';

/// Boundary between JARVIS product code and Hermes-specific transport code.
///
/// Feature screens should depend on this boundary where practical instead of
/// constructing Hermes Mobile API clients themselves. This lets JARVIS keep
/// Hermes as the current agent engine while preserving the option to change
/// the transport/runtime later.
class HermesAdapter {
  final ApiClient api;

  const HermesAdapter(this.api);

  String get endpoint => api.baseUrl;
  bool get directGateway => api.directGateway;
  bool get supportsSessionSharing => api.supportsSessionSharing;
}
