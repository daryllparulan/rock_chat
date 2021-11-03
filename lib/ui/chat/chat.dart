import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rock_chat/model/chat.dart';
import 'package:rock_chat/model/chatroom.dart';
import 'package:rock_chat/model/user.dart';
import 'package:rock_chat/service/chat_room/chat_service.dart';
import 'package:rock_chat/ui/chat/chat_list_item.dart';
import 'package:rock_chat/ui/colors/rock_colors.dart';
import 'package:rock_chat/ui/defaults/list_defaults.dart';
import 'package:provider/provider.dart';

class ChatPage extends StatelessWidget {
  final String title;
  final ChatRoom chatRoom;

  const ChatPage({Key? key, required this.title, required this.chatRoom})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: StreamBuilder<List<ChatMessage>>(
        stream: ChatService.getChatMessages(chatRoom.id),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return loadingChatRoom();
            default:
              if (snapshot.hasError) {
                return const Center(
                  child: Text('Something Went Wrong Try later'),
                );
              } else {
                if (snapshot.data!.isEmpty) {
                  return emptyChatRoom(context);
                }
                return Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        keyboardDismissBehavior:
                            ScrollViewKeyboardDismissBehavior.onDrag,
                        physics: const BouncingScrollPhysics(),
                        reverse: true,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return ChatListItem(
                              chatMessage: snapshot.data![index]);
                        },
                      ),
                    ),
                    // Container(height: 1, color: Colors.grey[500]),
                    const SizedBox(height: 10),
                    _textInput(context),
                    const SizedBox(height: 10),
                  ],
                );
              }
          }
        },
      ),
    );
  }

  Widget _textInput(BuildContext context) {
    final controller = TextEditingController();
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(width: 16),
        Flexible(
          child: TextField(
            controller: controller,
            keyboardType: TextInputType.multiline,
            maxLines: 2,
            textCapitalization: TextCapitalization.sentences,
            autocorrect: true,
            enableSuggestions: true,
            decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[100],
                labelText: 'Send message',
                border: OutlineInputBorder(
                    borderSide: const BorderSide(width: 0),
                    gapPadding: 0,
                    borderRadius: BorderRadius.circular(25))),
          ),
        ),
        const SizedBox(width: 12),
        IconButton(
          splashColor: RockColors.colorLightAccent,
          icon: Icon(ChatService.getIconInfo(chatRoom.icon).iconData),
          onPressed: () {
            ChatService.saveIconMessage(
                context.read<User>(), chatRoom.id, chatRoom.icon);
          },
        ),
        IconButton(
          splashColor: RockColors.colorLightAccent,
          icon: const Icon(Icons.send_rounded),
          onPressed: () {
            if (controller.text.trim().isEmpty) {
              return;
            }
            ChatService.saveMessage(context.read<User>(), chatRoom.id,
                controller.value.text.trim());
            controller.text = "";
          },
        ),
        const SizedBox(width: 16)
      ],
    );
  }
}
