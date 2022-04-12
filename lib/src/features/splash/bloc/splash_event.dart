part of 'splash_bloc.dart';

abstract class SplashEvent extends Equatable {
  const SplashEvent();

  @override
  List<Object?> get props => [];
}

class SplashEventInit extends SplashEvent {
  final bool isLoading;
  final BuildContext context;

  SplashEventInit({required this.isLoading, required this.context});

  @override
  List<Object?> get props => [isLoading, context];
}
