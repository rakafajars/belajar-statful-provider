import 'package:flutter/material.dart';
import 'package:flutter_application_2/widget/text_field_custome.dart';

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

  // Password Property
  String _password = "";
  bool _isPasswordValid = true;
  String _errorPasswordMessage = "";
  bool _isHidePassword = true;

  // Password Property
  String _confirmPassword = "";
  bool _isConfirmPasswordValid = true;
  String _errorConfirmPasswordMessage = "";
  bool _isHideConfirmPassword = true;

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

                        _errorUsernameMessage = "Username Tidak Boleh Kosong!";
                      } else if (_username[0] != _username[0].toUpperCase()) {
                        _isUsernameValid = false;
                        _errorUsernameMessage =
                            "Huruf petama harus diawali dengan kapital";
                      } else if (_username.length < 4) {
                        _isUsernameValid = false;

                        _errorUsernameMessage =
                            "Username harus lebih dari 4 Huruf";
                      } else if (RegExp(r'^[a-z A-Z]+$').hasMatch(_username)) {
                        _isUsernameValid = false;
                        _errorUsernameMessage = "Username harus memiliki angka";
                      } else {
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
                      } else if (_password[0] != _password[0].toUpperCase()) {
                        _errorPasswordMessage =
                            "Password harus di awali huruf Besar";
                        _isPasswordValid = false;
                      } else if (_password.length < 4) {
                        _errorPasswordMessage = "Password harus lebih dari 4";
                        _isPasswordValid = false;
                      } else if (RegExp(r'^[a-z A-Z]+$').hasMatch(_password)) {
                        _errorPasswordMessage =
                            "Password minimal memiliki angka";
                        _isPasswordValid = false;
                      } else if (_password != _confirmPassword) {
                        _errorPasswordMessage = "Password tidak cocok";
                        _isPasswordValid = false;
                      } else {
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
                      } else {
                        _isPasswordValid = true;
                        _isConfirmPasswordValid = true;
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
                  TextField(
                    keyboardType: TextInputType.text,
                    onChanged: (value) {},
                    decoration: const InputDecoration(
                      hintText: 'Nomor Telepon',
                      labelText: 'Nomor Telepon',
                    ),
                  ),
                  TextField(
                    keyboardType: TextInputType.text,
                    onChanged: (value) {},
                    decoration: const InputDecoration(
                      hintText: 'Email',
                      labelText: 'Email',
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ElevatedButton(
                onPressed: () {},
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
