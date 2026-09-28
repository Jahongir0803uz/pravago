part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class SignInSuccess extends AuthState {}

class SignUpSuccess extends AuthState {}

class AuthError extends AuthState {
  final String message;
  const AuthError(this.message);
  @override
  List<Object?> get props => [message];
}

class ResetCodeSentSuccess extends AuthState {}

class OtpVerifiedSuccess extends AuthState {}

class PasswordResetSuccess extends AuthState {}
