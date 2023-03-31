import 'package:flutter/material.dart';
import 'package:flutter_application_2/widget/button_custome.dart';
import 'package:flutter_application_2/widget/text_field_custome.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:flutter/services.dart';
import 'package:email_validator/email_validator.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // Username Property
  String _username = "";
  bool _isUsernameValid = true;
  String _errorUsernameMessage = "";
  bool _isButtonNameValid = false;

  // Password Property
  String _password = "";
  bool _isPasswordValid = true;
  String _errorPasswordMessage = "";
  bool _isHidePassword = true;
  bool _isButtonPasswordValid = false;

  // Confirm Password Property
  String _confirmPassword = "";
  bool _isConfirmPasswordValid = true;
  String _errorConfirmPasswordMessage = "";
  bool _isHideConfirmPassword = true;
  bool _isButtonConfirmPasswordValid = false;

  // Telepon Property
  String _phoneNumber = "";
  bool _isPhoneNumberValid = true;
  String _errorPhoneNumberMessage = "";
  bool _isButtonPhoneNumberValid = false;

  // Email Property
  String _email = "";
  bool _isEmailValid = true;
  String _errorEmailMessage = "";
  bool _isButtonEmailValid = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Icon(
              Icons.flutter_dash_sharp,
              size: 100,
            ),
            const Text(
              'Register',
              style: TextStyle(fontSize: 50.0),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextFieldCustome(
                    hintText: 'Username',
                    onChanged: (value) {
                      _username = value;
                      if (_username.isEmpty) {
                        _isUsernameValid = false;
                        _isButtonNameValid = false;
                        _errorUsernameMessage = "Username Tidak Boleh Kosong!";
                      } else if (_username[0] != _username[0].toUpperCase()) {
                        _isUsernameValid = false;
                        _isButtonNameValid = false;

                        _errorUsernameMessage =
                            "Huruf petama harus diawali dengan kapital";
                      } else if (_username.length < 4) {
                        _isUsernameValid = false;
                        _isButtonNameValid = false;

                        _errorUsernameMessage =
                            "Username harus lebih dari 4 Huruf";
                      } else if (RegExp(r'^[a-z A-Z]+$').hasMatch(_username)) {
                        _isUsernameValid = false;
                        _isButtonNameValid = false;

                        _errorUsernameMessage = "Username harus memiliki angka";
                      } else {
                        _isButtonNameValid = true;
                        _isUsernameValid = true;
                      }
                      setState(() {});
                    },
                    isValidTextField: _isUsernameValid,
                    errorMessage: _errorUsernameMessage,
                  ),
                  TextFieldCustome(
                    onChanged: (value) {
                      _password = value;
                      if (_password.isEmpty) {
                        _errorPasswordMessage = "Password Tidak Boleh Kosong";
                        _isPasswordValid = false;
                        _isButtonPasswordValid = false;
                      } else if (_password[0] != _password[0].toUpperCase()) {
                        _errorPasswordMessage =
                            "Password harus di awali huruf Besar";
                        _isPasswordValid = false;
                        _isButtonPasswordValid = false;
                      } else if (_password.length < 4) {
                        _errorPasswordMessage = "Password harus lebih dari 4";
                        _isPasswordValid = false;
                        _isButtonPasswordValid = false;
                      } else if (RegExp(r'^[a-z A-Z]+$').hasMatch(_password)) {
                        _errorPasswordMessage =
                            "Password minimal memiliki angka";
                        _isPasswordValid = false;
                        _isButtonPasswordValid = false;
                      } else if (_password != _confirmPassword) {
                        _errorPasswordMessage = "Password tidak cocok";
                        _isPasswordValid = false;
                        _isButtonPasswordValid = false;
                      } else {
                        _isButtonPasswordValid = true;
                        _isPasswordValid = true;
                        _isConfirmPasswordValid = true;
                      }

                      setState(() {});
                    },
                    isObsucreText: _isHidePassword,
                    isValidTextField: _isPasswordValid,
                    errorMessage: _errorPasswordMessage,
                    hintText: 'Password',
                    suffixIconWidget: IconButton(
                      onPressed: () {
                        _isHidePassword = !_isHidePassword;
                        setState(() {});
                      },
                      icon: _isHidePassword
                          ? const Icon(Icons.lock)
                          : const Icon(
                              Icons.lock_open,
                            ),
                    ),
                  ),
                  TextFieldCustome(
                    onChanged: (value) {
                      _confirmPassword = value;
                      if (_confirmPassword != _password) {
                        _errorConfirmPasswordMessage = "Password tidak cocok";
                        _isConfirmPasswordValid = false;
                        _isButtonConfirmPasswordValid = false;
                      } else {
                        _isPasswordValid = true;
                        _isConfirmPasswordValid = true;
                        _isButtonConfirmPasswordValid = true;
                      }
                      setState(() {});
                    },
                    isObsucreText: _isHideConfirmPassword,
                    isValidTextField: _isConfirmPasswordValid,
                    errorMessage: _errorConfirmPasswordMessage,
                    hintText: 'Confirm Password',
                    suffixIconWidget: IconButton(
                      onPressed: () {
                        _isHideConfirmPassword = !_isHideConfirmPassword;
                        setState(() {});
                      },
                      icon: _isHideConfirmPassword
                          ? const Icon(Icons.lock)
                          : const Icon(
                              Icons.lock_open,
                            ),
                    ),
                  ),
                  IntlPhoneField(
                    initialCountryCode: 'ID',
                    invalidNumberMessage: 'Nomor Telepon Tidak Sesuai',
                    disableLengthCheck: true,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    onChanged: (PhoneNumber phoneNumber) {
                      _phoneNumber = phoneNumber.number;
                      if (_phoneNumber.isEmpty) {
                        _errorPhoneNumberMessage =
                            'Phone Number Tidak Boleh Kosong';
                        _isPhoneNumberValid = false;
                        _isButtonPhoneNumberValid = false;
                      } else if (_phoneNumber.length < 4) {
                        _errorPhoneNumberMessage =
                            'Nomor Telepon harus lebih dari 4 angka';
                        _isPhoneNumberValid = false;
                        _isButtonPhoneNumberValid = false;
                      } else {
                        _isPhoneNumberValid = true;
                        _isButtonPhoneNumberValid = true;
                      }
                      setState(() {});
                    },
                    decoration: InputDecoration(
                      hintText: 'Phone Number',
                      labelText: 'Phone Number',
                      errorText:
                          _isPhoneNumberValid ? null : _errorPhoneNumberMessage,
                    ),
                  ),
                  TextFieldCustome(
                    onChanged: (value) {
                      _email = value;
                      if (_email.isEmpty) {
                        _errorEmailMessage = "Email Tidak Boleh Kosong";
                        _isEmailValid = false;
                      } else if (!EmailValidator.validate(_email)) {
                        _errorEmailMessage = "Email Tidak Sesuai";
                        _isEmailValid = false;
                        _isButtonEmailValid = false;
                      } else {
                        _isEmailValid = true;
                        _isButtonEmailValid = true;
                      }

                      setState(() {});
                    },
                    isValidTextField: _isEmailValid,
                    errorMessage: _errorEmailMessage,
                    hintText: 'Email',
                  ),
                ],
              ),
            ),
            ButtonCustome(
              onPressed: _isButtonNameValid &&
                      _isButtonPasswordValid &&
                      _isButtonConfirmPasswordValid &&
                      _isButtonPhoneNumberValid &&
                      _isButtonEmailValid
                  ? () {}
                  : null,
              title: 'Register',
            )
          ],
        ),
      ),
    );
  }
}
