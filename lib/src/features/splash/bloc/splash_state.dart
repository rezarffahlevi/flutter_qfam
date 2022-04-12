part of 'splash_bloc.dart';

class SplashState extends Equatable {
  final bool isLoading;

  const SplashState({
    this.isLoading = true,
  });

  SplashState copyWith({
    bool? isLoading,
  }) {
    return SplashState(
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [isLoading];
}
