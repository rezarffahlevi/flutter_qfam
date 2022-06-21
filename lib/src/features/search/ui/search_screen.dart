import 'package:flutter_qfam/src/commons/constants.dart';
import 'package:flutter_qfam/src/commons/spaces.dart';
import 'package:flutter_qfam/src/features/article/ui/detail_article_screen.dart';
import 'package:flutter_qfam/src/features/article/ui/post_article_screen.dart';
import 'package:flutter_qfam/src/features/home/bloc/home_root/home_root_bloc.dart';
import 'package:flutter_qfam/src/features/search/bloc/search/search_bloc.dart';
import 'package:flutter_qfam/src/models/profile/user_model.dart';
import 'package:flutter_qfam/src/styles/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_qfam/src/styles/my_text_style.dart';
import 'package:flutter_qfam/src/widgets/widgets.dart';
import 'package:getwidget/getwidget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter_qfam/src/widgets/card/card_product_list.dart';
import 'package:image_picker/image_picker.dart';

class SearchScreen extends StatefulWidget {
  static const String routeName = '/search';

  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late HomeRootBloc blocHomeRoot;
  SearchBloc bloc = SearchBloc();
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    super.initState();
    blocHomeRoot = context.read<HomeRootBloc>();
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
      create: (BuildContext context) => SearchBloc(),
      child: BlocBuilder<HomeRootBloc, HomeRootState>(
        bloc: blocHomeRoot,
        builder: (context, stateRoot) {
          return Scaffold(
            appBar: appBar(
                onTap: () {},
                icon: Icons.filter_list,
                child: "Edukasi",
                fontFamily: 'GreatVibes'),
            body: SmartRefresher(
              enablePullDown: true,
              enablePullUp: true,
              controller: _refreshController,
              onRefresh: () => bloc.add(SearchEventRefresh()),
              child: SingleChildScrollView(
                child: Column(children: [
                  Spaces.normalVertical(),
                  BlocConsumer<SearchBloc, SearchState>(
                      bloc: bloc,
                      listener: (context, state) {
                        _refreshController.refreshCompleted();
                        _refreshController.loadComplete();
                      },
                      builder: (context, state) {
                        return Wrapper(
                            state: state.state,
                            onLoading: GFShimmer(
                              child: Column(
                                children: [
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
                                Container(
                                  height: 50,
                                  margin: EdgeInsets.only(
                                    left: 16,
                                    right: 16,
                                    bottom: 12,
                                  ),
                                  child: new TextField(
                                    autofocus: false,
                                    decoration: new InputDecoration(
                                        contentPadding: EdgeInsets.all(0.1),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(4)),
                                          borderSide: BorderSide(
                                              width: 1, color: MyColors.text),
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        prefixIcon: new Icon(Icons.search,
                                            color: MyColors.text),
                                        hintText: "Cari...",
                                        focusColor: MyColors.text,
                                        hintStyle: new TextStyle(
                                            color: MyColors.text)),
                                  ),
                                ),
                                Wrapper(
                                  state: state.state,
                                  onLoading: GFShimmer(
                                    child: _categoryBlock(dimension),
                                  ),
                                  onLoaded: _categorySection(
                                      state.categoryList, state),
                                  onError: Align(
                                    alignment: Alignment.topLeft,
                                    child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15.0),
                                        child: Text(
                                            state.message ?? 'Unknown Error')),
                                  ),
                                ),
                                Spaces.normalVertical(),
                                ListView.separated(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  padding: EdgeInsets.only(
                                      left: 16, right: 16, bottom: 16),
                                  itemBuilder: (c, i) {
                                    final article = state.contentsList![i];
                                    return GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).pushNamed(
                                            DetailArticleScreen.routeName,
                                            arguments: article);
                                      },
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          GFImageOverlay(
                                            color: MyColors.greyPlaceHolder,
                                            height: 130,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(8)),
                                            image: NetworkImage(
                                                article.thumbnail ?? ''),
                                            boxFit: BoxFit.fitWidth,
                                            child: article.isVideo == 1
                                                ? Icon(
                                                    Icons.play_circle,
                                                    size: 50,
                                                    color: Colors.white,
                                                  )
                                                : Container(),
                                          ),
                                          Spaces.smallVertical(),
                                          Text(
                                            article.title ?? '-',
                                            style: MyTextStyle.sessionTitle,
                                          ),
                                          Spaces.smallVertical(),
                                          Text(
                                            'By ${article.createdByName}',
                                            style:
                                                MyTextStyle.contentDescription,
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                  separatorBuilder: (c, i) {
                                    return Spaces.largeVertical();
                                  },
                                  itemCount: state.contentsList?.length ?? 0,
                                ),
                              ],
                            ),
                            onError: Text(state.message ?? 'Unknown Error'));
                      }),
                ]),
              ),
            ),
            floatingActionButton: stateRoot.currentUser?.role !=
                    Constants.ROLES.USER
                ? FloatingActionButton(
                    heroTag: null,
                    onPressed: () async {
                      var postThread = await Navigator.of(context)
                          .pushNamed(PostArticleScreen.routeName, arguments: 0);
                    },
                    backgroundColor: MyColors.primary,
                    child: const Icon(
                      Icons.add,
                    ),
                  )
                : null,
          );
        },
      ),
    );
  }

  Widget _categorySection(listCategory, state) {
    return Container(
      height: 40,
      margin: EdgeInsets.symmetric(horizontal: 15),
      child: ListView.separated(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        physics: const AlwaysScrollableScrollPhysics(),
        itemBuilder: (c, i) {
          final item = listCategory[i];
          return InkWell(
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                        color: state.selectedCategory == item.id
                            ? MyColors.primary
                            : Colors.grey,
                        width: 1.4)),
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 2),
                child: Text(
                  item.category ?? '-',
                  style: MyTextStyle.h7.copyWith(
                      color: state.selectedCategory == item.id
                          ? MyColors.primary
                          : MyColors.text),
                ),
              ),
              onTap: () {
                bloc.add(
                    SearchEventSetSelectedCategory(selectedCategory: item.id));
              });
        },
        separatorBuilder: (c, i) {
          return Spaces.normalHorizontal();
        },
        itemCount: listCategory.length,
      ),
    );
  }

  Widget _categoryBlock(dimension) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: dimension.width / 3 - 20,
            height: 38,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
          ),
          Spaces.normalHorizontal(),
          Container(
            width: dimension.width / 3 - 20,
            height: 38,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
          ),
          Spaces.normalHorizontal(),
          Container(
            width: dimension.width / 3 - 20,
            height: 38,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
