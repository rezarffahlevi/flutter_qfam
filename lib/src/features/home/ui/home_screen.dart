import 'package:flutter_siap_nikah/src/commons/spaces.dart';
import 'package:flutter_siap_nikah/src/features/home/bloc/home/home_bloc.dart';
import 'package:flutter_siap_nikah/src/features/home/ui/product_detail_screen.dart';
import 'package:flutter_siap_nikah/src/styles/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_siap_nikah/src/styles/my_text_style.dart';
import 'package:flutter_siap_nikah/src/widgets/widgets.dart';
import 'package:getwidget/getwidget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter_siap_nikah/src/widgets/card/card_product_list.dart';
import 'package:image_picker/image_picker.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeBloc bloc = HomeBloc();
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    super.initState();
    // bloc = context.read<HomeBloc>();
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
      create: (BuildContext context) => HomeBloc(),
      child: Scaffold(
          appBar: appBar(onTap: () {}),
          body: SmartRefresher(
            enablePullDown: true,
            enablePullUp: false,
            controller: _refreshController,
            onRefresh: () => bloc.add(HomeEventRefresh()),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  BlocConsumer<HomeBloc, HomeState>(
                      bloc: bloc,
                      listener: (context, state) {
                        _refreshController.refreshCompleted();
                        _refreshController.loadComplete();
                      },
                      builder: (context, state) {
                        final listCategory = state.listCategory;
                        final listHome = state.listHome;

                        return Column(
                          children: [
                            Spaces.normalVertical(),
                            Wrapper(
                              state: state.state,
                              onLoading: GFShimmer(
                                child: _categoryBlock(dimension),
                              ),
                              onLoaded: sectionWidget(
                                'Kategori',
                                child: _categorySection(listCategory, state),
                                onTapAll: () {
                                  debugPrint('Hii');
                                },
                              ),
                              onError: sectionWidget('Kategori',
                                  child: Align(
                                    alignment: Alignment.topLeft,
                                    child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15.0),
                                        child: Text(
                                            state.message ?? 'Unknown Error')),
                                  )),
                            ),
                            Wrapper(
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
                              onLoaded:
                                  _renderArticle(dimension, state, listHome),
                              onError: sectionWidget('Pranikah',
                                  child: Align(
                                    alignment: Alignment.topLeft,
                                    child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15.0),
                                        child: Text(
                                            state.message ?? 'Unknown Error')),
                                  )),
                            ),
                          ],
                        );
                      }),
                ],
              ),
            ),
          )),
    );
  }

  Widget _renderArticle(dimension, state, listHome) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (c, i) {
        final item = listHome[i];
        switch (item.type) {
          case "column-list":
            return sectionWidget(
              item.title ?? '-',
              child: Container(
                width: dimension.width,
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.only(left: 16, right: 16),
                  itemBuilder: (c, j) {
                    final article = item.data?[j];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GFImageOverlay(
                          color: MyColors.greyPlaceHolder,
                          height: 130,
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          image: NetworkImage(article?.image ?? ''),
                          boxFit: BoxFit.fitWidth,
                          child: article.isVideo
                              ? Icon(
                                  Icons.play_circle,
                                  size: 50,
                                  color: Colors.white,
                                )
                              : Container(),
                        ),
                        Spaces.smallVertical(),
                        Text(
                          article?.title ?? '-',
                          style: MyTextStyle.sessionTitle,
                        ),
                        Spaces.smallVertical(),
                        Text(
                          'By ' + (article?.author ?? '-'),
                          style: MyTextStyle.contentDescription,
                        ),
                      ],
                    );
                  },
                  separatorBuilder: (c, i) {
                    return Spaces.largeVertical();
                  },
                  itemCount: item.data?.length ?? 0,
                ),
              ),
            );
          case "row-list":
            return sectionWidget(
              item.title ?? '-',
              child: Container(
                width: dimension.width,
                height: 180,
                child: ListView.separated(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemBuilder: (c, j) {
                    final article = item.data?[j];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GFImageOverlay(
                          color: MyColors.greyPlaceHolder,
                          height: 170,
                          width: 120,
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          image: NetworkImage(article?.image ?? ''),
                          boxFit: BoxFit.fitHeight,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: 10),
                                child: Text(
                                  article?.title ?? '-',
                                  style: MyTextStyle.sessionTitle.copyWith(
                                      color: MyColors.textReverse,
                                      shadows: [
                                        Shadow(
                                          offset: Offset(2.0, 2.0),
                                          blurRadius: 3.0,
                                          color: Color.fromARGB(255, 0, 0, 0),
                                        ),
                                      ]),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 10),
                                child: GFButton(
                                  onPressed: () {},
                                  text: "Lihat Detail",
                                  blockButton: true,
                                  size: 25,
                                  color: MyColors.background,
                                  textColor: MyColors.text,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                  separatorBuilder: (c, i) {
                    return Spaces.normalHorizontal();
                  },
                  itemCount: item.data?.length ?? 0,
                ),
              ),
            );
          case "row-list-profile":
            return sectionWidget(
              item.title ?? '-',
              child: Container(
                width: dimension.width,
                height: 200,
                child: ListView.separated(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  itemBuilder: (c, j) {
                    final article = item.data?[j];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 200,
                          width: 140,
                          decoration: BoxDecoration(
                              color: MyColors.background,
                              borderRadius: BorderRadius.circular(8)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    top: 10, left: 10, right: 10),
                                child: Column(
                                  children: [
                                    GFAvatar(
                                      backgroundImage:
                                          NetworkImage(article.image),
                                    ),
                                    Spaces.normalVertical(),
                                    Text(article?.title ?? '-',
                                        style: MyTextStyle.h5.bold,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis),
                                    Spaces.smallVertical(),
                                    Text(article?.author ?? '-',
                                        style: MyTextStyle.contentDescription,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis),
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 10),
                                child: GFButton(
                                  onPressed: () {},
                                  text: "Lihat Detail",
                                  blockButton: true,
                                  size: 25,
                                  color: MyColors.primary,
                                  textColor: MyColors.textReverse,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                  separatorBuilder: (c, i) {
                    return Spaces.normalHorizontal();
                  },
                  itemCount: item.data?.length ?? 0,
                ),
              ),
            );
          default:
            return Container();
        }
      },
      separatorBuilder: (c, i) {
        return Spaces.normalHorizontal();
      },
      itemCount: listHome.length,
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
                  item.name ?? '-',
                  style: MyTextStyle.h7.copyWith(
                      color: state.selectedCategory == item.id
                          ? MyColors.primary
                          : MyColors.text),
                ),
              ),
              onTap: () {
                bloc.add(HomeEventSelectedCategory(selectedCategory: item.id));
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
