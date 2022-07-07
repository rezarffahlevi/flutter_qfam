part of 'likes_bloc.dart';

class LikesState extends Equatable {
  final NetworkStates state;
  final int page;
  final DefaultResponseModel? resNotif;
  final List<LikesModel>? list;

  const LikesState({
    this.state = NetworkStates.onLoading,
    this.page = 1,
    this.resNotif,
    this.list,
  });

  LikesState copyWith({
    NetworkStates? state,
    int? page = 1,
    DefaultResponseModel? resNotif,
    List<LikesModel>? list,
  }) {
    return LikesState(
      state: state ?? this.state,
      page: page ?? this.page,
      resNotif: resNotif ?? this.resNotif,
      list: list ?? this.list,
    );
  }

  @override
  List<Object?> get props => [state, page, resNotif, list];
}
