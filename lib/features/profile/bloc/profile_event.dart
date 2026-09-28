part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object?> get props => [];
}

class GetProfileEvent extends ProfileEvent {}

class UpdateProfileEvent extends ProfileEvent {
  final String fullName;
  final String phoneNumber;
  final String? profileImage;

  const UpdateProfileEvent({
    required this.fullName,
    required this.phoneNumber,
    this.profileImage,
  });

  @override
  List<Object?> get props => [fullName, phoneNumber, profileImage];
}

class LogoutEvent extends ProfileEvent {}

class DeleteAccountEvent extends ProfileEvent {}
