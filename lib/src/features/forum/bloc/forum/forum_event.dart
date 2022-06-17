part of 'forum_bloc.dart';

abstract class ForumEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class ForumEventGetData extends ForumEvent {
  String? uuid;

  ForumEventGetData({this.uuid});

  @override
  List<Object?> get props => [uuid];}

class ForumEventRefresh extends ForumEvent {}
