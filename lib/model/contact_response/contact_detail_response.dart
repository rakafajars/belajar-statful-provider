// To parse this JSON data, do
//
//     final detailContactResponse = detailContactResponseFromJson(jsonString);

import 'dart:convert';

DetailContactResponse detailContactResponseFromJson(String str) =>
    DetailContactResponse.fromJson(json.decode(str));

String detailContactResponseToJson(DetailContactResponse data) =>
    json.encode(data.toJson());

class DetailContactResponse {
  DetailContactResponse({
    required this.id,
    required this.name,
    required this.phone,
  });

  int id;
  String name;
  String phone;

  factory DetailContactResponse.fromJson(Map<String, dynamic> json) =>
      DetailContactResponse(
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
