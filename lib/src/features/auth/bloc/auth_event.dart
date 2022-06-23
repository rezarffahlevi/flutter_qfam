part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class AuthEventSetFormdataUser extends AuthEvent {
  final String? email;
  final String? password;
  final String? name;
  final String? telp;
  final String? gender;
  final String? religion;
  final String? photo;

  AuthEventSetFormdataUser({
    this.email,
    this.password,
    this.name,
    this.telp,
    this.gender,
    this.religion,
    this.photo,
  });

  @override
  List<Object?> get props => [email, password, name, telp, gender, religion, photo];
}

class AuthEventInitLogin extends AuthEvent {
  final BuildContext? context;

  AuthEventInitLogin({this.context});

  @override
  List<Object?> get props => [context];
}

class AuthEventInitRegister extends AuthEvent {
  final BuildContext? context;

  AuthEventInitRegister({this.context});

  @override
  List<Object?> get props => [context];
}

class AuthEventOnLogin extends AuthEvent {}
class AuthEventOnLogout extends AuthEvent {}
class AuthEventOnRegister extends AuthEvent {}

class AuthEventGetCurrentUser extends AuthEvent {}

class AuthEventRefresh extends AuthEvent {}
