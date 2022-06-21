part of 'search_bloc.dart';

class SearchState extends Equatable {
  final NetworkStates state;
  final dynamic message;
  final List<ContentsModel>? contentsList;
  final List<CategoryModel>? categoryList;
  final int? selectedCategory;

  const SearchState({
    this.state = NetworkStates.onLoading,
    this.message = null,
    this.contentsList = const [],
    this.categoryList = const [],
    this.selectedCategory = 0,
  });

  SearchState copyWith({
    NetworkStates? state,
    List<ContentsModel>? contentsList,
    List<CategoryModel>? categoryList,
    int? selectedCategory,
  }) {
    return SearchState(
      state: state ?? this.state,
      message: message ?? this.message,
      contentsList: contentsList ?? this.contentsList,
      categoryList: categoryList ?? this.categoryList,
      selectedCategory: selectedCategory ?? this.selectedCategory,
    );
  }

  @override
  List<Object?> get props => [state, message, contentsList, categoryList, selectedCategory];
}
