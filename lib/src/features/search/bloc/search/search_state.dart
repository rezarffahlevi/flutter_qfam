part of 'search_bloc.dart';

class SearchState extends Equatable {
  final NetworkStates state;
  final dynamic message;
  final List<ContentsModel>? contentsList;

  const SearchState({
    this.state = NetworkStates.onLoading,
    this.message = null,
    this.contentsList = const [],
  });

  SearchState copyWith({
    NetworkStates? state,
    List<ContentsModel>? contentsList,
  }) {
    return SearchState(
      state: state ?? this.state,
      message: message ?? this.message,
      contentsList: contentsList ?? this.contentsList,
    );
  }

  @override
  List<Object?> get props => [state, message, contentsList];
}
