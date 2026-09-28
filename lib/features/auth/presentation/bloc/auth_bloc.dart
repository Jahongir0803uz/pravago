import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pravago/features/auth/domain/repositories/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;

  AuthBloc({required AuthRepository authRepository})
    : _authRepository = authRepository,
      super(AuthInitial()) {
    on<SignInRequested>(_onSignIn);
    on<SignUpRequested>(_onSignUp);
    on<SendResetCodeRequested>(_onSendResetCode);
    on<VerifyOTPRequested>(_onVerifyOTP);
    on<ResetPasswordRequested>(_onResetPassword);
  }

  Future<void> _onSignIn(SignInRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await _authRepository.signIn(
        email: event.email,
        password: event.password,
        isRememberMe: event.isRememberMe
      );
      emit(SignInSuccess());
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _onSignUp(SignUpRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await _authRepository.signUp(
        email: event.email,
        password: event.password,
        fullName: event.fullName,
        phoneNumber: event.phoneNumber,
        imageFile: event.imageFile,
      );
      emit(SignUpSuccess());
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _onSendResetCode(
    SendResetCodeRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      await _authRepository.sendPasswordResetEmail(event.email);
      emit(ResetCodeSentSuccess());
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _onVerifyOTP(
    VerifyOTPRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      await _authRepository.verifyPasswordResetCode(
        email: event.email,
        token: event.token,
      );
      emit(OtpVerifiedSuccess());
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _onResetPassword(
    ResetPasswordRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      await _authRepository.updatePassword(event.newPassword);
      emit(PasswordResetSuccess());
    } catch(e) {
      emit(AuthError(e.toString()));
    }
  }
}
