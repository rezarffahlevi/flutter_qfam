import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_qfam/src/commons/spaces.dart';
import 'package:flutter_qfam/src/features/article/bloc/detail_article/detail_article_bloc.dart';
import 'package:flutter_qfam/src/models/contents/banner_model.dart';
import 'package:flutter_qfam/src/models/contents/contents_model.dart';
import 'package:flutter_qfam/src/styles/my_text_style.dart';
import 'package:flutter_qfam/src/widgets/widgets.dart';
import 'package:getwidget/getwidget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class DetailArticleScreen extends StatefulWidget {
  static const String routeName = '/detail-article';
  final ContentsModel argument;
  const DetailArticleScreen({Key? key, required this.argument})
      : super(key: key);

  @override
  _DetailArticleScreenState createState() => _DetailArticleScreenState();
}

class _DetailArticleScreenState extends State<DetailArticleScreen> {
  final DetailArticleBloc bloc = DetailArticleBloc();

  @override
  void initState() {
    super.initState();
    bloc.add(DetailArticleEventGetDetail(uuid: widget.argument.uuid));
  }

  @override
  void dispose() {
    bloc.close();
    if (widget.argument.isVideo == 1) bloc.ytController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dimension = MediaQuery.of(context).size;

    return BlocProvider(
      create: (BuildContext context) => DetailArticleBloc(),
      child: Scaffold(
        appBar: appBar(
            child: widget.argument.title ?? "Detail",
            onTapBack: () {
              Navigator.pop(context);
            }),
        body: SmartRefresher(
          enablePullDown: true,
          enablePullUp: false,
          controller: bloc.refreshController,
          // onRefresh: () => bloc.add(HomeEventRefresh()),
          child: SingleChildScrollView(
            child: Column(children: [
              BlocConsumer<DetailArticleBloc, DetailArticleState>(
                  bloc: bloc,
                  listener: (context, state) {
                    bloc.refreshController.refreshCompleted();
                    bloc.refreshController.loadComplete();
                  },
                  builder: (context, state) {
                    ContentsModel? detail = widget.argument;
                    final bannerList = state.bannerList;
                    return Wrapper(
                      state: state.state,
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
                      onLoaded: Container(
                        child: Column(
                          children: [
                            state.detail?.isVideo == 1
                                ? YoutubePlayerIFrame(
                                    controller: bloc.ytController,
                                    aspectRatio: 16 / 9,
                                  )
                                : _renderBanner(bannerList, state.activeBanner),
                            Container(
                              padding: EdgeInsets.only(
                                  left: 16, right: 16, top: 16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${detail.title}',
                                    style: MyTextStyle.contentTitle,
                                  ),
                                  Spaces.smallVertical(),
                                  Text(
                                    '${detail.subtitle}',
                                    style: MyTextStyle.sessionTitle,
                                  ),
                                  Spaces.normalVertical(),
                                  Html(
                                    data: detail.content,
                                    onLinkTap: (url, _, __, ___) {
                                      print("Opening $url...");
                                    },
                                    onImageTap: (src, _, __, ___) {
                                      print(src);
                                    },
                                    onImageError: (exception, stackTrace) {
                                      print(exception);
                                    },
                                    onCssParseError: (css, messages) {
                                      print("css that errored: $css");
                                      print("error messages:");
                                      messages.forEach((element) {
                                        print(element);
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      onError: Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: Text(state.message ?? 'Unknown Error'),
                        ),
                      ),
                    );
                  }),
            ]),
          ),
        ),
      ),
    );
  }

  Widget _renderBanner(bannerList, activeBanner) {
    if (bannerList.length > 0) {
      return Column(
        children: [
          GFCarousel(
            items: bannerList.map<Widget>(
              (item) {
                return Container(
                  margin: EdgeInsets.all(8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    child: Image.network(item.link ?? '',
                        fit: BoxFit.cover, width: 1000.0),
                  ),
                );
              },
            ).toList(),
            onPageChanged: (index) {
              bloc.add(DetailArticleEventSetActiveBanner(activeBanner: index));
            },
            aspectRatio: 1.5 / 1,
            enlargeMainPage: true,
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

///
class Controls extends StatelessWidget {
  ///
  const Controls();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [],
      ),
    );
  }
}
