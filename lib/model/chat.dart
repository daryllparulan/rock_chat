import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:rock_chat/util/color_util.dart';
import 'package:rock_chat/util/util.dart';

class ChatMessage {
  final String id;
  final DateTime date;
  final String chatRoomId;
  final String username;
  final String userEmail;
  final String chatIconColor;
  final String message;
  final String chatAbbreviation;

  const ChatMessage(
      {required this.id,
      required this.date,
      required this.username,
      required this.userEmail,
      required this.chatRoomId,
      required this.message,
      required this.chatIconColor,
      required this.chatAbbreviation});

  Color getChatIconColor() {
    return ColorUtil.getColorFromColorName(chatIconColor);
  }

  String get timeStamp {
    return DateFormat('MMM d, h:mm a').format(date);
  }

  Map<String, dynamic> tojson() {
    return {
      'id': id,
      'send_date': date,
      'chatroom_id': chatRoomId,
      'message': message,
      'username': username,
      'user_email': userEmail,
      'chat_icon_color': chatIconColor,
      'chat_abbreviation': chatAbbreviation
    };
  }

  static ChatMessage fromJson(Map<String, dynamic> json) => ChatMessage(
      id: json['id'],
      date: Utils.toDateTime(json['send_date']),
      chatRoomId: json['chatroom_id'],
      message: json['message'],
      username: json['username'],
      userEmail: json['user_email'],
      chatIconColor: json['chat_icon_color'],
      chatAbbreviation: json['chat_abbreviation']);
}
