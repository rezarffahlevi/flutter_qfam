part of 'forum_bloc.dart';

class ForumState extends Equatable {
  final NetworkStates state;
  final String? message;
  final BuildContext? context;
  final List<ThreadsModel>? threadsList;
  final List<ForumModel>? forumList;
  final ThreadsModel? thread;
  final int? forumId;
  final int? parentId;
  final int? contentId;
  final int? isAnonymous;
  final String? uuid;
  final String? content;
  final int page;
  final DefaultResponseModel? response;
  final XFile? photo;

  const ForumState({
    this.state = NetworkStates.onLoaded,
    this.message,
    this.context,
    this.threadsList = const [],
    this.forumList = const [],
    this.thread,
    this.forumId,
    this.parentId,
    this.contentId,
    this.isAnonymous = 0,
    this.uuid,
    this.content,
    this.page = 1,
    this.response,
    this.photo,
  });

  ForumState copyWith({
    NetworkStates? state,
    String? message,
    BuildContext? context,
    List<ThreadsModel>? threadsList,
    List<ForumModel>? forumList,
    ThreadsModel? thread,
    int? parentId,
    int? forumId,
    int? contentId,
    int? isAnonymous,
    String? uuid,
    String? content,
    int? page,
    DefaultResponseModel? response,
    XFile? photo,
  }) {
    return ForumState(
      state: state ?? this.state,
      message: message ?? this.message,
      context: context ?? this.context,
      threadsList: threadsList ?? this.threadsList,
      forumList: forumList ?? this.forumList,
      thread: thread ?? this.thread,
      parentId: parentId ?? this.parentId,
      forumId: forumId ?? this.forumId,
      contentId: contentId ?? this.contentId,
      isAnonymous: isAnonymous ?? this.isAnonymous,
      uuid: uuid ?? this.uuid,
      content: content ?? this.content,
      page: page ?? this.page,
      response: response ?? this.response,
      photo: photo ?? this.photo,
    );
  }

  @override
  List<Object?> get props => [
        state,
        message,
        context,
        threadsList,
        forumList,
        thread,
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
