import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evira_store/data/models/user.dart';
import 'package:evira_store/data/shared_preference/user_preference.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'get_user_info_state.dart';

class GetUserInfoCubit extends Cubit<GetUserInfoState> {
  GetUserInfoCubit() : super(GetUserInfoInitial());

  UserModel currentUser = UserModel();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> getUserInfo() async {
    emit(GetUserInfoLoading());
    try {
      print("!! ${UserPreferences.getUserEmail()}");
      final data =
          await _firestore.collection("users").doc(UserPreferences.getUserEmail()).get();
      if (data.data() != null) {
        currentUser = UserModel.fromJson(data.data()!);
        print(currentUser.name);
        emit(GetUserInfoDone());
      }
    } catch (e) {
      emit(GetUserInfoFailed());
      print(e.toString());
    }
  }
}
