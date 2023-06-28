// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'child_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ChildModel _$$_ChildModelFromJson(Map<String, dynamic> json) =>
    _$_ChildModel(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      image: json['image'] as String?,
      token: json['token'] as String?,
      appsUsageModel: (json['appsUsageModel'] as List<dynamic>?)
              ?.map((e) => const AppUsageInfoConverter()
                  .fromJson(e as Map<String, dynamic>),)
              .toList() ??
          const <AppUsageInfo>[],
      position:
          const GeoPointConverter().fromJson(json['position'] as GeoPoint?),
    );

Map<String, dynamic> _$$_ChildModelToJson(_$_ChildModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'image': instance.image,
      'token': instance.token,
      'appsUsageModel': instance.appsUsageModel
          .map(const AppUsageInfoConverter().toJson)
          .toList(),
      'position': const GeoPointConverter().toJson(instance.position),
    };
