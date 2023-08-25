import 'dart:convert';

import 'package:http/http.dart' as http;
class GetHomeCategoriesRepository{
  
  Future<List<dynamic>>fetchHomeCategories(String category)async{
    try {
      final response = await http.get(Uri.parse(
          "https://1468-102-188-85-200.ngrok-free.app/products/$category"));
      final responseData = jsonDecode(response.body);
      return responseData;
    }catch(e){
      print(e.toString());
      return [];
    }
  }
}