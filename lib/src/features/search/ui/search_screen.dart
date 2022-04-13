import 'package:flutter_siap_nikah/src/commons/spaces.dart';
import 'package:flutter_siap_nikah/src/features/home/bloc/home/home_bloc.dart';
import 'package:flutter_siap_nikah/src/features/home/ui/product_detail_screen.dart';
import 'package:flutter_siap_nikah/src/features/search/bloc/search/search_bloc.dart';
import 'package:flutter_siap_nikah/src/styles/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_siap_nikah/src/styles/my_text_style.dart';
import 'package:flutter_siap_nikah/src/widgets/general.dart';
import 'package:getwidget/getwidget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter_siap_nikah/src/widgets/card/card_product_list.dart';
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
          body: SafeArea(
        child: Stack(
          children: [
            Container(
              margin: EdgeInsets.only(top: 60),
              child: SmartRefresher(
                enablePullDown: true,
                enablePullUp: false,
                controller: _refreshController,
                onRefresh: () => bloc.add(SearchEventRefresh()),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      BlocConsumer<SearchBloc, SearchState>(
                          bloc: bloc,
                          listener: (context, state) {
                            _refreshController.refreshCompleted();
                            _refreshController.loadComplete();
                          },
                          builder: (context, state) {

                            return Column(
                              children: [
                                Spaces.normalVertical(),
                                
                              ],
                            );
                          }),
                    ],
                  ),
                ),
              ),
            ),
            appBar(onTap: () {}, icon: Icons.filter_list, child: 'Cari'),
          ],
        ),
      )),
    );
  }

}
