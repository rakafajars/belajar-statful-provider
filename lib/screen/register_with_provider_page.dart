import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_2/provider/register_provider.dart';
import 'package:flutter_application_2/widget/button_custome.dart';
import 'package:flutter_application_2/widget/text_field_custome.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:provider/provider.dart';

class RegisterWithProviderPage extends StatelessWidget {
  const RegisterWithProviderPage({super.key});

  @override
  Widget build(BuildContext context) {
    RegisterProvider registerProvider = Provider.of<RegisterProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Register Provider'),
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
              'Register Provider',
              style: TextStyle(fontSize: 50.0),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextFieldCustome(
                    hintText: 'Username',
                    onChanged: (value) {
                      registerProvider.validateUsername(value);
                    },
                    isValidTextField: registerProvider.isUsernameValid,
                    errorMessage: registerProvider.errorUsernameMessage,
                  ),
                  TextFieldCustome(
                    onChanged: (value) {
                      registerProvider.validatePassword(value);
                    },
                    isObsucreText: registerProvider.isHidePassword,
                    isValidTextField: registerProvider.isPasswordValid,
                    errorMessage: registerProvider.errorPasswordMessage,
                    hintText: 'Password',
                    suffixIconWidget: IconButton(
                      onPressed: () {
                        registerProvider.showHidePassword();
                      },
                      icon: registerProvider.isHidePassword
                          ? const Icon(
                              Icons.lock,
                            )
                          : const Icon(
                              Icons.lock_open,
                            ),
                    ),
                  ),
                  TextFieldCustome(
                    onChanged: (value) {
                      registerProvider.validateConfirmPassword(value);
                    },
                    isObsucreText: registerProvider.isHideConfirmPassword,
                    isValidTextField: registerProvider.isConfirmPasswordValid,
                    errorMessage: registerProvider.errorConfirmPasswordMessage,
                    hintText: 'Confirm Password',
                    suffixIconWidget: IconButton(
                      onPressed: () {
                        registerProvider.showHideConfirmPassword();
                      },
                      icon: registerProvider.isHideConfirmPassword
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
                      registerProvider.validatePhoneNumber(phoneNumber);
                    },
                    decoration: InputDecoration(
                      hintText: 'Phone Number',
                      labelText: 'Phone Number',
                      errorText: registerProvider.isPhoneNumberValid
                          ? null
                          : registerProvider.errorPhoneNumberMessage,
                    ),
                  ),
                  TextFieldCustome(
                    onChanged: (value) {
                      registerProvider.validateEmail(value);
                    },
                    isValidTextField: registerProvider.isEmailValid,
                    errorMessage: registerProvider.errorEmailMessage,
                    hintText: 'Email',
                  ),
                ],
              ),
            ),
            ButtonCustome(
              onPressed:
                  registerProvider.disableButtonRegister() ? () {} : null,
              title: 'Register',
            )
          ],
        ),
      ),
    );
  }
}
