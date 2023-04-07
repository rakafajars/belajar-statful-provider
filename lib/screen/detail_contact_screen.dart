import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_application_2/model/contact_response/contact_detail_response.dart';
import 'package:flutter_application_2/service/contact_service.dart';
import 'package:flutter_application_2/widget/button_custome.dart';
import 'package:flutter_application_2/widget/text_field_custome.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';

class DetailContactScreen extends StatefulWidget {
  final String idContact;
  const DetailContactScreen({
    super.key,
    required this.idContact,
  });

  @override
  State<DetailContactScreen> createState() => _DetailContactScreenState();
}

class _DetailContactScreenState extends State<DetailContactScreen> {
  // Username Property
  String _username = "";
  bool _isUsernameValid = true;
  String _errorUsernameMessage = "";
  bool _isButtonNameValid = false;

  // Telepon Property
  String _phoneNumber = "";
  bool _isPhoneNumberValid = true;
  String _errorPhoneNumberMessage = "";
  bool _isButtonPhoneNumberValid = false;

  // Loading Bar
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Update Contact",
        ),
      ),
      body: FutureBuilder(
        future: ContactService().getDetailContact(widget.idContact),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return formContact(
              name: snapshot.data?.name,
              phone: snapshot.data?.phone,
            );
          } else if (snapshot.hasError) {
            return const Text('Error');
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }

  SingleChildScrollView formContact({
    String? name,
    String? phone,
  }) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFieldCustome(
              initialValue: name ?? "",
              hintText: 'Name',
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

                  _errorUsernameMessage = "Username harus lebih dari 4 Huruf";
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
            IntlPhoneField(
              initialValue: phone ?? "",
              initialCountryCode: 'ID',
              invalidNumberMessage: 'Nomor Telepon Tidak Sesuai',
              disableLengthCheck: true,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              onChanged: (PhoneNumber phoneNumber) {
                _phoneNumber = phoneNumber.number;
                if (_phoneNumber.isEmpty) {
                  _errorPhoneNumberMessage = 'Phone Number Tidak Boleh Kosong';
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
            isLoading
                ? const CircularProgressIndicator()
                : ButtonCustome(
                    padding: EdgeInsets.zero,
                    onPressed: _isButtonNameValid && _isButtonPhoneNumberValid
                        ? () async {
                            isLoading = true;
                            setState(() {});
                            await ContactService().putContact(
                              context,
                              name: _username,
                              phone: _phoneNumber,
                              idContact: widget.idContact,
                            );
                            Future.delayed(const Duration(milliseconds: 500),
                                () {
                              isLoading = false;
                              setState(() {});
                            });
                          }
                        : null,
                    title: "Update Contact",
                  )
          ],
        ),
      ),
    );
  }
}
