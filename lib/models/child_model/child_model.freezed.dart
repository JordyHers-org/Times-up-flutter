// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'child_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ChildModel _$ChildModelFromJson(Map<String, dynamic> json) {
  return _ChildModel.fromJson(json);
}

/// @nodoc
mixin _$ChildModel {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String? get image => throw _privateConstructorUsedError;
  String? get token => throw _privateConstructorUsedError;
  String? get batteryLevel => throw _privateConstructorUsedError;
  @AppUsageInfoConverter()
  List<AppUsageInfo> get appsUsageModel => throw _privateConstructorUsedError;
  @GeoPointConverter()
  GeoPoint? get position => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ChildModelCopyWith<ChildModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChildModelCopyWith<$Res> {
  factory $ChildModelCopyWith(
          ChildModel value, $Res Function(ChildModel) then) =
      _$ChildModelCopyWithImpl<$Res, ChildModel>;
  @useResult
  $Res call(
      {String id,
      String name,
      String email,
      String? image,
      String? token,
      String? batteryLevel,
      @AppUsageInfoConverter() List<AppUsageInfo> appsUsageModel,
      @GeoPointConverter() GeoPoint? position});
}

/// @nodoc
class _$ChildModelCopyWithImpl<$Res, $Val extends ChildModel>
    implements $ChildModelCopyWith<$Res> {
  _$ChildModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? email = null,
    Object? image = freezed,
    Object? token = freezed,
    Object? batteryLevel = freezed,
    Object? appsUsageModel = null,
    Object? position = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
      token: freezed == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String?,
      batteryLevel: freezed == batteryLevel
          ? _value.batteryLevel
          : batteryLevel // ignore: cast_nullable_to_non_nullable
              as String?,
      appsUsageModel: null == appsUsageModel
          ? _value.appsUsageModel
          : appsUsageModel // ignore: cast_nullable_to_non_nullable
              as List<AppUsageInfo>,
      position: freezed == position
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as GeoPoint?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ChildModelCopyWith<$Res>
    implements $ChildModelCopyWith<$Res> {
  factory _$$_ChildModelCopyWith(
          _$_ChildModel value, $Res Function(_$_ChildModel) then) =
      __$$_ChildModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String email,
      String? image,
      String? token,
      String? batteryLevel,
      @AppUsageInfoConverter() List<AppUsageInfo> appsUsageModel,
      @GeoPointConverter() GeoPoint? position});
}

/// @nodoc
class __$$_ChildModelCopyWithImpl<$Res>
    extends _$ChildModelCopyWithImpl<$Res, _$_ChildModel>
    implements _$$_ChildModelCopyWith<$Res> {
  __$$_ChildModelCopyWithImpl(
      _$_ChildModel _value, $Res Function(_$_ChildModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? email = null,
    Object? image = freezed,
    Object? token = freezed,
    Object? batteryLevel = freezed,
    Object? appsUsageModel = null,
    Object? position = freezed,
  }) {
    return _then(_$_ChildModel(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
      token: freezed == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String?,
      batteryLevel: freezed == batteryLevel
          ? _value.batteryLevel
          : batteryLevel // ignore: cast_nullable_to_non_nullable
              as String?,
      appsUsageModel: null == appsUsageModel
          ? _value._appsUsageModel
          : appsUsageModel // ignore: cast_nullable_to_non_nullable
              as List<AppUsageInfo>,
      position: freezed == position
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as GeoPoint?,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$_ChildModel implements _ChildModel {
  const _$_ChildModel(
      {required this.id,
      required this.name,
      required this.email,
      required this.image,
      this.token,
      this.batteryLevel,
      @AppUsageInfoConverter()
      final List<AppUsageInfo> appsUsageModel = const <AppUsageInfo>[],
      @GeoPointConverter() this.position})
      : _appsUsageModel = appsUsageModel;

  factory _$_ChildModel.fromJson(Map<String, dynamic> json) =>
      _$$_ChildModelFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String email;
  @override
  final String? image;
  @override
  final String? token;
  @override
  final String? batteryLevel;
  final List<AppUsageInfo> _appsUsageModel;
  @override
  @JsonKey()
  @AppUsageInfoConverter()
  List<AppUsageInfo> get appsUsageModel {
    if (_appsUsageModel is EqualUnmodifiableListView) return _appsUsageModel;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_appsUsageModel);
  }

  @override
  @GeoPointConverter()
  final GeoPoint? position;

  @override
  String toString() {
    return 'ChildModel(id: $id, name: $name, email: $email, image: $image, token: $token, batteryLevel: $batteryLevel, appsUsageModel: $appsUsageModel, position: $position)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ChildModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.image, image) || other.image == image) &&
            (identical(other.token, token) || other.token == token) &&
            (identical(other.batteryLevel, batteryLevel) ||
                other.batteryLevel == batteryLevel) &&
            const DeepCollectionEquality()
                .equals(other._appsUsageModel, _appsUsageModel) &&
            (identical(other.position, position) ||
                other.position == position));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      email,
      image,
      token,
      batteryLevel,
      const DeepCollectionEquality().hash(_appsUsageModel),
      position);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ChildModelCopyWith<_$_ChildModel> get copyWith =>
      __$$_ChildModelCopyWithImpl<_$_ChildModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ChildModelToJson(
      this,
    );
  }
}

abstract class _ChildModel implements ChildModel {
  const factory _ChildModel(
      {required final String id,
      required final String name,
      required final String email,
      required final String? image,
      final String? token,
      final String? batteryLevel,
      @AppUsageInfoConverter() final List<AppUsageInfo> appsUsageModel,
      @GeoPointConverter() final GeoPoint? position}) = _$_ChildModel;

  factory _ChildModel.fromJson(Map<String, dynamic> json) =
      _$_ChildModel.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get email;
  @override
  String? get image;
  @override
  String? get token;
  @override
  String? get batteryLevel;
  @override
  @AppUsageInfoConverter()
  List<AppUsageInfo> get appsUsageModel;
  @override
  @GeoPointConverter()
  GeoPoint? get position;
  @override
  @JsonKey(ignore: true)
  _$$_ChildModelCopyWith<_$_ChildModel> get copyWith =>
      throw _privateConstructorUsedError;
}
