import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
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

    print(response.data);

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

  // Post Contact
  Future<void> postContact(
    BuildContext context, {
    required String name,
    required String phone,
  }) async {
    try {
      final response = await Dio().post(
        "https://my-json-server.typicode.com/hadihammurabi/flutter-webservice/contacts",
        data: {
          "name": name,
          "phone": phone,
        },
      );

      if (response.statusCode == 201) {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Create Contact Berhasil',
            ),
          ),
        );
      }

      return;
    } on DioError catch (e) {
      if (e.response?.statusCode == 500) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Server Gagal',
            ),
          ),
        );
      } else if (e.response?.statusCode == 404) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Token Gagal',
            ),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              "Terjadi Kesalahan!",
            ),
          ),
        );
      }
    }
  }

  // Delete Contanct
  Future<void> deleteContact(
    BuildContext context, {
    required String idContact,
    required String name,
  }) async {
    try {
      final response = await Dio().delete(
        "https://my-json-server.typicode.com/hadihammurabi/flutter-webservice/contacts/$idContact",
      );

      if (response.statusCode == 200) {
        await getContact();
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              '$name Delete Contact Berhasil',
            ),
          ),
        );
      }
    } on DioError catch (e) {
      if (e.response?.statusCode == 500) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Server Gagal',
            ),
          ),
        );
      } else if (e.response?.statusCode == 404) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Token Gagal',
            ),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              "Terjadi Kesalahan!",
            ),
          ),
        );
      }
    }
  }

  // Update Contact
  Future<void> putContact(
    BuildContext context, {
    required String name,
    required String phone,
    required String idContact,
  }) async {
    try {
      final response = await Dio().put(
        "https://my-json-server.typicode.com/hadihammurabi/flutter-webservice/contacts/$idContact",
        data: {
          "name": name,
          "phone": phone,
        },
      );

      if (response.statusCode == 200) {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Update Contact Berhasil',
            ),
          ),
        );
      }
    } on DioError catch (e) {
      if (e.response?.statusCode == 500) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Server Gagal',
            ),
          ),
        );
      } else if (e.response?.statusCode == 404) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Token Gagal',
            ),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              "Terjadi Kesalahan!",
            ),
          ),
        );
      }
    }
  }
}
