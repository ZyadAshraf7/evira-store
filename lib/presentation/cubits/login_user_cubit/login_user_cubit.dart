import 'package:bloc/bloc.dart';
import 'package:evira_store/data/repositories/login_user/login_user_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

import '../../../data/shared_preference/user_preference.dart';

part 'login_user_state.dart';

class LoginUserCubit extends Cubit<LoginUserState> {
  LoginUserCubit() : super(LoginUserInitial());

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  LoginUserRepository loginUserRepository = LoginUserRepository();
  String errorMessage = "";
  Map<String,dynamic> data = {};
  final loginFormKey = GlobalKey<FormState>();
  Future<void>loginUser(String email,String password)async{
    emit(LoginUserLoading());
    try{
      data = await loginUserRepository.loginUser(email, password);
      print(data);
      if(data["idToken"]!=null){
        final token = data["idToken"];
        final email = data["email"];
        print(token);
        UserPreferences.setUserToken(token);
        UserPreferences.setUserEmail(email);
        emit(LoginUserDone());
        print("LOGIN SUCESSSSSSSS!!!!");
      }
    }catch(e){
      errorMessage = data['message'];
      print(e.toString());
      emit(LoginUserFailed());
    }
  }
}
