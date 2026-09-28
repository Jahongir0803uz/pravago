import 'package:pravago/features/auth/data/models/user_model.dart';
import 'package:pravago/features/profile/domain/repository/profile_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final SupabaseClient _supabaseClient;

  ProfileRepositoryImpl(this._supabaseClient);

  @override
  Future<void> deleteAccount() async {
    await _supabaseClient.rpc('delete_user_account');
    await _supabaseClient.auth.signOut();
  }

  @override
  Future<UserModel> getUserProfile() async {
    final user = _supabaseClient.auth.currentUser;
    if (user == null) {
      throw Exception('User not authenticated');
    }

    final response = await _supabaseClient
        .from('profiles')
        .select()
        .eq('id', user.id)
        .single();
    return UserModel.fromJson(response);
  }

  @override
  Future<void> signOut() async {
    await _supabaseClient.auth.signOut();
  }

  @override
  Future<UserModel> updateUserProfile({
    required String fullName,
    required String phoneNumber,
    String? profileImage,
  }) async {
    final user = _supabaseClient.auth.currentUser;
    if (user == null) {
      throw Exception('User not authenticated');
    }
    final updates = {'full_name': fullName, 'phone_number': phoneNumber};
    if (profileImage != null) {
      updates['profile_image'] = profileImage;
    }
    final response = await _supabaseClient
        .from('profiles')
        .update(updates)
        .eq('id', user.id)
        .select()
        .single();
    return UserModel.fromJson(response);
  }
}
