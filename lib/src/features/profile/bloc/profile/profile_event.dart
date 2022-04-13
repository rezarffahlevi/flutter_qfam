part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class ProfileEventGetData extends ProfileEvent {}

class ProfileEventRefresh extends ProfileEvent {}
