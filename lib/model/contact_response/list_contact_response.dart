// To parse this JSON data, do
//
//     final listContactResponse = listContactResponseFromJson(jsonString);

import 'dart:convert';

List<ListContactResponse> listContactResponseFromJson(String str) =>
    List<ListContactResponse>.from(
      json.decode(str).map(
            (x) => ListContactResponse.fromJson(x),
          ),
    );

String listContactResponseToJson(List<ListContactResponse> data) => json.encode(
      List<dynamic>.from(
        data.map(
          (x) => x.toJson(),
        ),
      ),
    );

class ListContactResponse {
  ListContactResponse({
    this.id,
    this.name,
    this.phone,
  });

  int? id;
  String? name;
  String? phone;

  factory ListContactResponse.fromJson(Map<String, dynamic> json) =>
      ListContactResponse(
        id: json["id"],
        name: json["name"],
        phone: json["phone"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "phone": phone,
      };
}
