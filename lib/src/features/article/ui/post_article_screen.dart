import 'package:flutter_qfam/src/commons/spaces.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_qfam/src/features/forum/bloc/forum/forum_bloc.dart';
import 'package:flutter_qfam/src/features/forum/ui/detail_forum_screen.dart';
import 'package:flutter_qfam/src/helpers/helpers.dart';
import 'package:flutter_qfam/src/styles/my_colors.dart';
import 'package:flutter_qfam/src/styles/my_font_weight.dart';
import 'package:flutter_qfam/src/styles/my_text_style.dart';
import 'package:flutter_qfam/src/widgets/card/textfield.dart';
import 'package:flutter_qfam/src/widgets/widgets.dart';
import 'package:getwidget/getwidget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class PostArticleScreen extends StatefulWidget {
  static const String routeName = '/post-article';
  final int? argument;
  const PostArticleScreen({Key? key, this.argument}) : super(key: key);

  @override
  _PostArticleScreenState createState() => _PostArticleScreenState();
}

class _PostArticleScreenState extends State<PostArticleScreen> {
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
      child: GestureDetector(
        onTap: () {
          Helpers.dismissKeyboard(context);
        },
        child: Scaffold(
          appBar: appBar(
            onTapBack: () {
              Navigator.pop(context);
            },
            child: 'Post Artikel',
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
                      },
                      builder: (context, state) {
                        return Wrapper(
                          state: state.state,
                          onLoaded: Container(
                            // height: dimension.height - 88,
                            padding: EdgeInsets.only(
                                left: 20, right: 20, top: 30, bottom: 30),
                            child: Form(
                              // key: bloc.formKey,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  _entryField('Judul',
                                      keyboardType: TextInputType.name),
                                  Spaces.normalVertical(),
                                  _entryField('Sub Judul',
                                      keyboardType: TextInputType.phone),
                                  Spaces.normalVertical(),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Kategori',
                                      style: MyTextStyle.h5.bold,
                                    ),
                                  ),
                                  Spaces.smallVertical(),
                                  Container(
                                    height: 50,
                                    width: MediaQuery.of(context).size.width,
                                    child: DropdownButtonHideUnderline(
                                      child: GFDropdown(
                                        padding: const EdgeInsets.all(15),
                                        borderRadius: BorderRadius.circular(5),
                                        border: const BorderSide(
                                            color: Colors.black12, width: 1),
                                        dropdownButtonColor: Colors.white,
                                        value: 'YA',
                                        onChanged: (newValue) {},
                                        items: [
                                          'YA',
                                          'TIDAK',
                                        ]
                                            .map((value) => DropdownMenuItem(
                                                  value: value,
                                                  child: Text(value),
                                                ))
                                            .toList(),
                                      ),
                                    ),
                                  ),
                                  Spaces.normalVertical(),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Konten Internal',
                                      style: MyTextStyle.h5.bold,
                                    ),
                                  ),
                                  Spaces.smallVertical(),
                                  Container(
                                    height: 50,
                                    width: MediaQuery.of(context).size.width,
                                    child: DropdownButtonHideUnderline(
                                      child: GFDropdown(
                                        padding: const EdgeInsets.all(15),
                                        borderRadius: BorderRadius.circular(5),
                                        border: const BorderSide(
                                            color: Colors.black12, width: 1),
                                        dropdownButtonColor: Colors.white,
                                        value: 'YA',
                                        onChanged: (newValue) {},
                                        items: [
                                          'YA',
                                          'TIDAK',
                                        ]
                                            .map((value) => DropdownMenuItem(
                                                  value: value,
                                                  child: Text(value),
                                                ))
                                            .toList(),
                                      ),
                                    ),
                                  ),
                                  Spaces.normalVertical(),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Konten Video',
                                      style: MyTextStyle.h5.bold,
                                    ),
                                  ),
                                  Spaces.smallVertical(),
                                  Container(
                                    height: 50,
                                    width: MediaQuery.of(context).size.width,
                                    child: DropdownButtonHideUnderline(
                                      child: GFDropdown(
                                        padding: const EdgeInsets.all(15),
                                        borderRadius: BorderRadius.circular(5),
                                        border: const BorderSide(
                                            color: Colors.black12, width: 1),
                                        dropdownButtonColor: Colors.white,
                                        value: 'TIDAK',
                                        onChanged: (newValue) {},
                                        items: [
                                          'YA',
                                          'TIDAK',
                                        ]
                                            .map((value) => DropdownMenuItem(
                                                  value: value,
                                                  child: Text(value),
                                                ))
                                            .toList(),
                                      ),
                                    ),
                                  ),
                                  Spaces.normalVertical(),
                                  _entryField('Link',
                                      keyboardType: TextInputType.text),
                                  Spaces.normalVertical(),
                                  TextField(
                                    controller: bloc.txtContent,
                                    minLines: 3,
                                    maxLines: 12,
                                    decoration: InputDecoration(
                                      labelText: 'Konten',
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(6)),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(6.0),
                                        ),
                                        borderSide:
                                            BorderSide(color: Colors.blue),
                                      ),
                                    ),
                                  ),
                                  Spaces.normalVertical(),
                                  _entryField(
                                    'Tags',
                                  ),
                                  Spaces.normalVertical(),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Status',
                                      style: MyTextStyle.h5.bold,
                                    ),
                                  ),
                                  Spaces.smallVertical(),
                                  Container(
                                    height: 50,
                                    width: MediaQuery.of(context).size.width,
                                    child: DropdownButtonHideUnderline(
                                      child: GFDropdown(
                                        padding: const EdgeInsets.all(15),
                                        borderRadius: BorderRadius.circular(5),
                                        border: const BorderSide(
                                            color: Colors.black12, width: 1),
                                        dropdownButtonColor: Colors.white,
                                        value: 'Publish',
                                        onChanged: (newValue) {},
                                        items: [
                                          'Publish',
                                          'Unpublish',
                                        ]
                                            .map((value) => DropdownMenuItem(
                                                  value: value,
                                                  child: Text(value),
                                                ))
                                            .toList(),
                                      ),
                                    ),
                                  ),
                                  Spaces.normalVertical(),
                                  GFButton(
                                    onPressed: () {},
                                    text: "Simpan",
                                    shape: GFButtonShape.pills,
                                    blockButton: true,
                                  ),
                                ],
                              ),
                            ),
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

  Widget _entryField(
    String labelText, {
    TextEditingController? controller,
    String? errorText,
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.emailAddress,
  }) {
    return MyTextField(
      labelText: labelText,
      hintText: labelText,
      controller: controller,
      obscureText: obscureText,
      errorText: errorText,
      keyboardType: keyboardType,
    );
  }
}
