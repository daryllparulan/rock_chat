import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rock_chat/provider/sign_up_provider.dart';
import 'package:rock_chat/service/auth/auth_state.dart';
import 'package:rock_chat/ui/buttons/login_bt.dart';
import 'package:rock_chat/ui/dialogs/auth_error.dart';
import 'package:rock_chat/ui/textfields/login_tf.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Rock Chat'),
      ),
      body:
          Consumer<SignUpProvider>(builder: (context, signUpProvider, widget) {
        if (signUpProvider.state.authStatus == AuthenticationStatus.error) {
          Future.delayed(Duration.zero, () async {
            AuthenticationDialog.show(context, signUpProvider.state.authError);
          });
        }

        if (signUpProvider.state.authStatus == AuthenticationStatus.authed) {
          Navigator.pop(context);
        }

        return Center(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  LoginTextFormField(
                    label: 'Email',
                    errMsg: '*** required',
                    inputType: TextInputType.text,
                    enabled: (signUpProvider.state.authStatus !=
                        AuthenticationStatus.loading),
                    onChanged: (value) => signUpProvider.email = value,
                    validator: (val) {
                      if (val != null && val.isEmpty) {
                        return '*** required';
                      }
                      if (val != null && !EmailValidator.validate(val)) {
                        return 'Please enter a valid email.';
                      }
                      return null;
                    },
                  ),
                  LoginTextFormField(
                    label: 'First Name',
                    errMsg: '*** required',
                    inputType: TextInputType.text,
                    enabled: (signUpProvider.state.authStatus !=
                        AuthenticationStatus.loading),
                    onChanged: (value) => signUpProvider.firstName = value,
                  ),
                  LoginTextFormField(
                    label: 'Last Name',
                    errMsg: '*** required',
                    inputType: TextInputType.text,
                    enabled: (signUpProvider.state.authStatus !=
                        AuthenticationStatus.loading),
                    onChanged: (value) => signUpProvider.lastName = value,
                  ),
                  LoginTextFormField(
                    label: 'Password',
                    errMsg: '*** required',
                    inputType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    isObscureText: true,
                    enabled: (signUpProvider.state.authStatus !=
                        AuthenticationStatus.loading),
                    onChanged: (value) => signUpProvider.password = value,
                  ),
                  LoginTextFormField(
                      label: 'Confirm Password',
                      errMsg: '*** required',
                      inputType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      isObscureText: true,
                      enabled: (signUpProvider.state.authStatus !=
                          AuthenticationStatus.loading),
                      onFieldSubmitted: (v) {
                        if (_formKey.currentState!.validate()) {
                          signUpProvider.registerUser();
                        }
                      },
                      onChanged: (value) =>
                          signUpProvider.confirmedPassword = value,
                      validator: (val) {
                        if (val != null && val.isEmpty) {
                          return '*** required';
                        }
                        if (val != null &&
                            (signUpProvider.confirmedPassword !=
                                signUpProvider.password)) {
                          return 'Passwords need to match.';
                        }
                        return null;
                      }),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: LoginFlatButton(
                      text: 'Sign up'.toUpperCase(),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          signUpProvider.registerUser();
                        }
                      },
                      isLoading: signUpProvider.state.authStatus ==
                          AuthenticationStatus.loading,
                    ),
                  ),
                  signUpProvider.state.authStatus ==
                          AuthenticationStatus.loading
                      ? const Text('Signing Up. Please wait...')
                      : Container(),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
