import 'dart:io';
import 'package:pravago/core/di/app_storage.dart';
import 'package:pravago/features/auth/data/models/user_model.dart';
import 'package:pravago/features/auth/domain/repositories/auth_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRepositoryImpl implements AuthRepository {
  final SupabaseClient _supabaseClient;
  final AppStorage _appStorage;

  AuthRepositoryImpl(this._supabaseClient, this._appStorage);

  @override
  Future<void> signIn({
    required String email,
    required String password,
    required bool isRememberMe,
  }) async {
    await _supabaseClient.auth.signInWithPassword(
      password: password,
      email: email,
    );
    await _appStorage.saveRememberMe(isRememberMe: isRememberMe, email: email);
  }

  @override
  Future<void> signOut() async {
    await _supabaseClient.auth.signOut();
  }

  @override
  @override
  Future<void> signUp({
    required String email,
    required String password,
    required String fullName,
    required String phoneNumber,
    File? imageFile,
  }) async {
    final response = await _supabaseClient.auth.signUp(
      password: password,
      email: email,
      data: {'full_name': fullName, 'phone_number': phoneNumber},
    );

    final user = response.user;
    if (user == null) {
      throw 'Ro\'yxatdan o\'tishda xatolik yuz berdi';
    }

    String? imageUrl;

    if (imageFile != null) {
      final fileExt = imageFile.path.split('.').last;
      final fileName =
          '${user.id}_${DateTime.now().millisecondsSinceEpoch}.$fileExt';

      await _supabaseClient.storage.from('avatars').upload(fileName, imageFile);
      imageUrl = _supabaseClient.storage.from('avatars').getPublicUrl(fileName);
    }

    final userModel = UserModel(
      id: user.id,
      fullName: fullName,
      email: email,
      phoneNumber: phoneNumber,
      profileImage: imageUrl,
    );

    await _supabaseClient.from('profiles').upsert(userModel.toJson());

    await _supabaseClient.auth.signOut();
  }

  @override
  bool get isAuthenticated => _supabaseClient.auth.currentSession != null;

  @override
  Future<void> sendPasswordResetEmail(String email) async {
    await _supabaseClient.auth.resetPasswordForEmail(email);
  }

  @override
  Future<void> updatePassword(String newPassword) async {
    await _supabaseClient.auth.updateUser(
      UserAttributes(password: newPassword),
    );
    await _supabaseClient.auth.signOut();
  }

  @override
  Future<void> verifyPasswordResetCode({
    required String email,
    required String token,
  }) async {
    await _supabaseClient.auth.verifyOTP(
      type: OtpType.recovery,
      email: email,
      token: token,
    );
  }
}
