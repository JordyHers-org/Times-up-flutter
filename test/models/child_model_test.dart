import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:parental_control/models/child_model.dart';
import 'package:parental_control/services/app_usage_local_service.dart';

import '../mocks.dart';

void main() {
  test('ChildModel Constructor', () {
    // Test values
    const id = '0001';
    const name = 'John Doe';
    const email = 'john.doe@example.com';
    const String? image = 'image.png';
    const String? token = 'token123';
    final GeoPoint? position = Dummy.geoPoint;
    final appsUsageModel = <AppUsageInfo>[
      AppUsageInfo(
        'App 1',
        2000,
        DateTime(2024, 05, 09),
        DateTime(2024, 05, 19),
      ),
      AppUsageInfo(
        'App 2',
        3000,
        DateTime(2024, 05, 19),
        DateTime(2024, 05, 29),
      ),
    ];

    // Create the ChildModel instance
    final childModel = ChildModel(
      id: id,
      name: name,
      email: email,
      image: image,
      token: token,
      position: position,
      appsUsageModel: appsUsageModel,
    );

    // Verify the values
    expect(childModel.id, id);
    expect(childModel.name, name);
    expect(childModel.email, email);
    expect(childModel.image, image);
    expect(childModel.token, token);
    expect(childModel.position, position);
    expect(childModel.appsUsageModel, appsUsageModel);
  });
}
