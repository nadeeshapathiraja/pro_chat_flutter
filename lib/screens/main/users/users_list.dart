import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:pro_chat/components/custom_images.dart';
import 'package:pro_chat/components/custom_text.dart';
import 'package:pro_chat/controllers/auth/user_controller.dart';
import 'package:pro_chat/models/objects.dart';
import 'package:pro_chat/providers/auth/auth_provider.dart';
import 'package:pro_chat/providers/chat/chat_provider.dart';
import 'package:pro_chat/screens/main/chat/chat.dart';
import 'package:pro_chat/utils/app_colors.dart';
import 'package:pro_chat/utils/util_functions.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;

class Users extends StatefulWidget {
  const Users({Key? key}) : super(key: key);

  @override
  _UsersState createState() => _UsersState();
}

class _UsersState extends State<Users> {
  List<UserModel> list = [];
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
        child: Consumer<AuthProvider>(
          builder: (context, value, child) {
            return StreamBuilder<QuerySnapshot>(
              stream: UserController().getAllUsers(value.userModel.uid),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const CustomText(text: "No Users");
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                Logger().w(snapshot.data!.docs.length);

                list.clear();

                for (var item in snapshot.data!.docs) {
                  Map<String, dynamic> data =
                      item.data() as Map<String, dynamic>;

                  var model = UserModel.fromJson(data);

                  list.add(model);
                }

                return ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return UserCard(
                      model: list[index],
                    );
                  },
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 5),
                  itemCount: list.length,
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class UserCard extends StatelessWidget {
  const UserCard({
    Key? key,
    required this.model,
  }) : super(key: key);

  final UserModel model;

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
                CircularNetworkImage(
                  height: 60,
                  width: 60,
                  url: model.img,
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CustomText(
                          text: model.name,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                        SizedBox(width: 5),
                        Icon(
                          Icons.circle,
                          size: 10,
                          color:
                              model.isOnline ? Colors.greenAccent : greyColor,
                        )
                      ],
                    ),
                    CustomText(
                      text: timeago.format(DateTime.parse(model.lastseen)),
                      fontSize: 12,
                      color: greyColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ],
                ),
              ],
            ),
            Consumer<ChatProvider>(
              builder: (context, value, child) {
                return value.isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : ElevatedButton.icon(
                        onPressed: () {
                          value.createConversation(context, model);
                        },
                        icon: const Icon(Icons.chat),
                        label: const CustomText(
                          text: "Start Chat",
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: kwhite,
                        ),
                      );
              },
            ),
          ],
        ),
      ),
    );
  }
}
