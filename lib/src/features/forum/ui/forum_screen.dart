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

class _ForumScreenState extends State<ForumScreen> {
  late AuthBloc authBloc;
  ForumBloc bloc = ForumBloc();
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  bool isHaveAccess = false;

  @override
  void initState() {
    authBloc = context.read<AuthBloc>();
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
            onTap: () {},
            icon: Icons.filter_list,
            child: "Forum",
            fontFamily: 'GreatVibes'),
        body: SmartRefresher(
          enablePullDown: true,
          enablePullUp: true,
          controller: _refreshController,
          onRefresh: () => bloc.add(ForumEventRefresh()),
          child: SingleChildScrollView(
            child: Column(
              children: [
                BlocConsumer<ForumBloc, ForumState>(
                    bloc: bloc,
                    listener: (context, state) {
                      _refreshController.refreshCompleted();
                      _refreshController.loadComplete();
                    },
                    builder: (context, state) {
                      final list = state.threadsList;
                      return Wrapper(
                        state: state.state,
                        onLoaded: ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (c, i) {
                            final item = list?[i];
                            return Threads(
                              onTap: () => Navigator.pushNamed(
                                  context, DetailForumScreen.routeName,
                                  arguments: item),
                              name: '${item?.createdBy}',
                              content: item?.content,
                              countComments: item?.countComments,
                            );
                          },
                          separatorBuilder: (c, i) {
                            return Spaces.normalHorizontal();
                          },
                          itemCount: list!.length,
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
                        onError: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 16),
                          child: Text(state.message ?? 'Unknown Error'),
                        ),
                      );
                    }),
              ],
            ),
          ),
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
              GFToast.showToast(
                'Anda harus login terlebih dahulu.',
                context,
                toastPosition: GFToastPosition.BOTTOM
              );
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
