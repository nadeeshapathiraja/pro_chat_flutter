import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';
import 'package:pro_chat/models/objects.dart';

class UserController {
  //Create firestore Instance
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  //Create a collecion Reference
  CollectionReference users = FirebaseFirestore.instance.collection('users');

//Save user Information
  Future<void> saveUserInformation(UserModel userModel) {
    return users
        .doc(userModel.uid)
        .set({userModel.toJson()})
        .then(
          (value) => Logger().i("User Added"),
        )
        .catchError(
          (error) => Logger().e("Failed to add user"),
        );
  }

//get login user data
  Future<UserModel?> getUserData(String id) async {
    try {
      DocumentSnapshot snapshot = await users.doc(id).get();
      Logger().i(snapshot.data());

      UserModel userModel =
          UserModel.fromJson(snapshot.data() as Map<String, dynamic>);
      Logger().d(userModel.name);

      return userModel;
    } catch (e) {
      Logger().e(e);
    }
  }
}
