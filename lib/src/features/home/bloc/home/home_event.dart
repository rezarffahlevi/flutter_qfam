part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class HomeEventGetData extends HomeEvent {}

class HomeEventGetBanner extends HomeEvent {}

class HomeEventRefresh extends HomeEvent {}

class HomeEventSelectedCategory extends HomeEvent {
  int? selectedCategory;

  HomeEventSelectedCategory({this.selectedCategory});

  @override
  List<Object?> get props => [selectedCategory];
}

class HomeEventSetActiveBanner extends HomeEvent {
  int activeBanner;

  HomeEventSetActiveBanner({this.activeBanner = 0});

  @override
  List<Object?> get props => [activeBanner];
}
