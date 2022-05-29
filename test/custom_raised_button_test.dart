import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:parental_control/common_widgets/custom_raised_button.dart';

void main() {
  /// This syntax is used to test widgets
  ///
  /// we use it to build and interact in a test environment
  ///
  testWidgets('onPressed callback', (WidgetTester tester) async {
    var pressed = false;

    /// pumpWidget is always called for the widget we want to build
    ///don't forget to surround it with a [Material Widget]
    await tester.pumpWidget(MaterialApp(
        home: CustomRaisedButton(
      child: Text('tap me'),
      onPressed: () => pressed = true,
    )));

    ///This code tries to find if in CustomRaisedButton there is a RaisedButton
    final button = find.byType(RaisedButton);

    ///we use it a finder which finds fromType
    expect(button, findsOneWidget);

    ///findsNothing is used to check if no widget are found
    expect(find.byType(FlatButton), findsNothing);

    ///here we try to find if a widget text holds tap me as value
    expect(find.text('tap me'), findsOneWidget);

    /// always use await keyword we check if the button
    /// works well. Here we send a tap event to trigger the button
    await tester.tap(button);
    expect(pressed, true);
  });
}
