import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jarvis/l10n/l10n.dart';
import 'package:jarvis/l10n/runtime_l10n.dart';

void main() {
  testWidgets(
    'context.l10n falls back to English when localizations are missing',
    (tester) async {
      late AppLocalizations l10n;
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              l10n = context.l10n;
              return const SizedBox();
            },
          ),
        ),
      );

      expect(l10n.localeName, 'en');
      expect(identical(runtimeL10n, l10n), isTrue);
    },
  );
}
