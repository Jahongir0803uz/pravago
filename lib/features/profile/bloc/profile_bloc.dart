import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pravago/features/auth/data/models/user_model.dart';
import 'package:pravago/features/profile/domain/repository/profile_repository.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileRepository _profileRepository;

  ProfileBloc(this._profileRepository) : super(ProfileInitial()) {
    on<GetProfileEvent>(_onGetProfile);
    on<UpdateProfileEvent>(_onUpdateProfile);
    on<LogoutEvent>(_onLogout);
    on<DeleteAccountEvent>(_onDeleteAccount);
  }

  Future<void> _onGetProfile(
    GetProfileEvent event,
    Emitter<ProfileState> emit,
  ) async {
    emit(ProfileLoading());
    try {
      final user = await _profileRepository.getUserProfile();
      emit(ProfileLoaded(user));
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }

  Future<void> _onUpdateProfile(
    UpdateProfileEvent event,
    Emitter<ProfileState> emit,
  ) async {
    emit(ProfileLoading());
    try {
      final updateUser = await _profileRepository.updateUserProfile(
        fullName: event.fullName,
        phoneNumber: event.phoneNumber,
        profileImage: event.profileImage,
      );
      emit(ProfileLoaded(updateUser));
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }

  Future<void> _onLogout(LogoutEvent event, Emitter<ProfileState> emit) async {
    emit(ProfileLoading());
    try {
      await _profileRepository.signOut();
      emit(ProfileUnauthenticated());
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }

  Future<void> _onDeleteAccount(
    DeleteAccountEvent event,
    Emitter<ProfileState> emit,
  ) async {
    emit(ProfileLoading());
    try {
      await _profileRepository.deleteAccount();
      emit(ProfileUnauthenticated());
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }
}
