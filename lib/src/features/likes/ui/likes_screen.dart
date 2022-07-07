import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_qfam/src/commons/spaces.dart';
import 'package:flutter_qfam/src/features/article/ui/detail_article_screen.dart';
import 'package:flutter_qfam/src/features/forum/ui/detail_forum_screen.dart';
import 'package:flutter_qfam/src/features/likes/bloc/likes_bloc.dart';
import 'package:flutter_qfam/src/helpers/helpers.dart';
import 'package:flutter_qfam/src/models/contents/contents_model.dart';
import 'package:flutter_qfam/src/models/forum/threads_model.dart';
import 'package:flutter_qfam/src/styles/my_colors.dart';
import 'package:flutter_qfam/src/styles/my_text_style.dart';
import 'package:flutter_qfam/src/widgets/widgets.dart';
import 'package:getwidget/getwidget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class LikesScreen extends StatefulWidget {
  static const String routeName = '/likes';
  final String? argument;

  const LikesScreen({Key? key, this.argument}) : super(key: key);

  @override
  _LikesScreenState createState() => _LikesScreenState();
}

class _LikesScreenState extends State<LikesScreen> {
  LikesBloc bloc = LikesBloc();
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    super.initState();
    bloc.add(LikesEventGetData());
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
      create: (BuildContext context) => bloc,
      child: BlocConsumer<LikesBloc, LikesState>(
        bloc: bloc,
        listener: (context, state) {
          _refreshController.refreshCompleted();
          _refreshController.loadComplete();
        },
        builder: (context, state) {
          return Scaffold(
            appBar: appBar(
                onTapBack: () => Navigator.pop(context), child: 'Daftar Suka'),
            body: SmartRefresher(
              enablePullDown: true,
              enablePullUp: true,
              controller: _refreshController,
              onRefresh: () {
                bloc.add(LikesEventGetData(page: 1));
                _refreshController.resetNoData();
              },
              onLoading: () {
                if (state.page < (state.resNotif?.pagination?.lastPage ?? 1))
                  bloc.add(LikesEventGetData(page: state.page + 1));
                else {
                  _refreshController.loadNoData();
                }
              },
              child: SingleChildScrollView(
                child: Column(children: [
                  Wrapper(
                    state: state.state,
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
                    onLoaded: Column(
                      children: [
                        Spaces.normalVertical(),
                        ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          padding:
                              EdgeInsets.only(left: 16, right: 16, bottom: 16),
                          itemBuilder: (c, i) {
                            final item = state.list![i];
                            return GestureDetector(
                              onTap: () {
                                debugPrint(
                                    '${item.contentUuid} ${item.threadUuid}');
                                if (!Helpers.isEmpty(item.contentUuid)) {
                                  Navigator.of(context).pushNamed(
                                      DetailArticleScreen.routeName,
                                      arguments: ContentsModel(
                                          id: item.contentId,
                                          uuid: item.contentUuid));
                                } else {
                                  Navigator.of(context).pushNamed(
                                      DetailForumScreen.routeName,
                                      arguments:
                                          ThreadsModel(uuid: item.threadUuid));
                                }
                              },
                              child: Material(
                                elevation: 1.0,
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(8),
                                child: Container(
                                  padding: EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    color: MyColors.white,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Anda menyukai ${!Helpers.isEmpty(item.contentUuid) ? 'konten:' : 'diskusi:'}',
                                        style: MyTextStyle.h6.bold,
                                      ),
                                      Spaces.smallVertical(),
                                      Text(
                                        item.contentText ??
                                            item.threadText ??
                                            '-',
                                        style: MyTextStyle.h6,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (c, i) {
                            return Spaces.normalVertical();
                          },
                          itemCount: state.list?.length ?? 0,
                        ),
                      ],
                    ),
                    onError: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 16),
                      child: Text(
                        state.resNotif?.message ?? 'Unknown Error',
                      ),
                    ),
                  ),
                ]),
              ),
            ),
          );
        },
      ),
    );
  }
}
