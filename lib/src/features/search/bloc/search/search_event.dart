part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SearchEventGetData extends SearchEvent {}
class SearchEventGetCategory extends SearchEvent {}

class SearchEventSetSelectedCategory extends SearchEvent {
  int? selectedCategory;

  SearchEventSetSelectedCategory({this.selectedCategory});

  @override
  List<Object?> get props => [selectedCategory];
}

class SearchEventRefresh extends SearchEvent {}
