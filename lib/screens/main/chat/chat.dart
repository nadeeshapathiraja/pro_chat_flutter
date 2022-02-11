import 'package:chat_bubbles/bubbles/bubble_special_three.dart';
import 'package:flutter/material.dart';
import 'package:pro_chat/components/custom_images.dart';
import 'package:pro_chat/components/custom_text.dart';
import 'package:pro_chat/components/custom_textfeild.dart';
import 'package:pro_chat/utils/app_colors.dart';

class Chat extends StatefulWidget {
  const Chat({Key? key}) : super(key: key);

  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
        child: const SafeArea(
          child: AppBarSection(),
        ),
        preferredSize: Size.fromHeight(size.height / 10),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: ListView.builder(
          itemBuilder: (context, index) {
            return ChatMessageWidget(
              isSender: index % 2 == 0,
            );
          },
          itemCount: 20,
        ),
      ),
      bottomNavigationBar: const MessageTypingWidget(),
    );
  }
}

class ChatMessageWidget extends StatelessWidget {
  const ChatMessageWidget({
    Key? key,
    required this.isSender,
  }) : super(key: key);
  final bool isSender;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          isSender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        BubbleSpecialThree(
          text: 'Added iMassage shape bubbles',
          color: isSender ? primaryColor : greyColor.withOpacity(0.9),
          isSender: isSender,
          tail: true,
          textStyle: const TextStyle(color: Colors.white, fontSize: 16),
        ),
        Padding(
          padding: isSender
              ? const EdgeInsets.only(right: 10)
              : const EdgeInsets.only(left: 10),
          child: const CustomText(
            text: "1 min ago",
            fontSize: 10,
            color: greyColor,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

class MessageTypingWidget extends StatelessWidget {
  const MessageTypingWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: greyColor.withOpacity(0.4),
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: const [
          SizedBox(width: 20),
          Expanded(
            flex: 5,
            child: CustomTextfeild(
              hintText: 'Write your Message',
            ),
          ),
          Expanded(
            flex: 1,
            child: Icon(
              Icons.send,
              size: 40.0,
            ),
          ),
        ],
      ),
    );
  }
}

class AppBarSection extends StatelessWidget {
  const AppBarSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kwhite,
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
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
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  CustomText(
                    text: "Supun Sandaruan",
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                  CustomText(
                    text: "Online",
                    fontSize: 14,
                    color: greyColor,
                    fontWeight: FontWeight.w500,
                  ),
                ],
              ),
            ],
          ),
          const Icon(
            Icons.attach_file,
            size: 30.0,
          ),
        ],
      ),
    );
  }
}
