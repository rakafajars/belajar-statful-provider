import 'package:dio/dio.dart';
import 'package:flutter_application_2/model/list_category_resep_response.dart';

class ReceipeService {
  Future<ListCategoryResepResponse> getReceipe() async {
    final response = await Dio().get(
      'https://masak-apa-tomorisakura.vercel.app/api/category/article',
    );

    return ListCategoryResepResponse.fromJson(response.data);
  }
}
