import 'package:flutter/material.dart';
import 'package:rock_chat/model/user.dart';
import 'package:rock_chat/ui/dm_widgets/chat_page.dart';
import 'package:rock_chat/util/color_util.dart';

class ChatBody extends StatelessWidget {
  final List<User> users;
  const ChatBody({Key? key, required this.users}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25), topRight: Radius.circular(25))),
        child: buildChats(),
      ),
    );
  }

  Widget buildChats() {
    return ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];
          return SizedBox(
            height: 75,
            child: ListTile(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ChatPage(user: user),
                ));
              },
              leading: CircleAvatar(
                child: Text(user.chatAbbreviation),
                radius: 25,
                backgroundColor:
                    ColorUtil.getColorFromColorName(user.chatIconColor),
              ),
              title: Text(user.username),
            ),
          );
        });
  }
}
