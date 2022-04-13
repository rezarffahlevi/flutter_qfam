part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SearchEventGetData extends SearchEvent {}

class SearchEventRefresh extends SearchEvent {}
