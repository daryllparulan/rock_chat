import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rock_chat/model/message.dart';
import 'package:rock_chat/model/user.dart';
import 'package:rock_chat/provider/message_provider.dart';
import 'package:rock_chat/service/direct_messages/message_service.dart';
import 'package:rock_chat/ui/dm_widgets/message.dart';

class MessagesWidget extends StatelessWidget {
  final User user;
  const MessagesWidget({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (context.watch<MessageProvider>().status == ConnectionState.waiting) {
      return const Center(child: CircularProgressIndicator());
    } else if (context.watch<MessageProvider>().hasError) {
      return const Center(
        child: Text('Something Went Wrong Try later'),
      );
    }

    return StreamBuilder<List<Message>>(
      stream: MessageService.getPrivateMessages(
          context.watch<MessageProvider>().groupId),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return const Center(child: CircularProgressIndicator());
          default:
            if (snapshot.hasError) {
              return const Center(
                child: Text('Something Went Wrong Try later'),
              );
            } else {
              final messages = snapshot.data;
              return messages!.isEmpty
                  ? const Center(
                      child: Text('Say Hi...'),
                    )
                  : ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      reverse: true,
                      itemCount: messages.length,
                      itemBuilder: (context, index) {
                        final message = messages[index];
                        return MessageWidget(
                          message: message,
                          fromUser: user,
                        );
                      });
            }
        }
      },
    );
  }
}
