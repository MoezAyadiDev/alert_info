import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'helpers_widgets.dart';

void main() async {
  testWidgets(
    'Display info',
    (WidgetTester tester) async {
      await tester.pumpWidget(AlertHelperTest.infoWidget);

      final actionButton = find.text('Display alert');

      expect(actionButton, findsOneWidget);

      await tester.tap(actionButton);
      await tester.pump(const Duration(seconds: 1));

      final alerteText = find.text('Test alert info');

      expect(alerteText, findsOneWidget);

      final iconInfo = find.byIcon(Icons.error_outline);
      final iconWarning = find.byIcon(Icons.warning_amber_rounded);
      final iconSuccess = find.byIcon(Icons.check_circle_outline);
      final iconError = find.byIcon(Icons.help_outline);

      expect(iconInfo, findsOneWidget);
      expect(iconWarning, findsNothing);
      expect(iconSuccess, findsNothing);
      expect(iconError, findsNothing);
    },
  );
  // await Future.delayed(const Duration(seconds: 3));
}
