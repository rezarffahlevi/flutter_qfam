part of 'search_bloc.dart';

class SearchState extends Equatable {
  final NetworkStates state;
  final dynamic message;
  final List<ContentsModel>? contentsList;
  final List<CategoryModel>? categoryList;
  final int? selectedCategory;
  final String? search;
  final int page;
  final DefaultResponseModel? response;

  const SearchState({
    this.state = NetworkStates.onLoading,
    this.message = null,
    this.contentsList = const [],
    this.categoryList = const [],
    this.selectedCategory = 1,
    this.search,
    this.page = 1,
    this.response,
  });

  SearchState copyWith({
    NetworkStates? state,
    dynamic message,
    List<ContentsModel>? contentsList,
    List<CategoryModel>? categoryList,
    int? selectedCategory,
    String? search,
    int? page = 1,
    DefaultResponseModel? response,
  }) {
    return SearchState(
      state: state ?? this.state,
      message: message ?? this.message,
      contentsList: contentsList ?? this.contentsList,
      categoryList: categoryList ?? this.categoryList,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      search: search ?? this.search,
      page: page ?? this.page,
      response: response ?? this.response,
    );
  }

  @override
  List<Object?> get props => [
        state,
        message,
        contentsList,
        categoryList,
        selectedCategory,
        search,
        page,
        response
      ];
}
