part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class AuthEventSetFormdataUser extends AuthEvent {
  final int? id;
  final String? email;
  final String? password;
  final String? name;
  final String? telp;
  final String? gender;
  final String? religion;
  final String? photo;
  final bool reset;

  AuthEventSetFormdataUser({
    this.id,
    this.email,
    this.password,
    this.name,
    this.telp,
    this.gender,
    this.religion,
    this.photo,
    this.reset = false,
  });

  @override
  List<Object?> get props =>
      [id, email, password, name, telp, gender, religion, photo, reset];
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

class AuthEventAddPhoto extends AuthEvent {}
