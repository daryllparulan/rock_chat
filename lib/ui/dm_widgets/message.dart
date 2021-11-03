import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rock_chat/model/message.dart';
import 'package:rock_chat/model/user.dart';
import 'package:rock_chat/ui/colors/rock_colors.dart';
import 'package:rock_chat/util/color_util.dart';

class MessageWidget extends StatelessWidget {
  final Message message;
  final User fromUser;
  const MessageWidget({Key? key, required this.message, required this.fromUser})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    const radius = Radius.circular(12);
    const borderRadius = BorderRadius.all(radius);

    final isMe = context.read<User>().id == message.sentBy;

    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        if (!isMe)
          CircleAvatar(
            child: Text(fromUser.chatAbbreviation),
            radius: 20,
            backgroundColor:
                ColorUtil.getColorFromColorName(fromUser.chatIconColor),
          ),
        Container(
          padding: const EdgeInsets.all(16),
          margin: const EdgeInsets.all(16),
          constraints: const BoxConstraints(maxWidth: 140),
          decoration: BoxDecoration(
            color: isMe ? Colors.grey[100] : RockColors.colorLightAccent,
            borderRadius: isMe
                ? borderRadius
                    .subtract(const BorderRadius.only(bottomRight: radius))
                : borderRadius
                    .subtract(const BorderRadius.only(bottomLeft: radius)),
          ),
          child: Column(
            crossAxisAlignment:
                isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              Text(
                message.message,
                style: TextStyle(color: isMe ? Colors.black : Colors.white),
              )
            ],
          ),
        ),
      ],
    );
  }
}
