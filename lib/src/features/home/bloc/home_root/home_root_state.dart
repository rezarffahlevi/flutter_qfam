part of 'home_root_bloc.dart';

class HomeRootState extends Equatable {
  final NetworkStates state;
  final String? message;
  final dynamic error;
  final int index;

  const HomeRootState({
    this.state = NetworkStates.onLoading,
    this.message,
    this.error,
    this.index = 0,
  });

  HomeRootState copyWith({
    NetworkStates? state,
    String? message,
    dynamic error,
    int? index,
  }) {
    return HomeRootState(
      state: state ?? this.state,
      message: message ?? this.message,
      error: error ?? this.error,
      index: index ?? this.index,
    );
  }

  @override
  List<Object?> get props => [state, message, error, index];
}
