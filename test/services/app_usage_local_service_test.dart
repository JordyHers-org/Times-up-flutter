import 'package:flutter_test/flutter_test.dart';

import '../helpers/test_helpers.mocks.dart';

void main() {
  late MockAppUsage mockAppUsage;
  setUp(() {
    mockAppUsage = MockAppUsage();
  });
  test('App Usage Local', () {
    expect(mockAppUsage, isInstanceOf<MockAppUsage>());
  });
}
