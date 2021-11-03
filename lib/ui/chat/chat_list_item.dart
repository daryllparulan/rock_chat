import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rock_chat/model/chat.dart';
import 'package:rock_chat/model/user.dart';
import 'package:rock_chat/util/icon_helper.dart';

class ChatListItem extends StatelessWidget {
  final ChatMessage chatMessage;

  const ChatListItem({Key? key, required this.chatMessage}) : super(key: key);

  //Icon or message
  Widget _getMessage(String message) {
    if (IconHelper.isIcon(message)) {
      final iconInfo = IconHelper.getIconFromMessage(message);
      return Icon(iconInfo.iconData, size: 150, color: iconInfo.color);
    }

    return Text(chatMessage.message);
  }

  @override
  Widget build(BuildContext context) {
    final isMe = chatMessage.userEmail == context.read<User>().email;
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: isMe
            ? chatRows(chatMessage, isMe).reversed.toList()
            : chatRows(chatMessage, isMe),
      ),
    );
  }

  List<Widget> chatRows(ChatMessage chatMessage, bool isMe) => [
        Container(
          decoration: BoxDecoration(
              color: chatMessage.getChatIconColor(),
              border: Border.all(
                color: chatMessage.getChatIconColor(),
              ),
              borderRadius: const BorderRadius.all(Radius.circular(32))),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Text(chatMessage.chatAbbreviation),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment:
                isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 4),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: isMe
                    ? chatRowsInner(chatMessage).reversed.toList()
                    : chatRowsInner(chatMessage),
              ),
              const SizedBox(height: 4),
              _getMessage(chatMessage.message)
            ],
          ),
        ),
      ];

  List<Widget> chatRowsInner(ChatMessage chatMessage) => [
        Text(
          chatMessage.username,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(width: 8),
        Text(chatMessage.timeStamp),
      ];
}
