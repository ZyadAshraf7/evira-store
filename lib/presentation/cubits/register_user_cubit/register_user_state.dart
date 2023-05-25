part of 'register_user_cubit.dart';

@immutable
abstract class RegisterUserState {}

class RegisterUserInitial extends RegisterUserState {}

class UploadPhotoLoading extends RegisterUserState {}

class UploadPhotoDone extends RegisterUserState {}

class UploadPhotoFailed extends RegisterUserState {}

class CreateUserLoading extends RegisterUserState {}

class CreateUserDone extends RegisterUserState {}

class CreateUserFailed extends RegisterUserState {}
