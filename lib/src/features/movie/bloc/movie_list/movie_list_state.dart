part of 'movie_list_bloc.dart';

class MovieListState extends Equatable {
  final bool isLoading;

  const MovieListState({
    this.isLoading = false,
  });

  MovieListState copyWith({
    int? number,
    bool? isLoading,
  }) {
    return MovieListState(
      isLoading: isLoading ?? this.isLoading,
    );
  }
  
  @override
  List<Object?> get props => [isLoading];
}
