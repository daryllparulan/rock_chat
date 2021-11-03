import 'package:flutter/material.dart';
import 'package:rock_chat/model/chatroom.dart';
import 'package:rock_chat/util/icon_helper.dart';

class ChatRoomListItem extends StatelessWidget {
  final ChatRoom chatRoom;
  final Function(ChatRoom) onTapped;

  const ChatRoomListItem(
      {Key? key, required this.chatRoom, required this.onTapped})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final iconInfo = IconHelper.getIconFromIconName(chatRoom.icon);
    return Padding(
      padding: const EdgeInsets.only(top: 8, right: 8, left: 8),
      child: Card(
        child: InkWell(
          splashColor: Colors.blue.withAlpha(30),
          onTap: () {
            onTapped(chatRoom);
          },
          child: SizedBox(
            height: 100,
            child: Row(
              children: [
                const SizedBox(width: 16),
                Row(children: [
                  Container(
                    decoration: BoxDecoration(
                        color: iconInfo.color,
                        border: Border.all(
                          color: iconInfo.color,
                        ),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(4))),
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Icon(iconInfo.iconData),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[Text(chatRoom.title)],
                  ),
                ]),
                const Spacer(),
                const Icon(Icons.navigate_next),
                const SizedBox(width: 8),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
