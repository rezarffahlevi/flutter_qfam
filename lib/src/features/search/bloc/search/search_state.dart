part of 'search_bloc.dart';
class SearchState extends Equatable {
  final NetworkStates state;

  const SearchState({
    this.state = NetworkStates.onLoading,
  });

  SearchState copyWith({
    NetworkStates? state,
  }) {
    return SearchState(
      state: state ?? this.state,
    );
  }

  @override
  List<Object?> get props => [state];
}
