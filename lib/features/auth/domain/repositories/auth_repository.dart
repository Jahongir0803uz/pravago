import 'dart:io';

abstract class AuthRepository {
  Future<void> signIn({required String email, required String password, required bool isRememberMe,});
  Future<void> signUp({
    required String email,
    required String password,
    required String fullName,
    required String phoneNumber,
    File? imageFile,
  });
  Future<void> signOut();

  bool get isAuthenticated;

  Future<void> sendPasswordResetEmail(String email);
  Future<void> verifyPasswordResetCode({required String email, required String token});
  Future<void> updatePassword(String newPassword);
}
