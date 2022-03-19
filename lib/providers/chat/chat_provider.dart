import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:pro_chat/controllers/chat/chat_controller.dart';
import 'package:pro_chat/models/objects.dart';
import 'package:pro_chat/providers/auth/auth_provider.dart';
import 'package:pro_chat/screens/main/chat/chat.dart';
import 'package:pro_chat/utils/util_functions.dart';
import 'package:provider/provider.dart';

class ChatProvider extends ChangeNotifier {
  final ChatController _chatController = ChatController();

//conversational object returned from create conversation function
  late ConversationModel _conversationModel;

  ConversationModel get conv => _conversationModel;

  void setconv(ConversationModel model) {
    _conversationModel = model;
    notifyListeners();
  }

  //Create a Conversation
  Future<void> createConversation(
    BuildContext context,
    UserModel pureModel,
  ) async {
    try {
      //get user model
      UserModel userModel =
          Provider.of<AuthProvider>(context, listen: false).userModel;

      //Create Conversation
      _conversationModel =
          await _chatController.createConversation(userModel, pureModel);
      notifyListeners();

      //Navigate to chat page
      UtilFunctions.navigateTo(context, Chat());
    } catch (e) {
      Logger().e(e);
    }
  }
}
