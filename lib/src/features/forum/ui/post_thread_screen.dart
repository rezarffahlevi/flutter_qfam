import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_qfam/src/commons/spaces.dart';
import 'package:flutter_qfam/src/features/auth/bloc/auth_bloc.dart';
import 'package:flutter_qfam/src/features/forum/bloc/forum/forum_bloc.dart';
import 'package:flutter_qfam/src/helpers/helpers.dart';
import 'package:flutter_qfam/src/models/forum/threads_model.dart';
import 'package:flutter_qfam/src/styles/my_colors.dart';
import 'package:flutter_qfam/src/styles/my_text_style.dart';
import 'package:flutter_qfam/src/widgets/widgets.dart';
import 'package:getwidget/getwidget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class PostThreadScreen extends StatefulWidget {
  static const String routeName = '/post-thread';
  final ThreadsModel? argument;
  const PostThreadScreen({Key? key, this.argument}) : super(key: key);

  @override
  _PostThreadScreenState createState() => _PostThreadScreenState();
}

class _PostThreadScreenState extends State<PostThreadScreen> {
  late AuthBloc authBloc;
  late ForumBloc bloc = ForumBloc();
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    super.initState();
    authBloc = context.read<AuthBloc>();
    bloc.add(ForumEventInitPostThread(context: context));
    bloc.add(ForumEventOnChangeThread(
        parentId: widget.argument?.parentId,
        forumId: widget.argument?.forumId,
        contentId: widget.argument?.contentId));
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
      child: GestureDetector(
        onTap: () {
          Helpers.dismissKeyboard(context);
        },
        child: Scaffold(
          appBar: appBar(
            onTap: () async {
              if (!Helpers.isEmpty(bloc.state.content))
                bloc.add(await ForumEventPostThread());
              else {
                GFToast.showToast('Anda belum menulis apapun', context,
                    toastPosition: GFToastPosition.TOP);
              }
            },
            onTapBack: () {
              Navigator.pop(context);
            },
            child:
                'Post ${widget.argument?.parentId == 0 ? 'Diskusi' : 'Balasan'}',
            icon: Text(
              'Simpan',
              style: MyTextStyle.h5.bold.copyWith(color: MyColors.background),
            ),
          ),
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
                        if (state.state == NetworkStates.onLoaded &&
                            (state.message ?? '').contains('success')) {
                          Helpers.dismissKeyboard(context);
                          GFToast.showToast('${state.message}', context,
                              toastPosition: GFToastPosition.BOTTOM);
                          Navigator.pop(context, true);
                        }
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
                                      backgroundImage: NetworkImage(authBloc
                                              .state.currentUser?.photo ??
                                          'https://i.pinimg.com/originals/7c/c7/a6/7cc7a630624d20f7797cb4c8e93c09c1.png'),
                                      size: 25,
                                      backgroundColor: MyColors.background,
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      margin: EdgeInsets.only(right: 10),
                                      child: TextField(
                                        controller: bloc.txtContent,
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
                              Container(
                                margin: EdgeInsets.only(
                                    top: 10, left: 10, right: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text("Post Sebagai Anonim: "),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            GFToggle(
                                              onChanged: (val) {
                                                if (val == true) {
                                                  bloc.add(
                                                      ForumEventOnChangeThread(
                                                          isAnonymous: 1));
                                                } else {
                                                  bloc.add(
                                                      ForumEventOnChangeThread(
                                                          isAnonymous: 0));
                                                }
                                              },
                                              value: state.isAnonymous == 1,
                                              type: GFToggleType.ios,
                                              enabledTrackColor:
                                                  MyColors.primary,
                                            ),
                                            Spaces.smallHorizontal(),
                                            Text(state.isAnonymous == 1
                                                ? "Ya"
                                                : "Tidak"),
                                          ],
                                        ),
                                      ],
                                    ),
                                    InkWell(
                                      onTap: () {
                                        bloc.add(ForumEventAddPhoto());
                                      },
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
                              ),
                              Center(
                                child: Helpers.isEmpty(state.photo?.path)
                                    ? Container()
                                    : Image.file(
                                        new File(state.photo!.path),
                                        height: 100,
                                        width: 100,
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
                          onError: Text('${state.message}'),
                        );
                      }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
