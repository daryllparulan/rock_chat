import 'package:rock_chat/model/user.dart';

String getChatAbbreviationUsingUser(User user) {
  return getChatAbbreviation(user.firstName, user.lastName);
}

String getChatAbbreviation(String firstName, String lastName) {
  return '${firstName[0]}${lastName[0]}'.toUpperCase();
}
