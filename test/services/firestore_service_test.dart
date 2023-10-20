import 'package:flutter_test/flutter_test.dart';
import 'package:times_up_flutter/services/app_usage_service.dart';

import '../helpers/test_helpers.mocks.dart';
import '../mocks.dart';

void main() {
  test('setChild', () async {
    final database = MockDatabase();
    await database.setChild(Dummy.childModel);
  });

  test('liveUpdateChild', () async {
    final database = MockDatabase();
    final usage = AppUsageService();

    await database.liveUpdateChild(Dummy.childModel, usage);
  });
}
