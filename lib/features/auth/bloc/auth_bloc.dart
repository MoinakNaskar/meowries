import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:memow/models/user_modell.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<SignUpButtonClicked>(signUpButtonClicked);
  }
  void signUpButtonClicked(SignUpButtonClicked event, Emitter<AuthState> emit) {
    emit(AuthLoading());
  }
}
