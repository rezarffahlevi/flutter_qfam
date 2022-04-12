part of 'home_root_bloc.dart';

abstract class HomeRootEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class HomeRootEventSelectedIndex extends HomeRootEvent {
  int? index;

  HomeRootEventSelectedIndex({this.index});

  @override
  List<Object?> get props => [index];
}

class HomeRootEventRefresh extends HomeRootEvent {}
