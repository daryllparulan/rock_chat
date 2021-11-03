import 'package:flutter/cupertino.dart';
import 'package:rock_chat/service/auth/auth_service.dart';
import 'package:rock_chat/service/auth/auth_state.dart';

class SignUpProvider extends ChangeNotifier {
  final AuthenticationService _authenticationService;

  SignUpProvider(this._authenticationService);

  AuthenticationState _authenticationState =
      AuthenticationState(AuthenticationStatus.unuathed, null);
  String email = '';
  String firstName = '';
  String lastName = '';
  String password = '';
  String confirmedPassword = '';

  AuthenticationState get state {
    return _authenticationState;
  }

  void resetState() {
    _authenticationState =
        AuthenticationState(AuthenticationStatus.unuathed, null);
  }

  void registerUser() async {
    _authenticationState =
        AuthenticationState(AuthenticationStatus.loading, null);
    notifyListeners();

    _authenticationState = await _authenticationService.signUp(
        email: email,
        firstName: firstName,
        lastName: lastName,
        password: password);

    if (_authenticationState.authStatus == AuthenticationStatus.authed) {
      email = '';
      firstName = '';
      lastName = '';
      password = '';
      confirmedPassword = '';
    }

    notifyListeners();
  }
}
