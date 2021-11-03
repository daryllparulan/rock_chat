enum AuthenticationStatus { loading, error, authed, unuathed }

class AuthenticationState {
  final AuthenticationStatus authStatus;
  final String? authError;
  AuthenticationState(this.authStatus, this.authError);
}
