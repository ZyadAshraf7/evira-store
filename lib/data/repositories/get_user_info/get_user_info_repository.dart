import 'dart:convert';
import 'package:evira_store/core/constants/APIs.dart';
import 'package:evira_store/core/constants/exceptions.dart';
import 'package:evira_store/data/shared_preference/user_preference.dart';
import 'package:http/http.dart' as http;
class GetUserInfoRepository {
  Future<Map<String, dynamic>> getUserInfo(String userToken)async {
    final token = await UserPreferences.getUserToken();
    try{
      final response =await http.post(Uri.parse(APIs.getUserDataAPI),body: {
        "idToken": token,
      });
      final data = jsonDecode(response.body);
      return data;
    }catch(e){
      throw CustomException(e.toString());
    }
  }
}
