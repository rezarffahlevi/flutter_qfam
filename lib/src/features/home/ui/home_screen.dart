import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_qfam/src/commons/spaces.dart';
import 'package:flutter_qfam/src/features/article/ui/detail_article_screen.dart';
import 'package:flutter_qfam/src/features/auth/bloc/auth_bloc.dart';
import 'package:flutter_qfam/src/features/home/bloc/home/home_bloc.dart';
import 'package:flutter_qfam/src/features/home/bloc/home_root/home_root_bloc.dart';
import 'package:flutter_qfam/src/features/notification/ui/notification_screen.dart';
import 'package:flutter_qfam/src/helpers/helpers.dart';
import 'package:flutter_qfam/src/styles/my_colors.dart';
import 'package:flutter_qfam/src/styles/my_text_style.dart';
import 'package:flutter_qfam/src/widgets/card/list_tile.dart';
import 'package:flutter_qfam/src/widgets/widgets.dart';
import 'package:getwidget/getwidget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late AuthBloc authBloc;
  late HomeRootBloc rootBloc;
  HomeBloc bloc = HomeBloc();
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    super.initState();
    authBloc = context.read<AuthBloc>();
    rootBloc = context.read<HomeRootBloc>();
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
      child: BlocConsumer<HomeBloc, HomeState>(
          bloc: bloc,
          listener: (context, state) {
            _refreshController.refreshCompleted();
            _refreshController.loadComplete();
          },
          builder: (context, state) {
            final bannerList = state.bannerList;
            final sections = state.sections;

            return Scaffold(
              appBar: appBar(
                  onTap: () {
                    Navigator.of(context)
                        .pushNamed(NotificationScreen.routeName);
                  },
                  fontFamily: 'GreatVibes',
                  photo: authBloc.state.currentUser?.photo),
              body: SmartRefresher(
                enablePullDown: true,
                enablePullUp: false,
                controller: _refreshController,
                onRefresh: () {
                  bloc.add(HomeEventRefresh());
                  authBloc.add(AuthEventGetCurrentUser());
                },
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      _renderBanner(bannerList, state.activeBanner),
                      Spaces.normalVertical(),
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
                        onLoaded: _renderArticle(dimension, state, sections),
                        onError: Align(
                          alignment: Alignment.center,
                          child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15.0),
                              child: Text(state.message ?? 'Unknown Error')),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }

  Widget _renderArticle(dimension, state, sections) {
    onTapAll(item) {
      if (item.title.contains('Program Kami')) {
        debugPrint('asdsa');
      } else {
        // Navigator.of(context)
        //     .pushNamed(SearchScreen.routeName, arguments: 'HOME');
        rootBloc.add(HomeRootEventSelectedIndex(index: 1));
      }
    }

    onTapCard({item, isProgram = false}) {
      if (isProgram) {
        debugPrint('asdsa');
      } else {
        Navigator.of(context)
            .pushNamed(DetailArticleScreen.routeName, arguments: item);
      }
    }

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (c, i) {
        final item = sections[i];
        switch (item.type) {
          case "column-list":
            return sectionWidget(
              item.title ?? '-',
              onTapAll: () => onTapAll(item),
              child: Container(
                width: dimension.width,
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.only(left: 16, right: 16),
                  itemBuilder: (c, j) {
                    final article = item.contents?[j];
                    return GestureDetector(
                      onTap: () {
                        onTapCard(
                            item: article,
                            isProgram: item.title.contains('Program Kami'));
                      },
                      child: Material(
                        elevation: 1.0,
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(8),
                        child: Container(
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: MyColors.white,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: <Widget>[
                              Container(
                                width: 100.0,
                                height: 100.0,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image:
                                        NetworkImage(article?.thumbnail ?? ''),
                                  ),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8.0)),
                                  color: Colors.grey,
                                ),
                              ),
                              Spaces.smallHorizontal(),
                              Flexible(
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      article?.category ?? '',
                                      style: MyTextStyle.h7
                                          .copyWith(color: MyColors.primary),
                                    ),
                                    Text(
                                      article?.title ?? '',
                                      style: MyTextStyle.h6.semiBold
                                          .copyWith(color: MyColors.black),
                                    ),
                                    Spaces.smallVertical(),
                                    Column(
                                      children: [
                                        RichText(
                                          softWrap: true,
                                          text: new TextSpan(
                                            children: [
                                              new TextSpan(
                                                text: article.sourceBy == null
                                                    ? 'Dibuat oleh '
                                                    : 'Sumber dari ',
                                                style: MyTextStyle
                                                    .contentDescription,
                                              ),
                                              new TextSpan(
                                                text:
                                                    '${article.sourceBy ?? article.createdByName}',
                                                style: new TextStyle(
                                                  color: MyColors.link,
                                                ),
                                              ),
                                              WidgetSpan(
                                                child: article.verifiedBy ==
                                                        null
                                                    ? Container()
                                                    : Icon(
                                                        Icons.verified_outlined,
                                                        color: MyColors.primary,
                                                        size: 18,
                                                      ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (c, i) {
                    return Spaces.smallVertical();
                  },
                  itemCount: item.contents?.length ?? 0,
                ),
              ),
            );

          case "column-tile":
            return sectionWidget(
              item.title ?? '-',
              onTapAll: () => onTapAll(item),
              child: Container(
                width: dimension.width,
                margin: EdgeInsets.symmetric(
                  horizontal: 16,
                ),
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (c, j) {
                    final article = item.contents?[j];
                    return GestureDetector(
                      onTap: () {
                        onTapCard(
                            item: article,
                            isProgram: item.title.contains('Program Kami'));
                      },
                      child: Material(
                        elevation: 1.0,
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(8),
                        child: Container(
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: MyColors.white,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                article?.title ?? '-',
                                style: MyTextStyle.sessionTitle,
                              ),
                              Spaces.smallVertical(),
                              GFImageOverlay(
                                color: MyColors.greyPlaceHolder,
                                height: 120,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8)),
                                image: NetworkImage(article?.thumbnail ?? ''),
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
                                '${article?.category}',
                                style: MyTextStyle.h7.bold.copyWith(
                                  color: MyColors.primary,
                                ),
                              ),
                              Row(
                                children: [
                                  RichText(
                                    text: new TextSpan(
                                      children: [
                                        new TextSpan(
                                          text: article.sourceBy == null
                                              ? 'Dibuat oleh '
                                              : 'Sumber dari ',
                                          style: MyTextStyle.contentDescription,
                                        ),
                                        new TextSpan(
                                          text:
                                              '${article.sourceBy ?? article.createdByName}',
                                          style: new TextStyle(
                                              color: MyColors.link),
                                        ),
                                      ],
                                    ),
                                  ),
                                  article.verifiedBy == null
                                      ? Container()
                                      : Icon(
                                          Icons.verified_outlined,
                                          color: MyColors.primary,
                                          size: 18,
                                        ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (c, i) {
                    return Spaces.smallVertical();
                  },
                  itemCount: item.contents?.length ?? 0,
                ),
              ),
            );
          case "row-tile":
            return sectionWidget(
              item.title ?? '-',
              onTapAll: () => onTapAll(item),
              child: Container(
                width: dimension.width,
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (c, j) {
                    var article = item.contents?[j];
                    return GestureDetector(
                      onTap: () {
                        onTapCard(
                            item: article,
                            isProgram: item.title.contains('Program Kami'));
                      },
                      child: MyListTile(
                        // margin: EdgeInsets.all(0),
                        avatar: GFAvatar(
                          shape: GFAvatarShape.square,
                          size: 60,
                          borderRadius: BorderRadius.circular(10),
                          backgroundImage: NetworkImage('${article.thumbnail}'),
                        ),
                        color: MyColors.background,
                        titleText: article.title,
                        subTitleText: '${article.subtitle}',
                        // icon: Icon(Icons.favorite),
                      ),
                    );
                  },
                  separatorBuilder: (c, i) {
                    return Container();
                  },
                  itemCount: item.contents?.length ?? 0,
                ),
              ),
            );
          case "row-list":
            return sectionWidget(
              item?.title ?? '-',
              onTapAll: () => onTapAll(item),
              child: Container(
                width: dimension.width,
                height: 245,
                child: ListView.separated(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (c, j) {
                    final article = item.contents?[j];
                    return GestureDetector(
                      onTap: () {
                        onTapCard(
                            item: article,
                            isProgram: item.title.contains('Program Kami'));
                      },
                      child: Material(
                        elevation: 1.0,
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(8),
                        child: Container(
                          width: item.contents.length > 1
                              ? dimension.width - 60
                              : dimension.width - 32,
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: MyColors.white,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                article?.title ?? '-',
                                style: MyTextStyle.sessionTitle,
                              ),
                              Spaces.smallVertical(),
                              GFImageOverlay(
                                color: MyColors.greyPlaceHolder,
                                height: 120,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8)),
                                image: NetworkImage(article?.thumbnail ?? ''),
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
                                '${article?.category}',
                                style: MyTextStyle.h7.bold.copyWith(
                                  color: MyColors.primary,
                                ),
                              ),
                              Column(
                                children: [
                                  RichText(
                                    text: new TextSpan(
                                      children: [
                                        new TextSpan(
                                          text: article.sourceBy == null
                                              ? 'Dibuat oleh '
                                              : 'Sumber dari ',
                                          style: MyTextStyle.contentDescription,
                                        ),
                                        new TextSpan(
                                          text:
                                              '${article.sourceBy ?? article.createdByName}',
                                          style: new TextStyle(
                                              color: MyColors.link),
                                        ),
                                        WidgetSpan(
                                          child: article.verifiedBy == null
                                              ? Container()
                                              : Icon(
                                                  Icons.verified_outlined,
                                                  color: MyColors.primary,
                                                  size: 18,
                                                ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (c, i) {
                    return Spaces.normalHorizontal();
                  },
                  itemCount: item.contents?.length ?? 0,
                ),
              ),
            );
          case "row-list-profile":
            return sectionWidget(
              item.title ?? '-',
              onTapAll: () => onTapAll(item),
              child: Container(
                width: dimension.width,
                height: 210,
                child: ListView.separated(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  itemBuilder: (c, j) {
                    final article = item?.contents?[j];
                    return GestureDetector(
                      onTap: () {
                        onTapCard(
                            item: article,
                            isProgram: item.title.contains('Program Kami'));
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 210,
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
                                            NetworkImage(article.thumbnail),
                                      ),
                                      Spaces.normalVertical(),
                                      Text(article?.title ?? '-',
                                          style: MyTextStyle.h5.bold,
                                          maxLines: 2,
                                          textAlign: TextAlign.center,
                                          overflow: TextOverflow.ellipsis),
                                      Spaces.smallVertical(),
                                      Text('${article?.subtitle}',
                                          style: MyTextStyle.contentDescription,
                                          maxLines: 2,
                                          textAlign: TextAlign.center,
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
                      ),
                    );
                  },
                  separatorBuilder: (c, i) {
                    return Spaces.normalHorizontal();
                  },
                  itemCount: item.contents?.length ?? 0,
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
      itemCount: sections.length,
    );
  }

  Widget _renderBanner(bannerList, activeBanner) {
    if (bannerList.length > 0) {
      return Column(
        children: [
          Spaces.normalVertical(),
          GFCarousel(
            items: bannerList.map<Widget>(
              (item) {
                return GestureDetector(
                  onTap: () {
                    Helpers.launchURL(url: item.link);
                  },
                  child: Container(
                    margin: EdgeInsets.all(8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      child: Image.network(item.link ?? '',
                          fit: BoxFit.cover, width: 1000.0),
                    ),
                  ),
                );
              },
            ).toList(),
            onPageChanged: (index) {
              bloc.add(HomeEventSetActiveBanner(activeBanner: index));
            },
            aspectRatio: 3 / 1,
            enlargeMainPage: true,
            autoPlay: true,
            pauseAutoPlayOnTouch: Duration(seconds: 3),
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (var i = 0; i < bannerList.length; i++)
                  Container(
                    width: 8.0,
                    height: 8.0,
                    margin:
                        const EdgeInsets.symmetric(vertical: 2, horizontal: 2),
                    decoration: BoxDecoration(
                      // border: activeBanner == i
                      //     ? widget.activeDotBorder
                      //     : widget.passiveDotBorder,
                      shape: BoxShape.circle,
                      color: activeBanner == i
                          ? const Color.fromRGBO(0, 0, 0, 0.9)
                          : const Color.fromRGBO(0, 0, 0, 0.4),
                    ),
                  ),
              ],
            ),
          )
        ],
      );
    }
    return Container();
  }
}
