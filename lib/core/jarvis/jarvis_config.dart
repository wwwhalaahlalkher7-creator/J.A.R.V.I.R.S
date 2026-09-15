/// JARVIS application identity and architecture-level defaults.
///
/// Keep product identity here instead of scattering it through feature code.
/// Hermes remains an implementation detail of the agent runtime.
class JarvisConfig {
  static const productName = 'JARVIS';
  static const productVersion = '0.2.0';
  static const agentName = 'Hermes Agent';
  static const productTagline = 'Personal AI assistant';
  static const architecture = 'Flutter + Hermes Agent';
  static const defaultServerPort = 9001;
  static const localHost = '127.0.0.1';

  const JarvisConfig._();
}
