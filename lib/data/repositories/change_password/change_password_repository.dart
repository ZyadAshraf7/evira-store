import 'dart:convert';

import 'package:evira_store/core/constants/APIs.dart';
import 'package:http/http.dart' as http;

import '../../shared_preference/user_preference.dart';
class ChangePasswordRepository {
  changeUserPassword(String newPassword)async{
    try {
      final token = UserPreferences.getUserToken();
      final response = await http.post(
          Uri.parse(APIs.changePasswordAPI), body: {
        "idToken": token,
        "password": newPassword,
      });
      final data = jsonDecode(response.body);
      return data;
    }catch(e){
      print(e.toString());
    }
  }
}