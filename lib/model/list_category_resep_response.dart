// To parse this JSON data, do
//
//     final listCategoryResepResponse = listCategoryResepResponseFromJson(jsonString);

import 'dart:convert';

ListCategoryResepResponse listCategoryResepResponseFromJson(String str) =>
    ListCategoryResepResponse.fromJson(json.decode(str));

String listCategoryResepResponseToJson(ListCategoryResepResponse data) =>
    json.encode(data.toJson());

class ListCategoryResepResponse {
  ListCategoryResepResponse({
    required this.method,
    required this.status,
    required this.results,
  });

  String method;
  bool status;
  List<DataCategory> results;

  factory ListCategoryResepResponse.fromJson(Map<String, dynamic> json) =>
      ListCategoryResepResponse(
        method: json["method"],
        status: json["status"],
        results: List<DataCategory>.from(
            json["results"].map((x) => DataCategory.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "method": method,
        "status": status,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
      };
}

class DataCategory {
  DataCategory({
    required this.title,
    required this.key,
  });

  String title;
  String key;

  factory DataCategory.fromJson(Map<String, dynamic> json) => DataCategory(
        title: json["title"],
        key: json["key"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "key": key,
      };
}
