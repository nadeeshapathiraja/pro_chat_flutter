import 'package:flutter/material.dart';
import 'package:pro_chat/screens/main/main_screen.dart';
import 'package:pro_chat/utils/util_functions.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      UtilFunctions.navigateTo(context, const MainScreen());
    });
  }

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
