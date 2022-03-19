import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:pro_chat/components/custom_dialogbox.dart';
import 'package:pro_chat/controllers/chat/chat_controller.dart';
import 'package:pro_chat/models/objects.dart';
import 'package:pro_chat/providers/auth/auth_provider.dart';
import 'package:pro_chat/screens/main/chat/chat.dart';
import 'package:pro_chat/utils/util_functions.dart';
import 'package:provider/provider.dart';

class ChatProvider extends ChangeNotifier {
  final ChatController _chatController = ChatController();

  //Caht Creating loader
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  void setLoader(bool val) {
    _isLoading = val;
    notifyListeners();
  }

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
      //Start the loader
      setLoader(true);

      //get user model
      UserModel userModel =
          Provider.of<AuthProvider>(context, listen: false).userModel;

      //Create Conversation
      _conversationModel =
          await _chatController.createConversation(userModel, pureModel);
      notifyListeners();

      //Stop Loader
      setLoader(false);

      //Navigate to chat page
      UtilFunctions.navigateTo(context, Chat());
    } catch (e) {
      Logger().e(e);

      //Stop Loader
      setLoader(false);

      //error message
      DialogBox().dialogBox(context, DialogType.ERROR, "Error", '$e');
    }
  }
}
