import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_application_2/model/contact_response/contact_detail_response.dart';
import 'package:flutter_application_2/model/contact_response/list_contact_response.dart';

class ContactService {
  // Get Contact
  Future<List<ListContactResponse>> getContact() async {
    final response = await Dio().get(
      'https://my-json-server.typicode.com/hadihammurabi/flutter-webservice/contacts',
    );

    List<ListContactResponse> contacts = (response.data as List)
        .map(
          (e) => ListContactResponse(
            id: e["id"],
            name: e["name"],
            phone: e["phone"],
          ),
        )
        .toList();

    return contacts;
  }

  // Detail Contact
  Future<DetailContactResponse> getDetailContact(
    String idContact,
  ) async {
    final response = await Dio().get(
      'https://my-json-server.typicode.com/hadihammurabi/flutter-webservice/contacts/$idContact',
    );

    return DetailContactResponse.fromJson(response.data);
  }

  // Delete Contanct

  // Update Contact
}
