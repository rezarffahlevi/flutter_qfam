import 'package:flutter_siap_nikah/src/commons/spaces.dart';
import 'package:flutter_siap_nikah/src/features/home/bloc/home/home_bloc.dart';
import 'package:flutter_siap_nikah/src/features/home/ui/product_detail_screen.dart';
import 'package:flutter_siap_nikah/src/styles/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_siap_nikah/src/widgets/general.dart';
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
          body: SafeArea(
        child: Stack(
          children: [
            Container(
              margin: EdgeInsets.only(top: 60),
              child: SmartRefresher(
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
                                state.state == HomeStates.onLoading
                                    ? GFShimmer(
                                        child: _categoryBlock(dimension),
                                      )
                                    : sectionWidget(
                                        'Kategori',
                                        child: _categorySection(listCategory),
                                        onTapAll: (){
                                          debugPrint('Hii');
                                        }
                                      ),
                                state.state == HomeStates.onLoading
                                    ? GFShimmer(
                                        child: Column(
                                          children: [
                                            for (var i = 0; i < 12; i++)
                                              Column(
                                                children: [
                                                  _articleBlock(dimension),
                                                  Spaces.normalVertical()
                                                ],
                                              ),
                                          ],
                                        ),
                                      )
                                    : ListView.separated(
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemBuilder: (c, i) {
                                          final item = listHome[i];
                                          return sectionWidget(
                                            item.title ?? '-',
                                            child: Container(
                                              width: dimension.width,
                                              child: ListView.separated(
                                                shrinkWrap: true,
                                                physics:
                                                    const NeverScrollableScrollPhysics(),
                                                padding: EdgeInsets.only(
                                                    left: 16, right: 16),
                                                itemBuilder: (c, j) {
                                                  final artikel = item.data?[j];
                                                  return Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      GFImageOverlay(
                                                        height: 130,
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    8)),
                                                        image: NetworkImage(
                                                            artikel?.image ??
                                                                ''),
                                                        boxFit: BoxFit.fitWidth,
                                                      ),
                                                      Spaces.smallVertical(),
                                                      Text(artikel?.title ??
                                                          '-'),
                                                      Spaces.smallVertical(),
                                                      Text('By ' +
                                                          (artikel?.author ??
                                                              '-')),
                                                    ],
                                                  );
                                                },
                                                separatorBuilder: (c, i) {
                                                  return Spaces.largeVertical();
                                                },
                                                itemCount:
                                                    item.data?.length ?? 0,
                                              ),
                                            ),
                                          );
                                        },
                                        separatorBuilder: (c, i) {
                                          return Spaces.normalHorizontal();
                                        },
                                        itemCount: listHome.length,
                                      ),
                              ],
                            );
                          }),
                    ],
                  ),
                ),
              ),
            ),
            appBar(onTap: () {}),
          ],
        ),
      )),
    );
  }

  Widget _categorySection(listCategory) {
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
                        color: i == 1 ? MyColors.primary : Colors.grey,
                        width: 1.4)),
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 2),
                child: Text(item.name ?? '-'),
              ),
              onTap: () {});
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

  Widget _articleBlock(dimension) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 54,
            height: 46,
            color: Colors.white,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: double.infinity,
                  height: 8,
                  color: Colors.white,
                ),
                const SizedBox(height: 6),
                Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  height: 8,
                  color: Colors.white,
                ),
                const SizedBox(height: 6),
                Container(
                  width: MediaQuery.of(context).size.width * 0.25,
                  height: 8,
                  color: Colors.white,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
