part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class SignInRequested extends AuthEvent {
  final bool isRememberMe;
  final String email;
  final String password;

  const SignInRequested({required this.email, required this.password, required this.isRememberMe});

  @override
  List<Object?> get props => [email, password];
}

class SignUpRequested extends AuthEvent {
  final String fullName;
  final String email;
  final String password;
  final String phoneNumber;
  final File? imageFile;

  const SignUpRequested({
    required this.fullName,
    required this.email,
    required this.password,
    required this.phoneNumber,
    this.imageFile,
  });

  @override
  List<Object?> get props => [
    fullName,
    email,
    password,
    phoneNumber,
    imageFile,
  ];
}

class SendResetCodeRequested extends AuthEvent {
  final String email;

  const SendResetCodeRequested(this.email);

  @override
  List<Object?> get props => [email];
}

class VerifyOTPRequested extends AuthEvent {
  final String email;
  final String token;

  const VerifyOTPRequested({required this.email, required this.token});

  @override
  List<Object?> get props => [email, token];
}

class ResetPasswordRequested extends AuthEvent {
  final String newPassword;

  const ResetPasswordRequested(this.newPassword);

  @override
  List<Object?> get props => [newPassword];
}
