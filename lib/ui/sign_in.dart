import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rock_chat/provider/sign_in_provider.dart';
import 'package:rock_chat/service/auth/auth_state.dart';
import 'package:rock_chat/ui/buttons/login_bt.dart';
import 'package:rock_chat/ui/colors/rock_colors.dart';
import 'package:rock_chat/ui/dialogs/auth_error.dart';
import 'package:rock_chat/ui/sign_up.dart';
import 'package:rock_chat/ui/textfields/login_tf.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    context.read<SignInProvider>().resetState();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Rock Chat'),
      ),
      body:
          Consumer<SignInProvider>(builder: (context, signInProvider, widget) {
        if (signInProvider.state.authStatus == AuthenticationStatus.error) {
          Future.delayed(Duration.zero, () async {
            AuthenticationDialog.show(context, signInProvider.state.authError);
          });
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
                    enabled: (signInProvider.state.authStatus !=
                        AuthenticationStatus.loading),
                    onChanged: (value) => signInProvider.email = value,
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
                    label: 'Password',
                    errMsg: '*** required',
                    inputType: TextInputType.text,
                    textInputAction: TextInputAction.done,
                    isObscureText: true,
                    enabled: (signInProvider.state.authStatus !=
                        AuthenticationStatus.loading),
                    onFieldSubmitted: (v) {
                      if (_formKey.currentState!.validate()) {
                        signInProvider.signInUser();
                      }
                    },
                    onChanged: (value) => signInProvider.password = value,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: LoginFlatButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          signInProvider.signInUser();
                        }
                      },
                      isLoading: signInProvider.state.authStatus ==
                          AuthenticationStatus.loading,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        "Don\'t have an account? ",
                        textAlign: TextAlign.start,
                        style: TextStyle(color: RockColors.colorPrimaryDark),
                      ),
                      TextButton(
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all(
                              const EdgeInsets.symmetric(
                                  vertical: 0, horizontal: 2)),
                        ),
                        onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignUpPage()),
                        ), //_handleCreateAccount(context),
                        child: Text(
                          "Create one here.",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: RockColors.colorDarkAccent),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
