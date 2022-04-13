part of 'forum_bloc.dart';

abstract class ForumEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class ForumEventGetData extends ForumEvent {}

class ForumEventRefresh extends ForumEvent {}
