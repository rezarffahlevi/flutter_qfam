part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class ProfileEventGetData extends ProfileEvent {
  UserModel? currentUser;

  ProfileEventGetData({this.currentUser});

  @override
  List<Object?> get props => [currentUser];
}

class ProfileEventRefresh extends ProfileEvent {}
