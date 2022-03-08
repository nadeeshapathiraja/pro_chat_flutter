part of 'objects.dart';

@JsonSerializable(explicitToJson: true)
class UserModel {
  String uid;
  String name;
  String email;
  String lastseen;
  bool isOnline;
  String img;

  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.lastseen,
    required this.isOnline,
    required this.img,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
