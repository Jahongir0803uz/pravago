import 'package:pravago/features/auth/data/models/user_model.dart';

abstract class ProfileRepository {

  Future<UserModel> getUserProfile();

  Future<UserModel> updateUserProfile({
    required String fullName,
    required String phoneNumber,
    String? profileImage,
  });

  Future<void> signOut();

  Future<void> deleteAccount();
}
