import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../core/constants/APIs.dart';

class SearchProductRepository {
  searchProduct(String searchKeyword)async{
    try {
      final response = await http.get(
          Uri.parse("${APIs.searchProducts}$searchKeyword"));
      final data = jsonDecode(response.body);
      return data;
    }catch(e){
      print(e.toString());
    }
  }
}