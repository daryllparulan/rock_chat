import 'package:flutter/material.dart';

class LoginTextFormField extends StatelessWidget {
  final String label;
  final String errMsg;
  final TextInputType inputType;
  final TextInputAction? textInputAction;
  final bool? isObscureText;
  final bool? isAutoFocus;
  final FocusNode? focusNode;
  final void Function(String)? onFieldSubmitted;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final bool? enabled;

  const LoginTextFormField(
      {Key? key,
      required this.label,
      required this.inputType,
      this.errMsg = '',
      this.textInputAction,
      this.isObscureText,
      this.isAutoFocus,
      this.focusNode,
      this.onFieldSubmitted,
      this.onChanged,
      this.validator,
      this.controller,
      this.enabled})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: TextFormField(
        textInputAction: textInputAction ?? TextInputAction.next,
        autofocus: isAutoFocus ?? false,
        enabled: enabled ?? true,
        focusNode: focusNode,
        controller: controller,
        onFieldSubmitted: onFieldSubmitted,
        onChanged: onChanged,
        obscureText: isObscureText ?? false,
        decoration: InputDecoration(
          labelText: label,
          contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(32.0),
          ),
        ),
        validator: validator ??
            (val) {
              if (val != null && val.isEmpty) {
                return errMsg;
              }
              return null;
            },
        keyboardType: inputType,
        style: const TextStyle(
          fontFamily: 'Poppins',
        ),
      ),
    );
  }
}
