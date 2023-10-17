// ignore_for_file: require_trailing_commas, avoid_final_parameters

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:times_up_flutter/services/app_usage_local_service.dart';

part 'child_model.freezed.dart';
part 'child_model.g.dart';

@freezed
class ChildModel with _$ChildModel {
  // ignore: invalid_annotation_target
  @JsonSerializable(explicitToJson: true)
  const factory ChildModel({
    required final String id,
    required final String name,
    required final String email,
    required final String? image,
    final String? token,
    final String? batteryLevel,
    @Default(<AppUsageInfo>[])
    @AppUsageInfoConverter()
    List<AppUsageInfo> appsUsageModel,
    @GeoPointConverter() final GeoPoint? position,
  }) = _ChildModel;

  factory ChildModel.fromJson(Map<String, Object?> json) =>
      _$ChildModelFromJson(json);
}

class GeoPointConverter implements JsonConverter<GeoPoint?, GeoPoint?> {
  const GeoPointConverter();

  @override
  GeoPoint? fromJson(GeoPoint? geoPoint) {
    return geoPoint;
  }

  @override
  GeoPoint? toJson(GeoPoint? geoPoint) => geoPoint;
}

class AppUsageInfoConverter
    implements JsonConverter<AppUsageInfo, Map<String, dynamic>> {
  const AppUsageInfoConverter();

  @override
  AppUsageInfo fromJson(Map<String, dynamic> json) {
    return AppUsageInfo.fromMap(json);
  }

  @override
  Map<String, dynamic> toJson(AppUsageInfo appUsageInfo) {
    return appUsageInfo.toMap();
  }
}
