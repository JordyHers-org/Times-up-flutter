import 'package:flutter_test/flutter_test.dart';

import '../helpers/test_helpers.mocks.dart';
import '../mocks.dart';

void main() {
  test('setChild', () async {
    final database = MockDatabase();
    // Replace with your ChildModel instance
    await database.setChild(Dummy.childModel);
  });

  test('liveUpdateChild', () async {
    final database = MockDatabase();
    // Replace with your ChildModel instance
    const tick = 5; // Replace with your tick value

    await database.liveUpdateChild(Dummy.childModel, tick);
  });
}
