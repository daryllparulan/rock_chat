import 'package:flutter/material.dart';
import 'package:rock_chat/model/user.dart';
import 'package:rock_chat/service/direct_messages/message_service.dart';

class MessageProvider extends ChangeNotifier {
  final User _currUser;
  final User _toUser;

  MessageProvider(this._currUser, this._toUser) {
    getGroupId();
  }

  String? groupId;
  ConnectionState status = ConnectionState.none;
  Object? error;

  bool get hasError => error != null;

  void getGroupId() async {
    error = null;
    status = ConnectionState.waiting;
    notifyListeners();
    try {
      groupId = await MessageService.getGroupId(_currUser.id, _toUser.id);
    } catch (e) {
      error = e;
    }
    status = ConnectionState.done;
    notifyListeners();
  }

  void setStatusWaiting() {
    status = ConnectionState.waiting;
    notifyListeners();
  }

  void setGroupId(String newGroupId) {
    groupId = newGroupId;
    status = ConnectionState.done;
    notifyListeners();
  }
}
