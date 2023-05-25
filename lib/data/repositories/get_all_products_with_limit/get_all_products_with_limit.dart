import 'dart:convert';

import 'package:evira_store/core/constants/APIs.dart';
import 'package:evira_store/core/constants/exceptions.dart';
import 'package:http/http.dart' as http;

class GetAllProductsWithLimitRepository {
  Future<dynamic> getAllProductsWithLimits() async {
    try {
      final response = await http.get(Uri.parse(APIs.getAllProductsWithLimit));
      final data = jsonDecode(response.body);
      // print(data);
      return data;
    } catch (e) {
      throw CustomException(e.toString());
    }
  }
}
