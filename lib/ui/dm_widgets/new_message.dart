import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rock_chat/model/user.dart';
import 'package:rock_chat/provider/message_provider.dart';
import 'package:rock_chat/service/direct_messages/message_service.dart';
import 'package:rock_chat/ui/colors/rock_colors.dart';

class NewMessage extends StatefulWidget {
  final String userId;
  const NewMessage({Key? key, required this.userId}) : super(key: key);

  @override
  _MessageState createState() => _MessageState();
}

class _MessageState extends State<NewMessage> {
  final _controller = TextEditingController();

  void sendMessage(String msg) async {
    FocusScope.of(context).unfocus();
    await MessageService.uploadPrivateMessage(
        context, context.read<User>().id, widget.userId, msg);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Container(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            Expanded(
                child: TextField(
              controller: _controller,
              textCapitalization: TextCapitalization.sentences,
              autocorrect: true,
              enableSuggestions: true,
              keyboardType: TextInputType.multiline,
              maxLines: 2,
              decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[100],
                  labelText: 'Type your message',
                  border: OutlineInputBorder(
                      borderSide: const BorderSide(width: 0),
                      gapPadding: 0,
                      borderRadius: BorderRadius.circular(25))),
            )),
            const SizedBox(
              width: 10,
            ),
            IconButton(
              splashColor: RockColors.colorLightAccent,
              icon: const Icon(Icons.send_rounded),
              onPressed: context.watch<MessageProvider>().status ==
                          ConnectionState.waiting ||
                      context.watch<MessageProvider>().hasError
                  ? null
                  : () {
                      if (_controller.text.trim().isEmpty) {
                        return;
                      }
                      sendMessage(_controller.text.trim());
                      _controller.clear();
                    },
            ),
            const SizedBox(
              width: 10,
            ),
          ],
        ),
      ),
    );
  }
}
