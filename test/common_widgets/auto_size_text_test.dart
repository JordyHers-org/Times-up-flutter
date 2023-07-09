import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:times_up_flutter/common_widgets/jh_display_text.dart';

import '../helpers/test_helpers.dart';

void main() {
  testWidgets('AutoSizeText', (widgetTester) async {
    const expectedText = 'Hello, world!';
    const expectedFontSize = 20.0;
    const expectedColor = Colors.blue;

    const child = JHDisplayText(
      text: expectedText,
      style: TextStyle(fontSize: expectedFontSize, color: expectedColor),
    );
    await Helper.launch(child, widgetTester);

    final textFinder = find.text(expectedText);
    expect(textFinder, findsOneWidget);

    final textWidget = widgetTester.widget<Text>(textFinder);
    expect(textWidget.style!.fontSize, equals(expectedFontSize));
    expect(textWidget.style!.color, equals(expectedColor));
  });
}
