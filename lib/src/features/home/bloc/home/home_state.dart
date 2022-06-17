part of 'home_bloc.dart';

class HomeState extends Equatable {
  final NetworkStates state;
  final dynamic message;
  final List<Category> listCategory;
  final List<SectionsModel> sections;
  final String? photo;
  final int? selectedCategory;

  const HomeState({
    this.state = NetworkStates.onLoading,
    this.message,
    this.listCategory = const [],
    this.sections = const [],
    this.photo,
    this.selectedCategory,
  });

  HomeState copyWith({
    NetworkStates? state,
    dynamic message,
    List<Category>? listCategory,
    List<SectionsModel>? sections,
    String? photo,
    int? selectedCategory,
  }) {
    return HomeState(
      state: state ?? this.state,
      message: message ?? this.message,
      listCategory: listCategory ?? this.listCategory,
      sections: sections ?? this.sections,
      photo: photo ?? this.photo,
      selectedCategory: selectedCategory ?? this.selectedCategory,
    );
  }

  @override
  List<Object?> get props => [state, message, listCategory, sections, photo, selectedCategory];
}
