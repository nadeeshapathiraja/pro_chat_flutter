import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';
import 'package:pro_chat/models/objects.dart';

class ChatController {
  //Create firestore Instance
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  //Create a collecion Reference
  CollectionReference conversation =
      FirebaseFirestore.instance.collection('conversation');

//Create a Conversation
  Future<ConversationModel> createConversation(
      UserModel user, UserModel pureUser) async {
    //Generate Random id
    String docId = conversation.doc().id;
    await conversation
        .doc(docId)
        .set({
          'id': docId,
          'users': [user.uid, pureUser.uid],
          'userArray': [user.toJson(), pureUser.toJson()],
          'lastMessage': "Started a Conversation",
          'lastMessageTime': DateTime.now().toString(),
          'createdBy': user.uid,
          'createdAt': DateTime.now(),
        })
        .then((value) => Logger().i("User Added"))
        .catchError((error) => Logger().e("Failed to add user: $error"));

    //get firebase cloud data
    DocumentSnapshot snapshot = await conversation.doc(docId).get();

    return ConversationModel.fromJson(snapshot.data() as Map<String, dynamic>);
  }

//Ret rive converstaions
  Stream<QuerySnapshot> getconversation(String uid) => conversation
      .orderBy('createdAt', descending: true)
      .where('users', arrayContainsAny: [uid]).snapshots();
}
