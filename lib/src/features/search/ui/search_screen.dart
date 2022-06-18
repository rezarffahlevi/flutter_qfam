import 'package:flutter_qfam/src/commons/spaces.dart';
import 'package:flutter_qfam/src/features/article/ui/detail_article_screen.dart';
import 'package:flutter_qfam/src/features/home/bloc/home/home_bloc.dart';
import 'package:flutter_qfam/src/features/search/bloc/search/search_bloc.dart';
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
  SearchBloc bloc = SearchBloc();
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
      create: (BuildContext context) => SearchBloc(),
      child: Scaffold(
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
                        onLoaded: ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 16),
                          itemBuilder: (c, i) {
                            final article = state.contentsList![i];
                            return GestureDetector(
                              onTap: () {
                                Navigator.of(context).pushNamed(
                                    DetailArticleScreen.routeName,
                                    arguments: article);
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  GFImageOverlay(
                                    color: MyColors.greyPlaceHolder,
                                    height: 130,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8)),
                                    image:
                                        NetworkImage(article.thumbnail ?? ''),
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
                                    style: MyTextStyle.contentDescription,
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
                        onError: Text(state.message ?? 'Unknown Error'));
                  }),
            ]),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Add your onPressed code here!
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
