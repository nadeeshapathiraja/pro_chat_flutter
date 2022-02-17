import 'package:flutter/material.dart';

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
      body: SizedBox(
        width: size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(
              Icons.chat,
              size: 100,
            ),
            SizedBox(height: 8),
            Text(
              "PRO CHAT",
              style: TextStyle(
                fontSize: 36,
                color: Color(0xff838383),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
