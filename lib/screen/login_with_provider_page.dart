import 'package:flutter/material.dart';
import 'package:flutter_application_2/provider/login_provider.dart';
import 'package:flutter_application_2/widget/button_custome.dart';
import 'package:provider/provider.dart';

import '../widget/text_field_custome.dart';

class LoginPageScreenWithProvider extends StatelessWidget {
  const LoginPageScreenWithProvider({super.key});

  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<LoginProvider>(context);
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
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextFieldCustome(
                    hintText: 'Username',
                    onChanged: (value) {
                      loginProvider.validateUsername(value);
                    },
                    isValidTextField: loginProvider.isUsernameValid,
                    errorMessage: loginProvider.errorUsernameMessage,
                  ),
                  TextFieldCustome(
                    onChanged: (value) {
                      loginProvider.validatePassword(value);
                    },
                    isObsucreText: loginProvider.isHidePassword,
                    isValidTextField: loginProvider.isPasswordValid,
                    errorMessage: loginProvider.errorPasswordMessage,
                    hintText: 'Password',
                    suffixIconWidget: IconButton(
                      onPressed: () {
                        loginProvider.showHidePassword();
                      },
                      icon: loginProvider.isHidePassword
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
              onPressed: loginProvider.isButtonUsernameDisable &&
                      loginProvider.isButtonPasswordDisable
                  ? () {
                      loginProvider.navigateToDashboard(context);
                    }
                  : null,
              isIcon: true,
              icon: const Icon(Icons.abc),
              title: 'Login',
              padding: const EdgeInsets.all(24),
            ),
            ButtonCustome(
              onPressed: () {
                loginProvider.navigateToRegisterPage(context);
              },
              title: 'Register',
            )
          ],
        ),
      ),
    );
  }
}
