part of 'splash_bloc.dart';

class SplashState extends Equatable {
  final bool isLoading;
  final VersionModel? version;

  const SplashState({
    this.isLoading = true,
    this.version,
  });

  SplashState copyWith({
    bool? isLoading,
    VersionModel? version,
  }) {
    return SplashState(
      isLoading: isLoading ?? this.isLoading,
      version: version ?? this.version,
    );
  }

  @override
  List<Object?> get props => [isLoading, version];
}
