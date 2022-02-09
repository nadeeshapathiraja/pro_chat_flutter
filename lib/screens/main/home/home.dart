import 'package:flutter/material.dart';
import 'package:pro_chat/components/custom_images.dart';
import 'package:pro_chat/components/custom_text.dart';
import 'package:pro_chat/utils/app_colors.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kwhite,

        elevation: 0,
        title: const CustomText(
          text: "Message",
          fontSize: 30,
          fontWeight: FontWeight.bold,
        ),
        actions: [
          const CustomNetworkImage(
            height: 45,
            width: 45,
            url:
                "https://cdn.hashnode.com/res/hashnode/image/upload/v1601295799278/OsMsXdM2F.jpeg",
          ),
          SizedBox(width: 10),
        ],
        //remove default back button
        automaticallyImplyLeading: false,
      ),
      body: Container(
        width: size.width,
        height: size.height,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
              decoration: BoxDecoration(
                color: kwhite,
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 10),
                    blurRadius: 20.0,
                    color: Colors.black12,
                  ),
                ],
              ),
              child: Row(
                children: [
                  CircularNetworkImage(
                    height: 60,
                    width: 60,
                    url:
                        "https://cdn.hashnode.com/res/hashnode/image/upload/v1601295799278/OsMsXdM2F.jpeg",
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
