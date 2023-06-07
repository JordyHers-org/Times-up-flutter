import 'package:flutter_test/flutter_test.dart';
import 'package:parental_control/models/set_child_model.dart';

void main() {
  test('SetChildModel Constructor', () {
    // Test values
    const name = 'John Doe';
    const email = 'john.doe@example.com';

    // Create the SetChildModel instance
    final setChildModel = SetChildModel(
      name: name,
      email: email,
    );

    // Verify the values
    expect(setChildModel.name, name);
    expect(setChildModel.email, email);
  });
}
