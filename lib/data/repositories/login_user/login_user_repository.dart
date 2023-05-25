import 'dart:convert';

import 'package:evira_store/core/constants/APIs.dart';
import 'package:evira_store/core/constants/exceptions.dart';
import 'package:http/http.dart' as http;
class LoginUserRepository {
  Future<Map<String,dynamic>>loginUser(String email,String password)async{
    try {
      final response = await http.post(Uri.parse(APIs.loginUserAPI),body: {
        "email":email,
        "password":password,
      });
      final data = jsonDecode(response.body);
      return data;
    }catch(e){
      print(e.toString());
      throw CustomException("Error while logging user");
    }
  }
}