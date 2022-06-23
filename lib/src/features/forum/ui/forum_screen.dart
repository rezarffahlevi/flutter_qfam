import 'package:flutter_qfam/src/commons/spaces.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_qfam/src/features/auth/bloc/auth_bloc.dart';
import 'package:flutter_qfam/src/features/auth/ui/login_screen.dart';
import 'package:flutter_qfam/src/features/forum/bloc/forum/forum_bloc.dart';
import 'package:flutter_qfam/src/features/forum/ui/detail_forum_screen.dart';
import 'package:flutter_qfam/src/features/forum/ui/post_thread_screen.dart';
import 'package:flutter_qfam/src/features/home/bloc/home_root/home_root_bloc.dart';
import 'package:flutter_qfam/src/styles/my_colors.dart';
import 'package:flutter_qfam/src/styles/my_font_weight.dart';
import 'package:flutter_qfam/src/styles/my_text_style.dart';
import 'package:flutter_qfam/src/widgets/widgets.dart';
import 'package:getwidget/getwidget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ForumScreen extends StatefulWidget {
  static const String routeName = '/forum';

  const ForumScreen({Key? key}) : super(key: key);

  @override
  _ForumScreenState createState() => _ForumScreenState();
}

class _ForumScreenState extends State<ForumScreen>
    with SingleTickerProviderStateMixin {
  late AuthBloc authBloc;
  ForumBloc bloc = ForumBloc();
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  TabController? tabController;
  bool isHaveAccess = false;

  @override
  void initState() {
    authBloc = context.read<AuthBloc>();
    bloc.add(ForumEventGetForumList());
    bloc.add(ForumEventGetData());
  }

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dimension = MediaQuery.of(context).size;

    return BlocProvider(
      create: (BuildContext context) => ForumBloc(),
      child: Scaffold(
        appBar: appBar(
            // onTap: () {},
            // icon: Icons.filter_list,
            child: "Forum",
            fontFamily: 'GreatVibes'),
        body: BlocConsumer<ForumBloc, ForumState>(
          bloc: bloc,
          listener: (context, state) {
            _refreshController.refreshCompleted();
            _refreshController.loadComplete();
            if (tabController == null && state.state == NetworkStates.onLoaded)
              tabController =
                  TabController(length: state.forumList!.length, vsync: this);
          },
          builder: (context, state) {
            final list = state.threadsList;
            final forumList = state.forumList;
            return Wrapper(
              state: state.state,
              onLoaded: Stack(
                children: <Widget>[
                  Container(
                    height: 48,
                    width: MediaQuery.of(context).size.width,
                    child: Material(
                      elevation: 2,
                      child: Center(
                        child: TabBar(
                          key: Key('TabBarArticle'),
                          isScrollable: true,
                          controller: tabController,
                          indicatorSize: TabBarIndicatorSize.label,
                          labelColor: MyColors.text,
                          indicatorColor: Colors.transparent,
                          unselectedLabelColor: MyColors.text.withOpacity(0.4),
                          tabs: forumList!.map((item) {
                            return Tab(
                              key: Key('TabArticleCategory${item.name}'),
                              child: Text(
                                '${item.name}',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: MyFontWeight.semiBold,
                                ),
                                maxLines: 1,
                              ),
                            );
                          }).toList(),
                          onTap: (index) {
                            debugPrint('TABS ${tabController?.index}');
                            
                          },
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 50),
                    child: TabBarView(
                      key: Key('TabBarViewArticle'),
                      controller: tabController,
                      children: forumList.map((item) {
                        return SmartRefresher(
                          enablePullDown: true,
                          enablePullUp: true,
                          controller: RefreshController(initialRefresh: false),
                          onRefresh: () => bloc.add(ForumEventRefresh()),
                          child: ListView.separated(
                            shrinkWrap: true,
                            // physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (c, i) {
                              final item = list?[i];
                              return Threads(
                                onTap: () => Navigator.pushNamed(
                                    context, DetailForumScreen.routeName,
                                    arguments: item),
                                name: '${item?.createdBy}',
                                content: item?.content,
                                countComments: item?.countComments,
                                onTapLike: () {
                                  GFToast.showToast(
                                      'Fitur belum tersedia', context,
                                      toastPosition: GFToastPosition.BOTTOM);
                                },
                                onTapShare: () {
                                  GFToast.showToast(
                                      'Fitur belum tersedia', context,
                                      toastPosition: GFToastPosition.BOTTOM);
                                },
                              );
                            },
                            separatorBuilder: (c, i) {
                              return Spaces.normalHorizontal();
                            },
                            itemCount: list!.length,
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
              onLoading: GFShimmer(
                child: Column(
                  children: [
                    Spaces.normalVertical(),
                    for (var i = 0; i < 5; i++)
                      Column(
                        children: [
                          loadingBlock(dimension),
                          Spaces.normalVertical()
                        ],
                      ),
                  ],
                ),
              ),
              onError: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
                child: Text(state.message ?? 'Unknown Error'),
              ),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          heroTag: null,
          onPressed: () async {
            if (authBloc.state.currentUser?.email != null) {
              var postThread = await Navigator.of(context)
                  .pushNamed(PostThreadScreen.routeName, arguments: 0);
              if (postThread != null) {
                bloc.add(ForumEventGetData());
              }
            } else {
              Navigator.of(context).pushNamed(LoginScreen.routeName);
              GFToast.showToast('Anda harus login terlebih dahulu.', context,
                  toastPosition: GFToastPosition.BOTTOM);
            }
          },
          backgroundColor: MyColors.primary,
          child: const Icon(
            Icons.add,
          ),
        ),
      ),
    );
  }
}
