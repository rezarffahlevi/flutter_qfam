part of 'home_bloc.dart';
class HomeState extends Equatable {
  final NetworkStates state;
  final List<Category> listCategory;
  final List<Home> listHome;
  final String? photo;

  const HomeState({
    this.listCategory = const [],
    this.listHome = const [],
    this.state = NetworkStates.onLoading,
    this.photo,
  });

  HomeState copyWith({
    List<Category>? listCategory,
    List<Home>? listHome,
    NetworkStates? state,
    String? photo,
  }) {
    return HomeState(
      listCategory: listCategory ?? this.listCategory,
      listHome: listHome ?? this.listHome,
      state: state ?? this.state,
      photo: photo ?? this.photo,
    );
  }

  @override
  List<Object?> get props => [state, listCategory, listHome, photo];
}
