part of 'home_root_bloc.dart';

class HomeRootState extends Equatable {
  final NetworkStates state;
  final dynamic message;
  final bool isLoading;
  final int index;
  final UserModel? currentUser;

  const HomeRootState({
    this.state = NetworkStates.onLoading,
    this.message,
    this.isLoading = true,
    this.index = 0,
    this.currentUser,
  });

  HomeRootState copyWith({
    NetworkStates? state,
    dynamic message,
    bool? isLoading,
    int? index,
    UserModel? currentUser,
  }) {
    return HomeRootState(
      state: state ?? this.state,
      message: message ?? this.message,
      isLoading: isLoading ?? this.isLoading,
      index: index ?? this.index,
      currentUser: currentUser ?? this.currentUser,
    );
  }

  @override
  List<Object?> get props => [state, message, isLoading, index, currentUser];
}
