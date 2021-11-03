import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rock_chat/model/user.dart';
import 'package:rock_chat/provider/message_provider.dart';
import 'package:rock_chat/ui/colors/rock_colors.dart';
import 'package:rock_chat/ui/dm_widgets/messages.dart';
import 'package:rock_chat/ui/dm_widgets/new_message.dart';
import 'package:rock_chat/ui/dm_widgets/profile_header.dart';

class ChatPage extends StatefulWidget {
  final User user;
  const ChatPage({Key? key, required this.user}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: RockColors.colorPrimary,
      body: SafeArea(
          child: ChangeNotifierProvider(
              create: (_) => MessageProvider(context.read<User>(), widget.user),
              child: Column(
                children: [
                  ProfileHeader(
                    name: widget.user.username,
                  ),
                  Expanded(
                    child: Container(
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(25),
                              topRight: Radius.circular(25))),
                      child: Column(
                        children: [
                          Expanded(
                              child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: MessagesWidget(user: widget.user),
                          )),
                          NewMessage(userId: widget.user.id)
                        ],
                      ),
                    ),
                  ),
                ],
              ))),
    );
  }
}
