import 'package:flutter_qfam/src/commons/spaces.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_qfam/src/features/forum/bloc/forum/forum_bloc.dart';
import 'package:flutter_qfam/src/features/forum/ui/detail_forum_screen.dart';
import 'package:flutter_qfam/src/styles/my_colors.dart';
import 'package:flutter_qfam/src/styles/my_font_weight.dart';
import 'package:flutter_qfam/src/styles/my_text_style.dart';
import 'package:flutter_qfam/src/widgets/widgets.dart';
import 'package:getwidget/getwidget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class PostThreadScreen extends StatefulWidget {
  static const String routeName = '/post-thread';
  final int? argument;
  const PostThreadScreen({Key? key, this.argument}) : super(key: key);

  @override
  _PostThreadScreenState createState() => _PostThreadScreenState();
}

class _PostThreadScreenState extends State<PostThreadScreen> {
  ForumBloc bloc = ForumBloc();
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    super.initState();
    bloc.add(ForumEventOnChangeThread(parentId: widget.argument));
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
            onTap: () async {
              bloc.add(await ForumEventPostThread());
              Navigator.pop(context, true);
            },
            onTapBack: () {
              Navigator.pop(context);
            },
            child: 'Post ${widget.argument == 0 ? 'Diskusi' : 'Balasan'}',
            icon: Text('Simpan', style: MyTextStyle.h5.bold.copyWith(color: MyColors.background),),),
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
                      return Wrapper(
                        state: state.state,
                        onLoaded: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.all(10),
                                  child: GFAvatar(
                                    backgroundImage: NetworkImage(
                                        'https://i.pinimg.com/originals/7c/c7/a6/7cc7a630624d20f7797cb4c8e93c09c1.png'),
                                    size: 25,
                                    backgroundColor: MyColors.background,
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    margin: EdgeInsets.only(right: 10),
                                    child: TextField(
                                      controller:bloc.txtContent,
                                      autofocus: true,
                                      minLines: 12,
                                      maxLines: 12,
                                      maxLength: 250,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText:
                                            'Bagikan atau tanyakan sesuatu',
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            InkWell(
                              onTap: (){},
                              child: Container(
                                margin: EdgeInsets.all(10),
                                child: Row(
                                  children: [
                                    Icon(Icons.add_photo_alternate),
                                    Text('Upload gambar')
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                        onLoading: GFShimmer(
                          child: Column(
                            children: [
                              Spaces.normalVertical(),
                              Column(
                                children: [
                                  loadingBlock(dimension),
                                  Spaces.normalVertical()
                                ],
                              ),
                            ],
                          ),
                        ),
                        onError: Text(state.message),
                      );
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
