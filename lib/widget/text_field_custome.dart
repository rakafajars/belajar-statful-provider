import 'package:flutter/material.dart';

class TextFieldCustome extends StatelessWidget {
  final Function(String)? onChanged;
  final bool isValidTextField;
  final String errorMessage;
  final String hintText;
  final bool isObsucreText;
  final Widget? suffixIconWidget;
  final bool isReadOnly;
  const TextFieldCustome({
    super.key,
    required this.onChanged,
    required this.isValidTextField,
    required this.errorMessage,
    required this.hintText,
    this.isObsucreText = false,
    this.isReadOnly = false,
    this.suffixIconWidget,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: isReadOnly,
      keyboardType: TextInputType.text,
      onChanged: onChanged,
      obscureText: isObsucreText,
      decoration: InputDecoration(
        hintText: hintText,
        labelText: hintText,
        errorText: isValidTextField ? null : errorMessage,
        suffixIcon: suffixIconWidget,
      ),
    );
  }
}
