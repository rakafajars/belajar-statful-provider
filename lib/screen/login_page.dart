import 'package:flutter/material.dart';
import 'package:flutter_application_2/screen/register_page.dart';
import 'package:flutter_application_2/utils/first_capitalize_utils.dart';
import 'package:flutter_application_2/widget/button_custome.dart';
import 'package:flutter_application_2/widget/text_field_custome.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Username Property
  String _username = "";
  bool _isUsernameValid = true;
  String _errorUsernameMessage = "";

  // Password Property
  String _password = "";
  bool _isPasswordValid = true;
  String _errorPasswordMessage = "";
  bool _isHidePassword = true;

  // Button Prorerty
  bool _isButtonUsernameDisable = false;
  bool _isButtonPasswordDisable = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Icon(
              Icons.flutter_dash_sharp,
              size: 100,
            ),
            const Text(
              'Login',
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
                        _isButtonUsernameDisable = false;

                        _errorUsernameMessage = "Username Tidak Boleh Kosong!";
                      }
                      // else if (_username[0] != _username[0].toUpperCase()) {
                      //   _isUsernameValid = true;
                      //   _errorUsernameMessage =
                      //       "Huruf petama harus diawali dengan kapital";
                      // }
                      else if (_username.length < 4) {
                        _isUsernameValid = false;
                        _isButtonUsernameDisable = false;

                        _errorUsernameMessage =
                            "Username harus lebih dari 4 Huruf";
                      }
                      //else if (RegExp(r'^[a-z A-Z]+$').hasMatch(value)) {
                      //   _isUsernameValid = true;
                      //   _errorUsernameMessage = "Username harus memiliki angka";
                      // }
                      else {
                        _isUsernameValid = true;
                        _isButtonUsernameDisable = true;
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
                        _isButtonPasswordDisable = false;
                      } else {
                        _isPasswordValid = true;
                        _isButtonPasswordDisable = true;
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
                  const SizedBox(height: 16),
                  Align(
                    alignment: Alignment.topRight,
                    child: GestureDetector(
                      onTap: () {},
                      child: const Text(
                        'Forgot Password?',
                        style: TextStyle(fontSize: 14.0, color: Colors.blue),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ButtonCustome(
              onPressed: _isButtonUsernameDisable && _isButtonPasswordDisable
                  ? () {}
                  : null,
              isIcon: true,
              icon: const Icon(Icons.abc),
              title: 'Login',
              padding: const EdgeInsets.all(24),
            ),
            ButtonCustome(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const RegisterPage(),
                  ),
                );
              },
              title: 'Register',
            )
          ],
        ),
      ),
    );
  }
}
