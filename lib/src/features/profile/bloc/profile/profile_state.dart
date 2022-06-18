part of 'profile_bloc.dart';

class ProfileState extends Equatable {
  final NetworkStates state;
  final dynamic message;
  final UserModel? currentUser;

  const ProfileState({
    this.state = NetworkStates.onLoading,
    this.message,
    this.currentUser,
  });

  ProfileState copyWith({
    NetworkStates? state,
    dynamic message,
    UserModel? currentUser,
  }) {
    return ProfileState(
      state: state ?? this.state,
      message: message ?? this.message,
      currentUser: currentUser ?? this.currentUser,
    );
  }

  @override
  List<Object?> get props => [state, message, currentUser];
}
