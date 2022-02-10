import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:pro_chat/components/custom_images.dart';
import 'package:pro_chat/components/custom_text.dart';
import 'package:pro_chat/screens/main/home/home.dart';
import 'package:pro_chat/screens/main/users/users_list.dart';
import 'package:pro_chat/utils/app_colors.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  final List<Widget> _screens = const [Home(), Users()];

  Future<bool> initBackButton() async {
    return await showDialog(
      context: context,
      builder: (context) => ElasticIn(
        child: AlertDialog(
          title: const CustomText(text: "Exit App"),
          content: const CustomText(text: "Do you really ant to exit an app"),
          actions: [
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const CustomText(text: "No"),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const CustomText(text: "Yes"),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: initBackButton,
      child: Scaffold(
        body: _screens.elementAt(_currentIndex),
        bottomNavigationBar: Container(
          height: 90.0,
          color: kwhite,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              BottomNavbarTile(
                svgName: "conversations",
                isSelected: _currentIndex == 0,
                ontap: () {
                  setState(() {
                    _currentIndex = 0;
                  });
                },
              ),
              BottomNavbarTile(
                svgName: "users-ico",
                isSelected: _currentIndex == 1,
                ontap: () {
                  setState(() {
                    _currentIndex = 1;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BottomNavbarTile extends StatelessWidget {
  const BottomNavbarTile({
    Key? key,
    required this.svgName,
    required this.isSelected,
    required this.ontap,
  }) : super(key: key);

  final String svgName;
  final bool isSelected;
  final Function() ontap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Container(
        padding: EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          color: isSelected ? primaryColor : kwhite,
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: CustomSvg(
          svgName: svgName,
          color: isSelected ? kwhite : greyColor,
        ),
      ),
    );
  }
}
