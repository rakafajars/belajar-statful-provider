import 'package:flutter/material.dart';
import 'package:flutter_application_2/screen/register_page.dart';
import 'package:flutter_application_2/utils/first_capitalize_utils.dart';

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
                  TextField(
                    keyboardType: TextInputType.text,
                    onChanged: (value) {
                      _username = value;
                      if (_username.isEmpty) {
                        _isUsernameValid = false;
                        _errorUsernameMessage = "Username Tidak Boleh Kosong!";
                      }
                      // else if (_username[0] != _username[0].toUpperCase()) {
                      //   _isUsernameValid = true;
                      //   _errorUsernameMessage =
                      //       "Huruf petama harus diawali dengan kapital";
                      // }
                      else if (_username.length < 4) {
                        _isUsernameValid = false;
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
                    decoration: InputDecoration(
                      hintText: 'Username',
                      labelText: 'Username',
                      errorText:
                          _isUsernameValid ? null : _errorUsernameMessage,
                    ),
                  ),
                  TextField(
                    keyboardType: TextInputType.text,
                    onChanged: (value) {
                      _password = value;
                      if (_password.isEmpty) {
                        _errorPasswordMessage = "Password Tidak Boleh Kosong";
                        _isPasswordValid = false;
                      } else {
                        _isPasswordValid = true;
                        _isButtonPasswordDisable = true;
                      }
                      setState(() {});
                    },
                    obscureText: _isHidePassword,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      labelText: 'Password',
                      errorText:
                          _isPasswordValid ? null : _errorPasswordMessage,
                      suffixIcon: IconButton(
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ElevatedButton(
                onPressed: _isButtonUsernameDisable && _isButtonPasswordDisable
                    ? () {}
                    : null,
                child: const Text(
                  'Login',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const RegisterPage(),
                    ),
                  );
                },
                child: const Text(
                  'Register',
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
