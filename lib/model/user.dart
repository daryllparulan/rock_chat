import 'package:flutter/cupertino.dart';
import 'package:rock_chat/util/color_util.dart';

class User {
  final String id;
  final String email;
  final String username;
  final String firstName;
  final String lastName;
  final String chatIconColor;
  final String chatAbbreviation;

  const User({
    required this.email,
    required this.username,
    required this.chatIconColor,
    required this.firstName,
    required this.lastName,
    required this.chatAbbreviation,
    required this.id,
  });

  Color getChatIconColor() {
    return ColorUtil.getColorFromColorName(chatIconColor);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'username': username,
      'first_name': firstName,
      'last_name': lastName,
      'chat_icon_color': chatIconColor,
      'chat_abbreviation': chatAbbreviation
    };
  }

  static User fromJson(Map<String, dynamic> json) => User(
        id: json['id'],
        email: json['email'],
        username: json['username'],
        firstName: json['first_name'],
        lastName: json['last_name'],
        chatIconColor: json['chat_icon_color'],
        chatAbbreviation: json['chat_abbreviation'],
      );
}
