import 'package:flutter_siap_nikah/src/commons/spaces.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_siap_nikah/src/features/forum/bloc/forum/forum_bloc.dart';
import 'package:flutter_siap_nikah/src/styles/my_colors.dart';
import 'package:flutter_siap_nikah/src/styles/my_font_weight.dart';
import 'package:flutter_siap_nikah/src/styles/my_text_style.dart';
import 'package:flutter_siap_nikah/src/widgets/widgets.dart';
import 'package:getwidget/getwidget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class DetailForumScreen extends StatefulWidget {
  static const String routeName = '/detail-forum';

  const DetailForumScreen({Key? key}) : super(key: key);

  @override
  _DetailForumScreenState createState() => _DetailForumScreenState();
}

class _DetailForumScreenState extends State<DetailForumScreen> {
  ForumBloc bloc = ForumBloc();
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    super.initState();
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
              child: "Utas",
              onTapBack: () {
                Navigator.pop(context);
              }),
          body: SmartRefresher(
            enablePullDown: true,
            enablePullUp: true,
            controller: _refreshController,
            onRefresh: () => bloc.add(ForumEventRefresh()),
            child: SingleChildScrollView(
              child: BlocConsumer<ForumBloc, ForumState>(
                  bloc: bloc,
                  listener: (context, state) {
                    _refreshController.refreshCompleted();
                    _refreshController.loadComplete();
                  },
                  builder: (context, state) {
                    return Column(
                      children: [
                        Threads(
                          isDetail: true,
                        ),
                        Wrapper(
                          state: NetworkStates.onLoaded,
                          onLoaded: ListView.separated(
                            padding: EdgeInsets.all(8),
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (c, i) {
                              return Threads(
                                  onTap: () => Navigator.pushNamed(
                                      context, DetailForumScreen.routeName));
                            },
                            separatorBuilder: (c, i) {
                              return Spaces.normalHorizontal();
                            },
                            itemCount: 5,
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
