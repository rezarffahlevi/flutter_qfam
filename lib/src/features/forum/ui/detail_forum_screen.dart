import 'package:flutter_qfam/src/commons/spaces.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_qfam/src/features/forum/bloc/forum/forum_bloc.dart';
import 'package:flutter_qfam/src/features/home/bloc/home/home_bloc.dart';
import 'package:flutter_qfam/src/models/forum/threads_model.dart';
import 'package:flutter_qfam/src/widgets/widgets.dart';
import 'package:getwidget/getwidget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class DetailForumScreen extends StatefulWidget {
  static const String routeName = '/detail-forum';
  final ThreadsModel argument;

  const DetailForumScreen({Key? key, required this.argument}) : super(key: key);

  @override
  _DetailForumScreenState createState() => _DetailForumScreenState();
}

class _DetailForumScreenState extends State<DetailForumScreen> {
  ForumBloc bloc = ForumBloc();
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    bloc.add(ForumEventGetData(uuid: widget.argument.uuid));
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
      create: (BuildContext context) => ForumBloc(),
      child: Scaffold(
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
            onRefresh: () => bloc.add(ForumEventGetData(uuid: widget.argument.uuid)),
            child: SingleChildScrollView(
              child: BlocConsumer<ForumBloc, ForumState>(
                  bloc: bloc,
                  listener: (context, state) {
                    _refreshController.refreshCompleted();
                    _refreshController.loadComplete();
                  },
                  builder: (context, state) {
                    ThreadsModel detail = state.threads!.length > 0
                        ? state.threads![0]
                        : ThreadsModel();
                    return Column(
                      children: [
                        Threads(
                          isDetail: true,
                          name: detail.name,
                          content: detail.content,
                        ),
                        Wrapper(
                          state: state.state,
                          onLoaded: ListView.separated(
                            padding: EdgeInsets.all(8),
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (c, i) {
                              ThreadsModel item = detail.child![i];
                              return Threads(
                                onTap: () => Navigator.pushNamed(
                                    context, DetailForumScreen.routeName,
                                    arguments: item),
                                name: item.name,
                                content: item.content,
                              );
                            },
                            separatorBuilder: (c, i) {
                              return Spaces.normalHorizontal();
                            },
                            itemCount: detail.child?.length ?? 0,
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
                    );
                  }),
            ),
          )),
    );
  }
}
