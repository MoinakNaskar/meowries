part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class SignUpButtonClicked extends AuthEvent {
  final int mobileNumber;
  final String name;
  final String password;
  final String emailId;
  final String userName;

  const SignUpButtonClicked(
      {required this.mobileNumber,
      required this.name,
      required this.password,
      required this.emailId,
      required this.userName});
}

class LoginButtonClicked extends AuthEvent {
  final String email;
  final String password;

  const LoginButtonClicked({required this.email, required this.password});
}
