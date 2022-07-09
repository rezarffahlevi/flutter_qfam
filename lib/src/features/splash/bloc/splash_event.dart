part of 'splash_bloc.dart';

abstract class SplashEvent extends Equatable {
  const SplashEvent();

  @override
  List<Object?> get props => [];
}

class SplashEventInit extends SplashEvent {
  final BuildContext context;

  SplashEventInit({required this.context});

  @override
  List<Object?> get props => [context];
}
