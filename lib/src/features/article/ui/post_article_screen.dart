import 'package:flutter_qfam/src/commons/spaces.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_qfam/src/features/article/bloc/detail_article/detail_article_bloc.dart';
import 'package:flutter_qfam/src/features/forum/bloc/forum/forum_bloc.dart';
import 'package:flutter_qfam/src/features/forum/ui/detail_forum_screen.dart';
import 'package:flutter_qfam/src/helpers/helpers.dart';
import 'package:flutter_qfam/src/models/contents/contents_model.dart';
import 'package:flutter_qfam/src/styles/my_colors.dart';
import 'package:flutter_qfam/src/styles/my_font_weight.dart';
import 'package:flutter_qfam/src/styles/my_text_style.dart';
import 'package:flutter_qfam/src/widgets/card/textfield.dart';
import 'package:flutter_qfam/src/widgets/widgets.dart';
import 'package:getwidget/getwidget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class PostArticleScreen extends StatefulWidget {
  static const String routeName = '/post-article';
  final ContentsModel? argument; 
  const PostArticleScreen({Key? key, this.argument}) : super(key: key);

  @override
  _PostArticleScreenState createState() => _PostArticleScreenState();
}

class _PostArticleScreenState extends State<PostArticleScreen> {
  DetailArticleBloc bloc = DetailArticleBloc();
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  

  @override
  void initState() {
    super.initState();
    bloc.add(DetailArticleEventInitPost());
    final bool isEdit = widget.argument?.id != null;
    if(isEdit){
      ContentsModel? data = widget.argument;
      bloc.txtTitle.text = data?.title ?? '';
      bloc.txtSubtitle.text = data?.subtitle ?? '';
      bloc.txtContent.text = data?.content ?? '';
      bloc.txtThumbnail.text = data?.thumbnail ?? '';
      bloc.txtSourceBy.text = data?.sourceBy ?? '';
      bloc.txtVerifiedBy.text = data?.verifiedBy ?? '';
      bloc.add(DetailArticleEventOnChange(
        id: data?.id,
        title: data?.title,
        subtitle: data?.subtitle,
        categoryId: data?.categoryId,
        isExternal: data?.isExternal,
        isVideo: data?.isVideo,
        content: data?.content,
        thumbnail: data?.thumbnail,
        sourceBy: data?.sourceBy,
        verifiedBy: data?.verifiedBy,
        status: data?.status,
      ));
    }
  }

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dimension = MediaQuery.of(context).size;
    final bool isEdit = widget.argument?.id != null;

    return BlocProvider(
      create: (BuildContext context) => bloc,
      child: GestureDetector(
        onTap: () {
          Helpers.dismissKeyboard(context);
        },
        child: Scaffold(
          appBar: appBar(
            onTapBack: () {
              Navigator.pop(context);
            },
            child: '${isEdit ? 'Ubah' : 'Post'} Artikel',
          ),
          body: SmartRefresher(
            enablePullDown: true,
            enablePullUp: false,
            controller: _refreshController,
            onRefresh: () => bloc.add(DetailArticleEventRefresh()),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  BlocConsumer<DetailArticleBloc, DetailArticleState>(
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
                                      controller: bloc.txtTitle,
                                      keyboardType: TextInputType.name),
                                  Spaces.normalVertical(),
                                  _entryField('Sub Judul',
                                      controller: bloc.txtSubtitle,
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
                                        value: state.formdata?.categoryId,
                                        onChanged: (newValue) {
                                          bloc.add(DetailArticleEventOnChange(
                                              categoryId: int.tryParse(
                                                  newValue.toString())));
                                        },
                                        items: state.categoryList
                                            ?.map((value) => DropdownMenuItem(
                                                  value: value.id,
                                                  child:
                                                      Text('${value.category}'),
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
                                        value: state.formdata?.isExternal == 0
                                            ? 'YA'
                                            : 'TIDAK',
                                        onChanged: (newValue) {
                                          bloc.add(DetailArticleEventOnChange(
                                              isExternal:
                                                  newValue == 'YA' ? 0 : 1));
                                        },
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
                                  state.formdata?.isExternal == 1
                                      ? Container()
                                      : Column(
                                          children: [
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
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              child:
                                                  DropdownButtonHideUnderline(
                                                child: GFDropdown(
                                                  padding:
                                                      const EdgeInsets.all(15),
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  border: const BorderSide(
                                                      color: Colors.black12,
                                                      width: 1),
                                                  dropdownButtonColor:
                                                      Colors.white,
                                                  value:
                                                      state.formdata?.isVideo ==
                                                              1
                                                          ? 'YA'
                                                          : 'TIDAK',
                                                  onChanged: (newValue) {
                                                    bloc.add(
                                                        DetailArticleEventOnChange(
                                                            isVideo:
                                                                newValue == 'YA'
                                                                    ? 1
                                                                    : 0));
                                                  },
                                                  items: [
                                                    'YA',
                                                    'TIDAK',
                                                  ]
                                                      .map((value) =>
                                                          DropdownMenuItem(
                                                            value: value,
                                                            child: Text(value),
                                                          ))
                                                      .toList(),
                                                ),
                                              ),
                                            ),
                                            Spaces.normalVertical(),
                                          ],
                                        ),
                                  state.formdata?.isExternal == 0 &&
                                          state.formdata?.isVideo == 0
                                      ? Container()
                                      : _entryField(
                                          state.formdata?.isVideo == 1
                                              ? 'Link Video'
                                              : 'Link Article',
                                          controller: bloc.txtLink,
                                          keyboardType: TextInputType.text),
                                  Spaces.normalVertical(),
                                  state.formdata?.isExternal == 1
                                      ? Container()
                                      : TextField(
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
                                              borderSide: BorderSide(
                                                  color: Colors.blue),
                                            ),
                                          ),
                                        ),
                                  Spaces.normalVertical(),
                                  _entryField('Thumbnail',
                                      controller: bloc.txtThumbnail),
                                  Spaces.normalVertical(),
                                  _entryField('Sumber Dari',
                                      controller: bloc.txtSourceBy),
                                  Spaces.normalVertical(),
                                  _entryField('Terverifikasi Oleh',
                                      controller: bloc.txtVerifiedBy),
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
                                        value: state.formdata?.status,
                                        onChanged: (newValue) {
                                          bloc.add(DetailArticleEventOnChange(
                                              status: newValue.toString()));
                                        },
                                        items: [
                                          'published',
                                          'unpublish',
                                        ]
                                            .map((value) => DropdownMenuItem(
                                                  value: value,
                                                  child: Text(
                                                    value.capitalize(),
                                                  ),
                                                ))
                                            .toList(),
                                      ),
                                    ),
                                  ),
                                  Spaces.normalVertical(),
                                  GFButton(
                                    onPressed: () {
                                      bloc.add(DetailArticleEventOnPost());
                                    },
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
