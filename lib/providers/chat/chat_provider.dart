import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:pro_chat/controllers/chat/chat_controller.dart';
import 'package:pro_chat/models/objects.dart';
import 'package:pro_chat/providers/auth/auth_provider.dart';
import 'package:provider/provider.dart';

class ChatProvider extends ChangeNotifier {
  final ChatController _chatController = ChatController();

  //Create a Conversation
  Future<void> createConversation(
    UserModel pureModel,
  ) async {
    try {
      // UserModel model = Provider.of<AuthProvider>(context,listen: false).userModel
      // await _chatController.createConversation(user, pureModel);
    } catch (e) {
      Logger().e(e);
    }
  }
}
