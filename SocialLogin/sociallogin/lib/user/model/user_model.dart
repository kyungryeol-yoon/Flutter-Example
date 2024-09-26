import 'package:json_annotation/json_annotation.dart';
import 'package:sociallogin/common/utils/data_utils.dart';

part 'user_model.g.dart';

abstract class UserModelBase {}

class UserModelError extends UserModelBase {
  final String message;

  UserModelError({
    required this.message,
  });
}

class UserModelLoading extends UserModelBase {}

@JsonSerializable()
class UserModel extends UserModelBase {
  final String userId;
  final String name;
  @JsonKey(
    fromJson: DataUtils.pathToUrl,
  )
  final String profile;

  UserModel({
    required this.userId,
    required this.name,
    required this.profile,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}
