import 'package:flutter_siap_nikah/src/commons/spaces.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_siap_nikah/src/features/forum/bloc/forum/forum_bloc.dart';
import 'package:flutter_siap_nikah/src/widgets/general.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ForumScreen extends StatefulWidget {
  static const String routeName = '/forum';

  const ForumScreen({Key? key}) : super(key: key);

  @override
  _ForumScreenState createState() => _ForumScreenState();
}

class _ForumScreenState extends State<ForumScreen> {
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
          appBar: appBar(onTap: () {}, icon: Icons.filter_list, child: "Forum"),
          body: SmartRefresher(
            enablePullDown: true,
            enablePullUp: false,
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
                        return Column(
                          children: [
                            Spaces.normalVertical(),
                          ],
                        );
                      }),
                ],
              ),
            ),
          )),
    );
  }
}
