import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'auth_form_state.dart';

class AuthFormCubit extends Cubit<AuthFormState> {
  AuthFormCubit() : super(AuthFormInitial());
}
