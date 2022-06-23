part of 'auth_bloc.dart';

class AuthState extends Equatable {
  final NetworkStates state;
  final String? message;
  final dynamic error;
  final UserModel? currentUser;
  final UserModel? formdataUser;
  final BuildContext? context;

  const AuthState({
    this.state = NetworkStates.onLoaded,
    this.message,
    this.error,
    this.currentUser,
    this.formdataUser,
    this.context,
  });

  AuthState copyWith({
    NetworkStates? state,
    String? message,
    dynamic error,
    UserModel? currentUser,
    UserModel? formdataUser,
    BuildContext? context,
  }) {
    return AuthState(
      state: state ?? this.state,
      message: message ?? this.message,
      error: error ?? this.error,
      currentUser: currentUser ?? this.currentUser,
      formdataUser: formdataUser ?? this.formdataUser,
      context: context ?? this.context,
    );
  }

  @override
  List<Object?> get props => [state, message, error, currentUser, formdataUser, context];
}
