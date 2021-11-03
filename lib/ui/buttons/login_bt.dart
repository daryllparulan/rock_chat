import 'package:flutter/material.dart';
import 'package:rock_chat/ui/colors/rock_colors.dart';

class LoginFlatButton extends StatelessWidget {
  final void Function() onPressed;
  final bool isLoading;
  final String? text;

  const LoginFlatButton(
      {Key? key, required this.onPressed, required this.isLoading, this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: RockColors.colorPrimary,
      child: MaterialButton(
        textColor: Colors.white,
        minWidth: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
        onPressed: isLoading ? null : onPressed,
        child: isLoading
            ? const SizedBox(
                height: 25,
                width: 25,
                child: CircularProgressIndicator(
                  color: Colors.white,
                ))
            : Text(text ?? 'Sign In'),
      ),
    );
    // }
  }
}
