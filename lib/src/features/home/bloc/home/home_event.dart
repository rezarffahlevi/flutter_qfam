part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class HomeEventGetData extends HomeEvent {}

class HomeEventRefresh extends HomeEvent {}

class HomeEventSelectedCategory extends HomeEvent {
  int? selectedCategory;

  HomeEventSelectedCategory({this.selectedCategory});

  @override
  List<Object?> get props => [selectedCategory];
}

class HomeEventSetPhoto extends HomeEvent {
  String? photo;

  HomeEventSetPhoto({this.photo});

  @override
  List<Object?> get props => [photo];
}
