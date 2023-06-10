import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import 'package:parental_control/models/child_model.dart';

class Dummy {
  static Position position = Position(
    longitude: 0.00,
    latitude: 0.00,
    timestamp: DateTime.now(),
    accuracy: 0.00,
    altitude: 0.00,
    heading: 0.00,
    speed: 0.00,
    speedAccuracy: 0.00,
  );

  static GeoPoint geoPoint = GeoPoint(
    0.00,
    0.00,
  );

  static final childModel = ChildModel(
    id: '001',
    name: 'name',
    email: 'email',
    image: 'image',
    token: 'token',
    position: Dummy.geoPoint,
    appsUsageModel: [],
  );
}
