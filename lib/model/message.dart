import 'package:rock_chat/util/util.dart';

class Message {
  final String id;
  final String message;
  final DateTime sentAt;
  final String sentBy;

  const Message(
      {required this.id,
      required this.message,
      required this.sentAt,
      required this.sentBy});

  static Message fromJson(Map<String, dynamic> json) => Message(
      id: json['id'],
      message: json['message'],
      sentAt: Utils.toDateTime(json['sent_at']),
      sentBy: json['sent_by']);

  Map<String, dynamic> toJson() => {
        'id': id,
        'message': message,
        'sent_at': Utils.fromDateTimeToJson(sentAt),
        'sent_by': sentBy
      };
}
