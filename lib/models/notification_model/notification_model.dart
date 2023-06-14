// ignore_for_file: require_trailing_commas

import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification_model.freezed.dart';
part 'notification_model.g.dart';

@freezed
class NotificationModel with _$NotificationModel {
  // ignore: invalid_annotation_target
  @JsonSerializable(explicitToJson: true)
  const factory NotificationModel({
    required final String? title,
    required final String? body,
    required final String? message,
    required final String? id,
  }) = _NotificationModel;

  factory NotificationModel.fromJson(Map<String, Object?> json) =>
      _$NotificationModelFromJson(json);
}
