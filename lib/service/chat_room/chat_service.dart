import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rock_chat/model/chat.dart';
import 'package:rock_chat/model/user.dart';
import 'package:rock_chat/util/icon_helper.dart';
import 'package:rock_chat/util/util.dart';

class ChatService {
  static void saveMessage(User user, String chatRoomId, String message) async {
    final chatRef =
        FirebaseFirestore.instance.collection('chat/$chatRoomId/chats');
    String chatId = chatRef.doc().id;
    ChatMessage msg = ChatMessage(
        id: chatId,
        chatRoomId: chatRoomId,
        date: DateTime.now(),
        message: message,
        userEmail: user.email,
        username: user.username,
        chatIconColor: user.chatIconColor,
        chatAbbreviation: user.chatAbbreviation);

    await chatRef.doc(chatId).set(msg.tojson());
  }

  static void saveIconMessage(
      User user, String chatRoomId, String iconName) async {
    final message = IconHelper.getMessageFromIconName(iconName);
    saveMessage(user, chatRoomId, message);
  }

  static IconInfo getIconInfo(String iconName) {
    return IconHelper.getIconFromIconName(iconName);
  }

  static Stream<List<ChatMessage>> getChatMessages(String chatRoomId) {
    return FirebaseFirestore.instance
        .collection('chat/$chatRoomId/chats')
        .orderBy('send_date', descending: true)
        .snapshots()
        .transform(Utils.transformer(ChatMessage.fromJson));
  }
}
