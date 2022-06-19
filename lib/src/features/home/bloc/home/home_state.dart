part of 'home_bloc.dart';

class HomeState extends Equatable {
  final NetworkStates state;
  final dynamic message;
  final List<Category> listCategory;
  final List<FilesModel> bannerList;
  final List<SectionsModel> sections;
  final int? activeBanner;
  final int? selectedCategory;
  
  const HomeState({
    this.state = NetworkStates.onLoading,
    this.message,
    this.listCategory = const [],
    this.bannerList = const [],
    this.sections = const [],
    this.activeBanner = 0,
    this.selectedCategory,
  });

  HomeState copyWith({
    NetworkStates? state,
    dynamic message,
    List<Category>? listCategory,
    List<FilesModel>? bannerList,
    List<SectionsModel>? sections,
    int? activeBanner,
    int? selectedCategory,
  }) {
    return HomeState(
      state: state ?? this.state,
      message: message ?? this.message,
      listCategory: listCategory ?? this.listCategory,
      bannerList: bannerList ?? this.bannerList,
      sections: sections ?? this.sections,
      activeBanner: activeBanner ?? this.activeBanner,
      selectedCategory: selectedCategory ?? this.selectedCategory,
    );
  }

  @override
  List<Object?> get props => [
        state,
        message,
        listCategory,
        bannerList,
        sections,
        activeBanner,
        selectedCategory
      ];
}
