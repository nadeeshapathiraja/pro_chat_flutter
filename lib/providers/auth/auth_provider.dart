import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:pro_chat/controllers/auth/auth_controller.dart';
import 'package:pro_chat/controllers/auth/user_controller.dart';
import 'package:pro_chat/models/objects.dart';
import 'package:pro_chat/screens/auth/login.dart';
import 'package:pro_chat/screens/main/main_screen.dart';
import 'package:pro_chat/utils/util_functions.dart';

class AuthProvider extends ChangeNotifier {
  final AuthController _authController = AuthController();

  final UserController _userController = UserController();

  //create User credential object
  late UserCredential _userCredential;

//For get user data
  late User _user;

//Returning firebase user  objects
  User get user => _user;

  //For get user Model
  late UserModel _userModel;

//Returning firebase user  objects
  UserModel get userModel => _userModel;

//Google signing function
  Future<void> googleAuth() async {
    try {
      _userCredential = await _authController.signInWithGoogle();
      _user = _userCredential.user!;

      //Save userdata in cloud firestore
      await _userController.saveUserInformation(UserModel(
        uid: _user.uid,
        name: _user.displayName!,
        email: _user.email!,
        lastseen: DateTime.now().toString(),
        isOnline: true,
        img: _user.photoURL!,
      ));

      Logger().i(_userCredential);
      notifyListeners();
    } catch (e) {
      Logger().e(e);
    }
  }

  //Fetch Single user data
  Future<void> fetchSingleUser() async {
    try {
      _userModel = (await _userController.getUserData(_user.uid))!;
      notifyListeners();
    } catch (e) {
      Logger().e(e);
    }
  }

  //Initialize user function
  Future<void> initializedUser(BuildContext context) async {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        Logger().w('User is currently signed out!');
        UtilFunctions.navigateTo(context, const LoginScreen());
      } else {
        Logger().d({'User is signed in!': user});
        _user = user;
        notifyListeners();
        UtilFunctions.navigateTo(context, const MainScreen());
      }
    });
  }

  //Google logout function
  Future<void> logout() async {
    try {
      await _authController.logOut();
    } catch (e) {
      Logger().e(e);
    }
  }
}
