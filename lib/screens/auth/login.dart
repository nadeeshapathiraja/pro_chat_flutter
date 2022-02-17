import 'package:flutter/material.dart';
import 'package:pro_chat/components/custom_button.dart';
import 'package:pro_chat/providers/auth/auth_provider.dart';
import 'package:pro_chat/utils/app_colors.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: size.width,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.chat,
              size: 100,
            ),
            const SizedBox(height: 8),
            const Text(
              "PRO CHAT",
              style: TextStyle(
                fontSize: 36,
                color: Color(0xff838383),
              ),
            ),
            const SizedBox(height: 8),
            CustomButton(
              onTap: () {
                Provider.of<AuthProvider>(context, listen: false).googleAuth();
              },
              text: "SignIn with Google",
              fontColor: kwhite,
            )
          ],
        ),
      ),
    );
  }
}
