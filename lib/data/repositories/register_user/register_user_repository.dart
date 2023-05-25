import 'dart:convert';

import 'package:evira_store/core/constants/APIs.dart';
import 'package:evira_store/core/constants/exceptions.dart';
import 'package:http/http.dart' as http;
import '../../models/user.dart';

class RegisterUserRepository {
  Future<Map<String, dynamic>> createNewUser(String email,String password) async {
    try {
      final response = await http.post(Uri.parse(APIs.createUserAPI), body: {
        "email": email,
        "password": password,
      });
      final data = await jsonDecode(response.body);
      return data;
    }catch(e){
      print(e.toString());
      throw CustomException("Error while creating new user");
    }
  }
}
