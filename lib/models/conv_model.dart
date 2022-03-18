part of 'objects.dart';

@JsonSerializable(explicitToJson: true)
class ConversationModel {
  final String id;
  final List users;
  final List<UserModel> userArray;
  final String lastMessage;
  final String lastMessageTime;
  final String createdBy;

  ConversationModel({
    required this.id,
    required this.users,
    required this.userArray,
    required this.lastMessage,
    required this.lastMessageTime,
    required this.createdBy,
  });

  factory ConversationModel.fromJson(Map<String, dynamic> json) =>
      _$ConversationModelFromJson(json);

  Map<String, dynamic> toJson() => _$ConversationModelToJson(this);
}
