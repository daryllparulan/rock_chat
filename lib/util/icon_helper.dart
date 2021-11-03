import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';

class IconInfo {
  Color color;
  IconData iconData;
  IconInfo({required this.iconData, required this.color});
}

class IconHelper {
  IconHelper._();
  static const List<String> _iconMessages = [':guitar:', ':drum:'];

  static IconInfo getIconFromMessage(String message) {
    return getIconFromIconName(message.replaceAll(':', ''));
  }

  static IconInfo getIconFromIconName(String iconName) {
    switch (iconName) {
      case 'drum':
        return IconInfo(
            iconData: FontAwesome5.drum_steelpan, color: Colors.blue);
      case 'guitar':
        return IconInfo(iconData: FontAwesome5.guitar, color: Colors.red);
    }
    return IconInfo(iconData: FontAwesome5.guitar, color: Colors.red);
  }

  static String getMessageFromIconName(String iconName) {
    switch (iconName) {
      case 'guitar':
        return _iconMessages[0];
      case 'drum':
        return _iconMessages[1];
    }
    return _iconMessages[0];
  }

  static bool isIcon(String message) {
    return _iconMessages.contains(message);
  }
}
