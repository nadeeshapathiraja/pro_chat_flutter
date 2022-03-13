import 'package:flutter/material.dart';
import 'package:pro_chat/components/custom_images.dart';
import 'package:pro_chat/components/custom_text.dart';
import 'package:pro_chat/providers/auth/auth_provider.dart';
import 'package:pro_chat/screens/main/chat/chat.dart';
import 'package:pro_chat/utils/app_colors.dart';
import 'package:pro_chat/utils/util_functions.dart';
import 'package:provider/provider.dart';

class Users extends StatefulWidget {
  const Users({Key? key}) : super(key: key);

  @override
  _UsersState createState() => _UsersState();
}

class _UsersState extends State<Users> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kwhite,
        elevation: 2,
        title: Consumer<AuthProvider>(builder: (context, value, child) {
          return CustomText(
            text: value.user.displayName!,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          );
        }),
        actions: [
          Consumer<AuthProvider>(
            builder: (context, value, child) {
              return Row(
                children: [
                  IconButton(
                    onPressed: () {
                      value.logout();
                    },
                    icon: const Icon(Icons.logout),
                    color: greyColor,
                    iconSize: 30,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: CustomNetworkImage(
                      height: 60,
                      width: 60,
                      url: value.user.photoURL!,
                    ),
                  ),
                ],
              );
            },
          ),
          const SizedBox(width: 10),
        ],
        //remove default back button
        automaticallyImplyLeading: false,
      ),
      body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          width: size.width,
          height: size.height,
          child: ListView.separated(
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return const ConversationCard();
              },
              separatorBuilder: (context, index) => const SizedBox(height: 5),
              itemCount: 10)),
    );
  }
}

class ConversationCard extends StatelessWidget {
  const ConversationCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        UtilFunctions.navigateTo(context, const Chat());
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
        decoration: const BoxDecoration(
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const CircularNetworkImage(
                  height: 60,
                  width: 60,
                  url:
                      "https://cdn.hashnode.com/res/hashnode/image/upload/v1601295799278/OsMsXdM2F.jpeg",
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    CustomText(
                      text: "Supun Sandaruan",
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                    CustomText(
                      text: "Really, Thank you",
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ],
                ),
              ],
            ),
            const CustomText(
              text: "1 min ago",
              fontSize: 12,
              color: greyColor,
              fontWeight: FontWeight.w500,
            ),
          ],
        ),
      ),
    );
  }
}
