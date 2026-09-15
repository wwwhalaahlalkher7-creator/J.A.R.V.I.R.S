import 'package:flutter_test/flutter_test.dart';

import '../lib/core/jarvis/jarvis_config.dart';
import '../lib/core/jarvis/memory_service.dart';

void main() {
  test('JARVIS identity is centralized', () {
    expect(JarvisConfig.productName, 'JARVIS');
    expect(JarvisConfig.productVersion, '0.1.0');
    expect(JarvisConfig.architecture, 'Flutter + Hermes Agent');
  });

  test('ephemeral memory stores and forgets values', () async {
    final memory = EphemeralMemoryService();
    await memory.remember(key: 'greeting', content: 'Hello');
    expect(await memory.recall('greeting'), 'Hello');
    await memory.forget('greeting');
    expect(await memory.recall('greeting'), isNull);
  });
}
