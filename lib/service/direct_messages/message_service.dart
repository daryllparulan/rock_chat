import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rock_chat/model/message.dart';
import 'package:rock_chat/provider/message_provider.dart';
import 'package:rock_chat/util/util.dart';

class MessageService {
  static Future uploadPrivateMessage(BuildContext context, String currUserId,
      String toUserId, String msg) async {
    Message? message;

    String? groupId = context.read<MessageProvider>().groupId;

    if (groupId == null) {
      context.read<MessageProvider>().setStatusWaiting();
      // create group
      final refGroup = FirebaseFirestore.instance.collection('groups');
      groupId = refGroup.doc().id;
      message = Message(
          id: FirebaseFirestore.instance
              .collection('message/$groupId/messages')
              .doc()
              .id,
          message: msg,
          sentAt: DateTime.now(),
          sentBy: currUserId);
      await refGroup.doc(groupId).set({
        'created_at': DateTime.now(),
        'created_by': currUserId,
        'id': groupId,
        'modified_at': DateTime.now(),
        'name': '', // blank for private chat
        'members': {
          currUserId: true,
          toUserId: true,
        },
        'recent_message': message.toJson(),
        'type': 1
      }); // TODO create group model
      context.read<MessageProvider>().setGroupId(groupId);
    }

    final refMsg =
        FirebaseFirestore.instance.collection('message/$groupId/messages');

    message ??= Message(
        id: refMsg.doc().id,
        message: msg,
        sentAt: DateTime.now(),
        sentBy: currUserId);
    await refMsg.doc(message.id).set(message.toJson());

    await updateRecentMessage(groupId, message);
  }

  static Stream<List<Message>> getPrivateMessages(String? groupId) {
    return FirebaseFirestore.instance
        .collection('message/$groupId/messages')
        .orderBy('sent_at', descending: true)
        .snapshots()
        .transform(Utils.transformer(Message.fromJson));
  }

  static Future<String?> getGroupId(String currUser, String toUserId) async {
    final groupRef = await FirebaseFirestore.instance
        .collection('groups')
        .where('type', isEqualTo: 1) // if group chat will be supported
        .where('members.$toUserId', isEqualTo: true)
        .where('members.$currUser', isEqualTo: true)
        .get();
    return groupRef.docs.isEmpty ? null : groupRef.docs.first.id;
  }

  static Future<void> updateRecentMessage(
      String groupId, Message newMessage) async {
    // this can be done i think using firestore triggers?
    final snapshot = await FirebaseFirestore.instance
        .collection('groups')
        .doc(groupId)
        .get();

    DateTime groupLastMessage =
        Utils.toDateTime(snapshot.data()!['recent_message']['sent_at']);
    if (newMessage.sentAt.isAfter(groupLastMessage)) {
      await FirebaseFirestore.instance
          .collection('groups')
          .doc(groupId)
          .update({'recent_message': newMessage.toJson()});
    }
  }
}
