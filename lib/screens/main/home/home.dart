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
        actions: const [
          CustomNetworkImage(
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
    return Container(
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
    );
  }
}
