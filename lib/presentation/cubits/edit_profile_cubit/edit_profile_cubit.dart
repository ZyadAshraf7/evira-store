import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evira_store/data/repositories/change_password/change_password_repository.dart';
import 'package:evira_store/data/shared_preference/user_preference.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

part 'edit_profile_state.dart';

class EditProfileCubit extends Cubit<EditProfileState> {
  EditProfileCubit() : super(EditProfileInitial());
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirmController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  ChangePasswordRepository changePasswordRepository = ChangePasswordRepository();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final editProfileFormKey = GlobalKey<FormState>();

  editProfile()async{
    try {
      if (passwordConfirmController.text.isNotEmpty) {
        emit(EditProfileLoading());
        _firestore.collection('users')
            .doc(UserPreferences.getUserEmail())
            .update(
            {
              'name': nameController.text,
              'phoneNumber': phoneNumberController.text,
              "password":passwordController.text,
            });
        print("password ${passwordConfirmController.text}");
        await changePassword(passwordConfirmController.text);
        emit(EditProfileDone());
      }
    }catch(e){
      print("error in cubitttt");
      print(e.toString());
      emit(EditProfileFailed());
    }
  }
  changePassword(String newPassword){
    changePasswordRepository.changeUserPassword(newPassword);
  }

  String? validatePassword(String? value) {
    const passwordMinLength = 6;
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < passwordMinLength) {
      return 'Password must be at least $passwordMinLength characters long';
    }
    return null;
  }
  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Name is required';
    }
    return null;
  }
  String? validateConfirmPassword(String? password,String? confirmPassword) {
    if (password !=confirmPassword && (confirmPassword!=null || confirmPassword!.isNotEmpty)) {
      return "Passwords don't match";
    }
    return null;
  }
  String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone Number is required';
    }
    return null;
  }
}
