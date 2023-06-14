import 'package:flutter_test/flutter_test.dart';
import 'package:parental_control/common_widgets/jh_empty_content.dart';

import '../helpers/test_helpers.dart';

void main() {
  testWidgets('Empty Content', (widgetTester) async {
    const expectedText = 'Title';
    const expectedMessage = 'Here is the message ';

    final child = JHEmptyContent(
      title: expectedText,
      message: expectedMessage,
    );
    await Helper.launch(child, widgetTester);

    final title = find.text(expectedText);
    final message = find.text(expectedText);

    expect(title, findsOneWidget);
    expect(message, findsOneWidget);
  });
}
