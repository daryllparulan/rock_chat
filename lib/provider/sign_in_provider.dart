import 'package:flutter/cupertino.dart';
import 'package:rock_chat/service/auth/auth_service.dart';
import 'package:rock_chat/service/auth/auth_state.dart';

class SignInProvider extends ChangeNotifier {
  final AuthenticationService _authenticationService;

  SignInProvider(this._authenticationService);

  AuthenticationState _authenticationState =
      AuthenticationState(AuthenticationStatus.unuathed, null);
  String _email = '';
  String _password = '';

  AuthenticationState get state {
    return _authenticationState;
  }

  set email(String email) {
    _email = email;
  }

  set password(String password) {
    _password = password;
  }

  void resetState() {
    _authenticationState =
        AuthenticationState(AuthenticationStatus.unuathed, null);
  }

  void signInUser() async {
    _authenticationState =
        AuthenticationState(AuthenticationStatus.loading, null);
    notifyListeners();

    _authenticationState =
        await _authenticationService.signIn(email: _email, password: _password);

    if (_authenticationState.authStatus == AuthenticationStatus.authed) {
      _email = "";
      _password = "";
    }

    notifyListeners();
  }
}
