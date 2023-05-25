import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evira_store/data/models/response_error.dart';
import 'package:evira_store/data/repositories/register_user/register_user_repository.dart';
import 'package:evira_store/data/shared_preference/user_preference.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';

import '../../../data/models/user.dart';

part 'register_user_state.dart';

class RegisterUserCubit extends Cubit<RegisterUserState> {
  RegisterUserCubit() : super(RegisterUserInitial());
  late UserModel newUser;
  RegisterUserRepository registerUserRepository = RegisterUserRepository();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final completeProfileFormKey = GlobalKey<FormState>();
  bool passwordObsecure= true;

  String userImageUrl = "https://firebasestorage.googleapis.com/v0/b/evira-store.appspot.com/o/Ellipse.png?alt=media&token=524915b1-a1a4-495a-a042-6ba9f94cd4d1";
   String errorMessage = "";
  Future<void>createNewUser(UserModel user)async{
    emit(CreateUserLoading());
    try {
      final data = await registerUserRepository.createNewUser(user.email!,user.password!);
      print("data register ${data}");

      if(data["idToken"]!= null){
        final token =data["idToken"];
        UserPreferences.setUserToken(token);
        final response = await FirebaseFirestore.instance.collection("users").doc(user.email).set(user.toJson());
        print("response done");
        print("Create User Success");
        emit(CreateUserDone());
      }else{
        final error = ResponseError.fromJson(data);
        errorMessage = error.error!.message!;
      }
    }catch(e){
      emit(CreateUserFailed());
      errorMessage = e.toString();
      print(e.toString());
    }
  }

  String? validateEmail(String ?value){
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$'); // Validate email is valid using RegEx
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    if (!emailRegex.hasMatch(value)) {
      return 'Invalid email format';
    }
    return null;
  }
  String? validatePassword(String? value) {
    const passwordMinLength = 4;
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
  String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone Number is required';
    }
    return null;
  }
  void tooglePasswordObsecure(){
    passwordObsecure=!passwordObsecure;
    print(passwordObsecure);
  }
  uploadProfilePicture() async {
    final _picker = ImagePicker();
    PickedFile? _imageFile;
    String? _uploadedFileURL;

    try {
      // Get the image file from the user's phone storage
      _imageFile = await _picker.getImage(source: ImageSource.gallery);
      // Upload the image file to Firebase Storage
      emit(UploadPhotoLoading());
      FirebaseStorage storage = FirebaseStorage.instance;
      Reference ref = storage.ref().child("user_profile/${const Uuid().v1()}.jpg");
      UploadTask uploadTask = ref.putFile(File(_imageFile!.path));
      TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
      userImageUrl = await taskSnapshot.ref.getDownloadURL();
      emit(UploadPhotoDone());
    } catch (e) {
      print(e.toString());
      emit(UploadPhotoFailed());
    }
  }
}
