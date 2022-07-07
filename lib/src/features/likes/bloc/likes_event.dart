part of 'likes_bloc.dart';

abstract class LikesEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LikesEventGetData extends LikesEvent {
  int page;

  LikesEventGetData({
    this.page = 1,
  });

  @override
  List<Object?> get props => [page];
}

class LikesEventRefresh extends LikesEvent {}
