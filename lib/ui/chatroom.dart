import 'package:flutter/material.dart';
import 'package:rock_chat/model/chatroom.dart';
import 'package:rock_chat/service/chat_room/chatroom_service.dart';
import 'package:rock_chat/ui/chat/chat.dart';
import 'package:rock_chat/ui/chat/chatroom_list_item.dart';
import 'package:sticky_headers/sticky_headers.dart';

class ChatRoomPage extends StatelessWidget {
  final chatRoomRepo = ChatRoomRepo();

  ChatRoomPage({Key? key}) : super(key: key);

  void _onChatRoomItemTapped(BuildContext context, ChatRoom chatRoom) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              ChatPage(chatRoom: chatRoom, title: chatRoom.title)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: StreamBuilder<List<ChatRoom>>(
        stream: chatRoomRepo.getChatRooms(),
        builder: (context, snapshot) {
          return !snapshot.hasData
              ? const Center(child: CircularProgressIndicator())
              : ListView.builder(
                  itemCount: 1,
                  itemBuilder: (context, index) {
                    return StickyHeader(
                      header: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 24),
                        width: MediaQuery.of(context).size.width * 0.75,
                        child: const Text(
                          'Chat Rooms',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      content: Column(
                        children: snapshot.data!
                            .map(
                              (item) => ChatRoomListItem(
                                chatRoom: item,
                                onTapped: (chatRoom) =>
                                    _onChatRoomItemTapped(context, chatRoom),
                              ),
                            )
                            .toList(growable: false),
                      ),
                    );
                  },
                );
        },
      ),
    );
  }
}
