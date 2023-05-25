part of 'login_user_cubit.dart';

@immutable
abstract class LoginUserState {}

class LoginUserInitial extends LoginUserState {}

class LoginUserLoading extends LoginUserState {}

class LoginUserDone extends LoginUserState {}

class LoginUserFailed extends LoginUserState {}
