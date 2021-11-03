import 'package:flutter/material.dart';
import 'package:rock_chat/model/user.dart';
import 'package:rock_chat/ui/colors/rock_colors.dart';
import 'package:rock_chat/util/color_util.dart';

class ChatHeader extends StatelessWidget {
  final List<User> users;
  const ChatHeader({Key? key, required this.users}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 24),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 60,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: users.length + 1,
                itemBuilder: (context, index) {
                  final user = users[index > 0 ? index - 1 : index];
                  return Container(
                    margin: const EdgeInsets.only(right: 12),
                    child: GestureDetector(
                      onTap: () {
                        print('chat header cliked!!! TODO!!!');
                      },
                      child: CircleAvatar(
                        child: index == 0
                            ? const Icon(Icons.search)
                            : Text(user.chatAbbreviation),
                        radius: 24,
                        backgroundColor: index == 0
                            ? RockColors.colorLightAccent
                            : ColorUtil.getColorFromColorName(
                                user.chatIconColor),
                      ),
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}
