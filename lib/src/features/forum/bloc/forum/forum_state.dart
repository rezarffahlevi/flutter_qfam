part of 'forum_bloc.dart';

class ForumState extends Equatable {
  final NetworkStates state;
  final String? message;
  final BuildContext? context;
  final List<ThreadsModel>? threadsList;
  final List<ForumModel>? forumList;
  final ThreadsModel? threads;
  final int? forumId;
  final int? parentId;
  final int? contentId;
  final int? isAnonymous;
  final String? uuid;
  final String? content;
  final int page;
  final DefaultResponseModel? response;

  const ForumState({
    this.state = NetworkStates.onLoaded,
    this.message,
    this.context,
    this.threadsList = const [],
    this.forumList = const [],
    this.threads,
    this.forumId,
    this.parentId,
    this.contentId,
    this.isAnonymous = 0,
    this.uuid,
    this.content,
    this.page = 1,
    this.response,
  });

  ForumState copyWith({
    NetworkStates? state,
    String? message,
    BuildContext? context,
    List<ThreadsModel>? threadsList,
    List<ForumModel>? forumList,
    ThreadsModel? threads,
    int? parentId,
    int? forumId,
    int? contentId,
    int? isAnonymous,
    String? uuid,
    String? content,
    int? page,
    DefaultResponseModel? response,
  }) {
    return ForumState(
      state: state ?? this.state,
      message: message ?? this.message,
      context: context ?? this.context,
      threadsList: threadsList ?? this.threadsList,
      forumList: forumList ?? this.forumList,
      threads: threads ?? this.threads,
      parentId: parentId ?? this.parentId,
      forumId: forumId ?? this.forumId,
      contentId: contentId ?? this.contentId,
      isAnonymous: isAnonymous ?? this.isAnonymous,
      uuid: uuid ?? this.uuid,
      content: content ?? this.content,
      page: page ?? this.page,
      response: response ?? this.response,
    );
  }

  @override
  List<Object?> get props => [
        state,
        message,
        context,
        threadsList,
        forumList,
        threads,
        forumId,
        parentId,
        contentId,
        isAnonymous,
        uuid,
        content,
        page,
        response,
      ];
}
