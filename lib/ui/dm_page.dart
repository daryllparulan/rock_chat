import 'package:flutter/material.dart';
import 'package:rock_chat/model/user.dart';
import 'package:rock_chat/service/user/user_service.dart';
import 'package:rock_chat/ui/dm_widgets/chat_body.dart';
import 'package:rock_chat/ui/dm_widgets/chat_header.dart';

class DMPage extends StatelessWidget {
  const DMPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: StreamBuilder<List<User>>(
            stream: UserService.getUsers(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return const Center(
                    child: CircularProgressIndicator(color: Colors.white),
                  );
                default:
                  if (snapshot.hasError) {
                    return const Center(
                      child: Text('Something went wrong try later.',
                          style: TextStyle(color: Colors.white)),
                    );
                  }
                  final users = snapshot.data;
                  if (users!.isEmpty) {
                    return const Center(
                      child: Text('No other users to chat to.',
                          style: TextStyle(color: Colors.white)),
                    );
                  }
                  return Column(
                    children: [
                      ChatHeader(users: users),
                      ChatBody(users: users)
                    ],
                  );
              }
            }));
  }
}
