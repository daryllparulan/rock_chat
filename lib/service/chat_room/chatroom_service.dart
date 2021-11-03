import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rock_chat/model/chatroom.dart';

class ChatRoomRepo {
  final CollectionReference _ref =
      FirebaseFirestore.instance.collection('chat_rooms');

  Stream<List<ChatRoom>> getChatRooms() async* {
    final snapshots = _ref.snapshots();

    await for (final snapshot in snapshots) {
      yield snapshot.docs
          .map(
            (doc) =>
                ChatRoom(id: doc['id'], icon: doc['icon'], title: doc['title']),
          )
          .toList();
    }
  }
}
