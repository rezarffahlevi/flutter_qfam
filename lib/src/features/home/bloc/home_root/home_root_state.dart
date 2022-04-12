part of 'home_root_bloc.dart';

enum HomeRootStates {
  isLoading,
  onError,
}

class HomeRootState extends Equatable {
  final bool isLoading;
  final int index;

  const HomeRootState({
    this.isLoading = true,
    this.index = 0,
  });

  HomeRootState copyWith({
    bool? isLoading,
    int? index,
  }) {
    return HomeRootState(
      isLoading: isLoading ?? this.isLoading,
      index: index ?? this.index,
    );
  }

  @override
  List<Object?> get props => [isLoading, index];
}
