import 'dart:math';
import 'package:rock_chat/model/user.dart';
import 'package:rock_chat/service/user/user_service.dart';
import 'package:rock_chat/util/color_util.dart';
import 'package:rock_chat/util/string_util.dart';

class UserCreaionService {
  static Future<User> createUser(
      String id, String email, String firstName, String lastName) async {
    final user = User(
        id: id,
        email: email,
        username: '$firstName $lastName',
        firstName: firstName,
        lastName: lastName,
        chatAbbreviation: getChatAbbreviation(firstName, lastName),
        chatIconColor: _getRandomChatColor());
    await UserService.saveUser(user);
    return user;
  }

  static String _getRandomChatColor() {
    Random random = Random();
    int rng = random.nextInt(ColorUtil.colorNames.length);
    return ColorUtil.colorNames[rng];
  }
}
