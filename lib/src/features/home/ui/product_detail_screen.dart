import 'dart:io';

import 'package:flutter_siap_nikah/src/commons/spaces.dart';
import 'package:flutter_siap_nikah/src/features/home/bloc/product_detail/product_detail_bloc.dart';
import 'package:flutter_siap_nikah/src/models/home/product_model.dart';
import 'package:flutter_siap_nikah/src/styles/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ProductDetailScreen extends StatefulWidget {
  static const String routeName = '/product-detail';
  final ProductModel argument;
  const ProductDetailScreen({Key? key, required this.argument})
      : super(key: key);

  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen>
    with TickerProviderStateMixin {
  final ProductDetailBloc bloc = ProductDetailBloc();
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  @override
  void initState() {
    super.initState();
    bloc.add(ProductDetailEventSetDetail(product: widget.argument));
    bloc.add(ProductDetailEventSetColor(
        color: widget.argument.productOptions?[0].color));
    bloc.add(ProductDetailEventSetSize(size: widget.argument.sizeOptions?[0]));
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
      create: (BuildContext context) => ProductDetailBloc(),
      child: Scaffold(
          body: SmartRefresher(
        enablePullDown: true,
        enablePullUp: false,
        controller: _refreshController,
        // onRefresh: () => bloc.add(HomeEventRefresh()),
        child: SafeArea(
          child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.center,
              stops: [
                0,
                0.9,
              ],
              colors: [
                Color(0xFFB9F5FF),
                MyColors.background,
              ],
            )),
            child: Stack(
              children: <Widget>[
                BlocConsumer<ProductDetailBloc, ProductDetailState>(
                  bloc: bloc,
                  listenWhen: (prev, curr) => prev.product != curr.product,
                  listener: (context, state) {
                    _refreshController.refreshCompleted();
                    _refreshController.loadComplete();
                  },
                  builder: (context, state) {
                    final argument = state.product;
                    int? index = argument?.productOptions
                        ?.indexWhere((element) => element.color == state.color);
                    var image = argument?.productOptions?[index ?? 0].image ??
                        'https://i.postimg.cc/G3yj3Sc0/Double-Strip-Pink.png';
                    return Container(
                        margin: EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Container(
                                      height: 40,
                                      width: 40,
                                      child: Icon(Icons.arrow_back_ios,
                                          color: Colors.black54, size: 20),
                                    ),
                                  ),
                                  Text('QuickView',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  GestureDetector(
                                    onTap: () {
                                      argument?.isFavorite =
                                          (argument.isFavorite ?? false)
                                              ? false
                                              : true;
                                      debugPrint(
                                          argument?.isFavorite.toString());
                                      bloc.add(ProductDetailEventSetDetail(
                                          product: argument));
                                    },
                                    child: Container(
                                      alignment: Alignment.topRight,
                                      child: Icon(
                                        (argument?.isFavorite ?? false)
                                            ? Icons.favorite
                                            : Icons.favorite_outline,
                                        color: Colors.red,
                                      ),
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: MyColors.background,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Spaces.normalVertical(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: 30,
                                  height: 200,
                                  child: ListView.separated(
                                      itemBuilder: (c, i) {
                                        var item = argument?.productOptions![i];
                                        return GestureDetector(
                                          onTap: () {
                                            bloc.add(ProductDetailEventSetColor(
                                                color: item?.color));
                                          },
                                          child: Container(
                                            height: 30,
                                            width: 30,
                                            decoration: BoxDecoration(
                                                color: Color(int.parse(
                                                    '0xFF${item?.color}')),
                                                borderRadius:
                                                    BorderRadius.circular(30)),
                                            child: item?.color == state.color
                                                ? Icon(
                                                    Icons.check,
                                                    color: MyColors.background,
                                                  )
                                                : null,
                                          ),
                                        );
                                      },
                                      separatorBuilder: (c, i) {
                                        return Spaces.normalVertical();
                                      },
                                      itemCount:
                                          argument?.productOptions?.length ??
                                              0),
                                ),
                                Container(child: Image.network(image)),
                                Container(
                                  width: 30,
                                  height: 200,
                                  child: ListView.separated(
                                      itemBuilder: (c, i) {
                                        var item = argument?.sizeOptions![i];
                                        return GestureDetector(
                                          onTap: () {
                                            bloc.add(ProductDetailEventSetSize(
                                                size: item));
                                          },
                                          child: Container(
                                            height: 30,
                                            width: 30,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(30)),
                                            child: Center(
                                              child: Text(
                                                item ?? '',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: (item == state.size)
                                                        ? MyColors.blue
                                                        : Colors.black45),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                      separatorBuilder: (c, i) {
                                        return Spaces.normalVertical();
                                      },
                                      itemCount:
                                          argument?.productOptions?.length ??
                                              0),
                                ),
                              ],
                            ),
                            Text(argument?.title ?? '',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20)),
                            Text(argument?.subTitle ?? ''),
                            Row(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    for (var i = 1; i <= 5; i++)
                                      Icon(
                                        i <= (argument?.rating ?? 5)
                                            ? Icons.star
                                            : Icons.star_outline,
                                        color: Colors.yellow,
                                      ),
                                  ],
                                ),
                                Spaces.smallHorizontal(),
                                Text('(${argument?.ratingCount}) Ratings',
                                    style: TextStyle(color: Colors.grey)),
                              ],
                            ),
                            Spaces.normalVertical(),
                            Text('Description',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16)),
                            Spaces.smallVertical(),
                            Text(argument?.description ?? ''),
                            Spaces.normalVertical(),
                            Text('\$ ${argument?.price}',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 22)),
                            Spaces.largeVertical(),
                            Container(
                              width: dimension.width - 20,
                              child: ElevatedButton(
                                onPressed: null,
                                child: Text(
                                  'Add to cart',
                                  style: TextStyle(color: MyColors.background),
                                ),
                                style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.resolveWith(
                                            (state) => MyColors.blue)),
                              ),
                            ),
                          ],
                        ));
                  },
                )
              ],
            ),
          ),
        ),
      )),
    );
  }
}
