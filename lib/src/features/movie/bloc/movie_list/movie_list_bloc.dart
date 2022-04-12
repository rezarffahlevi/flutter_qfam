import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'movie_list_event.dart';
part 'movie_list_state.dart';

class MovieListBloc extends Bloc<MovieListEvent, MovieListState> {
  MovieListBloc() : super(MovieListState()) {
    on<MovieListEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
