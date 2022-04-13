part of 'profile_bloc.dart';
class ProfileState extends Equatable {
  final NetworkStates state;

  const ProfileState({
    this.state = NetworkStates.onLoading,
  });

  ProfileState copyWith({
    NetworkStates? state,
  }) {
    return ProfileState(
      state: state ?? this.state,
    );
  }

  @override
  List<Object?> get props => [state];
}
