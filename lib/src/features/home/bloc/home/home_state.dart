part of 'home_bloc.dart';
class HomeState extends Equatable {
  final NetworkStates state;
  final dynamic message;
  final List<Category> listCategory;
  final List<Home> listHome;
  final String? photo;

  const HomeState({
    this.state = NetworkStates.onLoading,
    this.message,
    this.listCategory = const [],
    this.listHome = const [],
    this.photo,
  });

  HomeState copyWith({
    NetworkStates? state,
    dynamic message,
    List<Category>? listCategory,
    List<Home>? listHome,
    String? photo,
  }) {
    return HomeState(
      state: state ?? this.state,
      message: message ?? this.message,
      listCategory: listCategory ?? this.listCategory,
      listHome: listHome ?? this.listHome,
      photo: photo ?? this.photo,
    );
  }

  @override
  List<Object?> get props => [state, message, listCategory, listHome, photo];
}
