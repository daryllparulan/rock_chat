import 'package:flutter/material.dart';
import 'package:rock_chat/ui/colors/rock_colors.dart';

Widget emptyChatRoom(BuildContext context) => Center(
      child: Text(
        'No messages yet.',
        style: Theme.of(context).textTheme.bodyText1,
      ),
    );

Widget loadingChatRoom() => Center(
      child: CircularProgressIndicator(color: RockColors.colorPrimary),
    );
