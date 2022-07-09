import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_qfam/src/commons/app_settings.dart';
import 'package:flutter_qfam/src/commons/spaces.dart';
import 'package:flutter_qfam/src/features/auth/bloc/auth_bloc.dart';
import 'package:flutter_qfam/src/features/auth/ui/login_screen.dart';
import 'package:flutter_qfam/src/features/forum/bloc/forum/forum_bloc.dart';
import 'package:flutter_qfam/src/features/forum/ui/post_thread_screen.dart';
import 'package:flutter_qfam/src/models/forum/threads_model.dart';
import 'package:flutter_qfam/src/styles/my_colors.dart';
import 'package:flutter_qfam/src/widgets/widgets.dart';
import 'package:getwidget/getwidget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:share_plus/share_plus.dart';

class DetailForumScreen extends StatefulWidget {
  static const String routeName = '/detail-forum';
  final ThreadsModel argument;

  const DetailForumScreen({Key? key, required this.argument}) : super(key: key);

  @override
  _DetailForumScreenState createState() => _DetailForumScreenState();
}

class _DetailForumScreenState extends State<DetailForumScreen> {
  late AuthBloc authBloc;
  ForumBloc bloc = ForumBloc();
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    authBloc = context.read<AuthBloc>();
    _scrollController = ScrollController();
    bloc.add(ForumEventGetData(uuid: widget.argument.uuid, page: 1));
  }

  @override
  void dispose() {
    bloc.close();
    super.dispose();
    _scrollController.dispose();
  }

  void _scrollToTop() {
    _scrollController.animateTo(0,
        duration: const Duration(milliseconds: 400), curve: Curves.linear);
  }

  @override
  Widget build(BuildContext context) {
    final dimension = MediaQuery.of(context).size;

    return BlocProvider(
      create: (BuildContext context) => bloc,
      child: BlocConsumer<ForumBloc, ForumState>(
        bloc: bloc,
        listener: (context, state) {
          _refreshController.refreshCompleted();
          _refreshController.loadComplete();
        },
        builder: (context, state) {
          ThreadsModel? detail = state.thread;
          return Scaffold(
              appBar: appBar(
                  child: "Utas",
                  onTapBack: () {
                    Navigator.pop(context);
                  }),
              body: SmartRefresher(
                enablePullDown: true,
                enablePullUp: true,
                scrollController: _scrollController,
                controller: _refreshController,
                onRefresh: () {
                  _refreshController.resetNoData();
                  bloc.add(ForumEventGetData(uuid: state.uuid, page: 1));
                },
                onLoading: () {
                  if (state.page <
                      (state.response?.pagination?.lastPage ?? 1)) {
                    bloc.add(ForumEventGetData(
                      uuid: state.uuid,
                      page: bloc.state.page + 1,
                    ));
                  } else {
                    _refreshController.loadNoData();
                  }
                },
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Threads(
                        isDetail: true,
                        name: '${detail?.createdBy}',
                        content: detail?.content,
                        createdAt: detail?.createdAt,
                        image: detail?.image,
                        photo: detail?.createdByPhoto,
                        isAnonymous: detail?.isAnonymous == 1,
                        isVerified: !(detail?.createdByRole == 'user'),
                        countComments: detail?.countComments,
                        countLikes: detail?.countLikes,
                        isChild: false,
                        isLiked: detail?.isLiked == 1,
                        //  detail?.parentId != 0,
                        onTapParent: () {
                          bloc.add(
                              ForumEventGetData(parentId: detail?.parentId));
                        },
                        onTapLike: () {
                          if (authBloc.state.currentUser?.email == null)
                            GFToast.showToast(
                                'Anda harus login terlebih dahulu', context,
                                toastPosition: GFToastPosition.BOTTOM);
                          else
                            bloc.add(ForumEventOnLiked(
                                thread_id: detail?.id, isParent: true));
                        },
                        onTapShare: () {
                          Share.share(
                              'Lihat diskusi: ${detail?.content} ${AppSettings.getConfig.BASE_URL}thread?id=${detail?.uuid}',
                              subject: 'Lihat disuksi ini');
                        },
                      ),
                      Wrapper(
                        state: state.message == 'like'
                            ? NetworkStates.onLoaded
                            : state.state,
                        onLoaded: ListView.separated(
                          padding: EdgeInsets.all(8),
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (c, i) {
                            ThreadsModel? item = state.threadsList![i];
                            return Threads(
                              onTap: () => Navigator.pushNamed(
                                  context, DetailForumScreen.routeName,
                                  arguments: item),
                              name: '${item.createdBy}',
                              content: item.content,
                              image: item.image,
                              photo: item.createdByPhoto,
                              countComments: item.countComments,
                              countLikes: item.countLikes,
                              isAnonymous: item.isAnonymous == 1,
                              isVerified: !(item.createdByRole == 'user'),
                              isLiked: item.isLiked == 1,
                              onTapLike: () {
                                if (authBloc.state.currentUser?.email == null)
                                  GFToast.showToast(
                                      'Anda harus login terlebih dahulu',
                                      context,
                                      toastPosition: GFToastPosition.BOTTOM);
                                else
                                  bloc.add(
                                      ForumEventOnLiked(thread_id: item.id));
                              },
                              onTapShare: () {
                                Share.share(
                                    'Lihat diskusi: ${item.content} ${AppSettings.getConfig.BASE_URL}thread?id=${item.uuid}',
                                    subject: 'Lihat disuksi ini');
                              },
                            );
                          },
                          separatorBuilder: (c, i) {
                            return Spaces.normalHorizontal();
                          },
                          itemCount: state.threadsList?.length ?? 0,
                        ),
                        onLoading: GFShimmer(
                          child: Column(
                            children: [
                              Spaces.normalVertical(),
                              for (var i = 0; i < 12; i++)
                                Column(
                                  children: [
                                    loadingBlock(dimension),
                                    Spaces.normalVertical()
                                  ],
                                ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () async {
                  if (authBloc.state.currentUser?.email != null) {
                    var postThread = await Navigator.of(context).pushNamed(
                        PostThreadScreen.routeName,
                        arguments: ThreadsModel(
                            parentId:
                                widget.argument.id ?? bloc.state.thread?.id,
                            forumId: state.forumId,
                            contentId: detail?.contentId));
                    if (postThread != null) {
                      bloc.add(
                          ForumEventGetData(uuid: bloc.state.uuid, page: 1));
                    }
                  } else {
                    Navigator.of(context).pushNamed(LoginScreen.routeName);
                    GFToast.showToast(
                        'Anda harus login terlebih dahulu.', context,
                        toastPosition: GFToastPosition.BOTTOM);
                  }
                },
                backgroundColor: MyColors.primary,
                child: const Icon(
                  Icons.add,
                ),
              ));
        },
      ),
    );
  }
}
