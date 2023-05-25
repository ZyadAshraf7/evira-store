import 'dart:convert';

import 'package:evira_store/core/constants/APIs.dart';
import 'package:evira_store/core/constants/exceptions.dart';
import 'package:http/http.dart' as http;
class GetCategoryProductsRepository {
  getCategoryProducts(String category)async{
    try {
      final response = await http.get(
          Uri.parse("${APIs.getCategoryProducts}${category.toLowerCase()}"));
      final data = jsonDecode(response.body);
      return data;
    }catch(e){
      throw CustomException(e.toString());
    }
  }
}