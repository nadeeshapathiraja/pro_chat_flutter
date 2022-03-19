import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:pro_chat/components/custom_images.dart';
import 'package:pro_chat/components/custom_text.dart';
import 'package:pro_chat/controllers/chat/chat_controller.dart';
import 'package:pro_chat/models/objects.dart';
import 'package:pro_chat/providers/auth/auth_provider.dart';
import 'package:pro_chat/screens/main/chat/chat.dart';
import 'package:pro_chat/utils/app_colors.dart';
import 'package:pro_chat/utils/util_functions.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<ConversationModel> list = [];
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
              stream: ChatController().getconversation(value.userModel.uid),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const CustomText(text: "No Conversactions");
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                Logger().w(snapshot.data!.docs.length);

                list.clear();

                for (var item in snapshot.data!.docs) {
                  Map<String, dynamic> data =
                      item.data() as Map<String, dynamic>;

                  var model = ConversationModel.fromJson(data);

                  list.add(model);
                }

                return ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return ConversationCard(model: list[index]);
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

class ConversationCard extends StatelessWidget {
  const ConversationCard({
    Key? key,
    required this.model,
  }) : super(key: key);

  final ConversationModel model;

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
        child: Consumer<AuthProvider>(
          builder: (context, value, child) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CircularNetworkImage(
                      height: 60,
                      width: 60,
                      url: model.userArray
                          .firstWhere(
                              (element) => element.uid != value.userModel.uid)
                          .img,
                    ),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text: model.userArray
                              .firstWhere((element) =>
                                  element.uid != value.userModel.uid)
                              .name,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                        CustomText(
                          text: model.lastMessage,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ],
                    ),
                  ],
                ),
                CustomText(
                  text: timeago.format(DateTime.parse(model.lastMessageTime)),
                  fontSize: 12,
                  color: greyColor,
                  fontWeight: FontWeight.w500,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
