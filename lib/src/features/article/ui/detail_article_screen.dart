import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_qfam/src/commons/spaces.dart';
import 'package:flutter_qfam/src/features/article/bloc/detail_article/detail_article_bloc.dart';
import 'package:flutter_qfam/src/features/article/ui/post_article_screen.dart';
import 'package:flutter_qfam/src/features/auth/bloc/auth_bloc.dart';
import 'package:flutter_qfam/src/features/auth/ui/login_screen.dart';
import 'package:flutter_qfam/src/features/forum/bloc/forum/forum_bloc.dart';
import 'package:flutter_qfam/src/features/forum/ui/detail_forum_screen.dart';
import 'package:flutter_qfam/src/features/forum/ui/post_thread_screen.dart';
import 'package:flutter_qfam/src/helpers/helpers.dart';
import 'package:flutter_qfam/src/models/contents/contents_model.dart';
import 'package:flutter_qfam/src/models/forum/threads_model.dart';
import 'package:flutter_qfam/src/styles/my_colors.dart';
import 'package:flutter_qfam/src/styles/my_font_weight.dart';
import 'package:flutter_qfam/src/styles/my_text_style.dart';
import 'package:flutter_qfam/src/widgets/widgets.dart';
import 'package:getwidget/getwidget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class DetailArticleScreen extends StatefulWidget {
  static const String routeName = '/detail-article';
  final ContentsModel argument;

  const DetailArticleScreen({Key? key, required this.argument})
      : super(key: key);

  @override
  _DetailArticleScreenState createState() => _DetailArticleScreenState();
}

class _DetailArticleScreenState extends State<DetailArticleScreen> {
  late AuthBloc authBloc;
  final DetailArticleBloc bloc = DetailArticleBloc();
  final ForumBloc blocForum = ForumBloc();

  @override
  void initState() {
    super.initState();
    authBloc = context.read<AuthBloc>();
    bloc.add(DetailArticleEventGetDetail(uuid: widget.argument.uuid));
    blocForum.add(
        ForumEventGetData(contentId: widget.argument.id, parentId: 0, page: 1));
  }

  @override
  void dispose() {
    bloc.close();
    if (widget.argument.isVideo == 1) bloc.ytController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dimension = MediaQuery.of(context).size;

    return MultiBlocProvider(
      providers: [
        BlocProvider<DetailArticleBloc>(
          create: (context) => bloc,
        ),
        BlocProvider<ForumBloc>(
          create: (context) => blocForum,
        ),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<DetailArticleBloc, DetailArticleState>(
            listener: (context, state) {},
          ),
          BlocListener<ForumBloc, ForumState>(
            listener: (context, state) {
              bloc.refreshController.refreshCompleted();
              bloc.refreshController.loadComplete();
            },
          ),
        ],
        child: BlocConsumer<DetailArticleBloc, DetailArticleState>(
          bloc: bloc,
          listener: (context, state) {
            bloc.refreshController.refreshCompleted();
            bloc.refreshController.loadComplete();
          },
          builder: (context, state) {
            ContentsModel? detail = state.detail;
            final bannerList = state.bannerList;

            return Scaffold(
              appBar: appBar(
                  child: widget.argument.title ?? "Detail",
                  onTapBack: () {
                    Navigator.pop(context);
                  },
                  icon: authBloc.state.currentUser?.role != 'admin'
                      ? null
                      : Text(
                          'Ubah',
                          style: MyTextStyle.h5.bold
                              .copyWith(color: MyColors.background),
                        ),
                  onTap: () async {
                    var postArticle = await Navigator.of(context).pushNamed(
                        PostArticleScreen.routeName,
                        arguments: detail);
                    if (postArticle != null) {
                      await Future.delayed(Duration(seconds: 1));
                      bloc.add(DetailArticleEventGetDetail(
                          uuid: widget.argument.uuid));
                    }
                  }),
              body: SmartRefresher(
                enablePullDown: true,
                enablePullUp: true,
                controller: bloc.refreshController,
                onRefresh: () {
                  bloc.refreshController.resetNoData();
                  bloc.add(
                      DetailArticleEventGetDetail(uuid: widget.argument.uuid));
                  blocForum.add(ForumEventGetData(
                      contentId: widget.argument.id, parentId: 0, page: 1));
                },
                onLoading: () {
                  if (blocForum.state.page <
                      (blocForum.state.response?.pagination?.lastPage ?? 1)) {
                    blocForum.add(ForumEventGetData(
                      contentId: widget.argument.id,
                      parentId: 0,
                      page: blocForum.state.page + 1,
                    ));
                  } else {
                    bloc.refreshController.loadNoData();
                  }
                },
                child: SingleChildScrollView(
                  child: Column(children: [
                    Wrapper(
                      state: state.message == 'like' ? NetworkStates.onLoaded : state.state,
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
                      onLoaded: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            state.detail?.isVideo == 1
                                ? YoutubePlayerIFrame(
                                    controller: bloc.ytController,
                                    aspectRatio: 16 / 9,
                                  )
                                : _renderBanner(bannerList, state.activeBanner,
                                    state.detail?.thumbnail),
                            Container(
                              padding:
                                  EdgeInsets.only(left: 16, right: 16, top: 16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${detail?.category}',
                                    style: MyTextStyle.h7.bold.copyWith(
                                      color: MyColors.primary,
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      RichText(
                                        text: new TextSpan(
                                          children: [
                                            new TextSpan(
                                              text: detail?.sourceBy == null
                                                  ? 'Dibuat oleh '
                                                  : 'Sumber dari ',
                                              style: MyTextStyle
                                                  .contentDescription,
                                            ),
                                            new TextSpan(
                                              text:
                                                  '${detail?.sourceBy ?? detail?.createdByName}',
                                              style: new TextStyle(
                                                  color: MyColors.link),
                                            ),
                                          ],
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          if (authBloc
                                                  .state.currentUser?.email ==
                                              null)
                                            GFToast.showToast(
                                                'Anda harus login terlebih dahulu',
                                                context,
                                                toastPosition:
                                                    GFToastPosition.BOTTOM);
                                          else
                                            bloc.add(DetailArticleOnLiked(
                                                content_id: detail?.id));
                                        },
                                        child: Material(
                                          elevation: 2.0,
                                          color: Colors.transparent,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          child: Container(
                                            alignment: Alignment.topRight,
                                            child: Icon(
                                              detail?.isLiked == 1
                                                  ? Icons.favorite
                                                  : Icons.favorite_outline,
                                              color: MyColors.primary,
                                            ),
                                            padding: EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              color: MyColors.background,
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  Spaces.largeVertical(),
                                  Text(
                                    '${detail?.title}',
                                    style: MyTextStyle.contentTitle,
                                  ),
                                  Spaces.smallVertical(),
                                  Helpers.isEmpty(detail?.subtitle)
                                      ? Container()
                                      : Text(
                                          '${detail?.subtitle}',
                                          style: MyTextStyle.sessionTitle,
                                        ),
                                  Spaces.normalVertical(),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(
                                left: 8,
                                right: 8,
                              ),
                              child: Html(
                                data: detail?.content ?? '',
                                onLinkTap: (url, _, __, ___) {
                                  print("Opening $url...");
                                },
                                onImageTap: (src, _, __, ___) {
                                  print(src);
                                },
                                onImageError: (exception, stackTrace) {
                                  print(exception);
                                },
                                onCssParseError: (css, messages) {
                                  print("css that errored: $css");
                                  print("error messages:");
                                  messages.forEach((element) {
                                    print(element);
                                  });
                                },
                              ),
                            ),
                            Helpers.isEmpty(detail?.verifiedBy)
                                ? Container()
                                : Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 16),
                                    child: Row(
                                      children: [
                                        RichText(
                                          text: new TextSpan(
                                            children: [
                                              new TextSpan(
                                                text: 'Terverifikasi ',
                                                style: MyTextStyle
                                                    .contentDescription,
                                              ),
                                              new TextSpan(
                                                text: '${detail?.verifiedBy}',
                                                style: new TextStyle(
                                                  color: MyColors.link,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        detail?.verifiedBy == null
                                            ? Container()
                                            : Icon(
                                                Icons.verified_outlined,
                                                color: MyColors.primary,
                                                size: 20,
                                              ),
                                      ],
                                    ),
                                  ),
                            Spaces.largeVertical(),
                            Divider(),
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 8),
                              child: Text(
                                'Komentar atau Diskusi: ',
                                style: MyTextStyle.sessionTitle,
                              ),
                            ),
                            Divider(),
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 8),
                              child: BlocConsumer<ForumBloc, ForumState>(
                                  bloc: blocForum,
                                  listener: (context, state) {
                                    bloc.refreshController.refreshCompleted();
                                    bloc.refreshController.loadComplete();
                                  },
                                  builder: (context, state) {
                                    final list = state.threadsList;
                                    return Wrapper(
                                      state: NetworkStates.onLoaded,
                                      onLoaded: state.threadsList!.length < 1
                                          ? Center(
                                              child: Text(
                                              'Belum ada diskusi',
                                              style: MyTextStyle.h4,
                                            ))
                                          : ListView.separated(
                                              shrinkWrap: true,
                                              physics:
                                                  NeverScrollableScrollPhysics(),
                                              itemBuilder: (c, i) {
                                                final item = list?[i];
                                                return Threads(
                                                  onTap: () =>
                                                      Navigator.pushNamed(
                                                          context,
                                                          DetailForumScreen
                                                              .routeName,
                                                          arguments: item),
                                                  name: '${item?.createdBy}',
                                                  content: item?.content,
                                                  countComments:
                                                      item?.countComments,
                                                  countLikes: item?.countLikes,
                                                  isAnonymous:
                                                      item?.isAnonymous == 1,
                                                  isLiked: item?.isLiked == 1,
                                                  isVerified:
                                                      !(item?.createdByRole ==
                                                          'user'),
                                                  onTapLike: () {
                                                    if (authBloc
                                                            .state
                                                            .currentUser
                                                            ?.email ==
                                                        null)
                                                      GFToast.showToast(
                                                          'Anda harus login terlebih dahulu',
                                                          context,
                                                          toastPosition:
                                                              GFToastPosition
                                                                  .BOTTOM);
                                                    else
                                                      blocForum.add(
                                                          ForumEventOnLiked(
                                                              thread_id:
                                                                  item?.id));
                                                  },
                                                  onTapShare: () {
                                                    GFToast.showToast(
                                                        'Fitur belum tersedia',
                                                        context,
                                                        toastPosition:
                                                            GFToastPosition
                                                                .BOTTOM);
                                                  },
                                                );
                                              },
                                              separatorBuilder: (c, i) {
                                                return Spaces
                                                    .normalHorizontal();
                                              },
                                              itemCount: list!.length,
                                            ),
                                      onLoading: GFShimmer(
                                        child: Column(
                                          children: [
                                            Spaces.normalVertical(),
                                            for (var i = 0; i < 2; i++)
                                              Column(
                                                children: [
                                                  loadingBlock(dimension),
                                                  Spaces.normalVertical()
                                                ],
                                              ),
                                          ],
                                        ),
                                      ),
                                      onError: Align(
                                        alignment: Alignment.center,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 15.0),
                                          child: Text(
                                              state.message ?? 'Unknown Error'),
                                        ),
                                      ),
                                    );
                                  }),
                            ),
                          ],
                        ),
                      ),
                      onError: Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: Text(state.message ?? 'Unknown Error'),
                        ),
                      ),
                    )
                  ]),
                ),
              ),
              floatingActionButton: FloatingActionButton(
                heroTag: null,
                onPressed: () async {
                  if (authBloc.state.currentUser?.email != null) {
                    var postThread = await Navigator.of(context).pushNamed(
                        PostThreadScreen.routeName,
                        arguments: ThreadsModel(
                            parentId: 0, contentId: widget.argument.id));
                    if (postThread != null) {
                      blocForum.add(
                          ForumEventGetData(contentId: widget.argument.id));
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
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _renderBanner(bannerList, activeBanner, thumbnail) {
    if (bannerList.length > 1) {
      return Column(
        children: [
          GFCarousel(
            items: bannerList.map<Widget>(
              (item) {
                return Container(
                  margin: EdgeInsets.all(8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    child: Image.network(item.link ?? '',
                        fit: BoxFit.cover, width: 1000.0),
                  ),
                );
              },
            ).toList(),
            onPageChanged: (index) {
              bloc.add(DetailArticleEventSetActiveBanner(activeBanner: index));
            },
            aspectRatio: 1.5 / 1,
            enlargeMainPage: true,
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (var i = 0; i < bannerList.length; i++)
                  Container(
                    width: 8.0,
                    height: 8.0,
                    margin:
                        const EdgeInsets.symmetric(vertical: 2, horizontal: 2),
                    decoration: BoxDecoration(
                      // border: activeBanner == i
                      //     ? widget.activeDotBorder
                      //     : widget.passiveDotBorder,
                      shape: BoxShape.circle,
                      color: activeBanner == i
                          ? const Color.fromRGBO(0, 0, 0, 0.9)
                          : const Color.fromRGBO(0, 0, 0, 0.4),
                    ),
                  ),
              ],
            ),
          )
        ],
      );
    } else if (bannerList.length == 1) {
      return GFImageOverlay(
        color: MyColors.greyPlaceHolder,
        height: 220,
        image: NetworkImage(bannerList[0]?.link ?? ''),
        boxFit: BoxFit.fitWidth,
      );
    }
    return GFImageOverlay(
      color: MyColors.greyPlaceHolder,
      height: 220,
      image: NetworkImage(thumbnail ?? ''),
      boxFit: BoxFit.fitWidth,
    );
    ;
  }
}

///
class Controls extends StatelessWidget {
  ///
  const Controls();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [],
      ),
    );
  }
}
