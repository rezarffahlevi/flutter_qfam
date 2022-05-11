import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_siap_nikah/src/features/article/bloc/detail_article/detail_article_bloc.dart';
import 'package:flutter_siap_nikah/src/models/home/home_model.dart';
import 'package:flutter_siap_nikah/src/widgets/widgets.dart';

class DetailArticleScreen extends StatefulWidget {
  static const String routeName = '/detail-article';
  final Data argument;
  const DetailArticleScreen({Key? key, required this.argument}) : super(key: key);

  @override
  _DetailArticleScreenState createState() => _DetailArticleScreenState();
}

class _DetailArticleScreenState extends State<DetailArticleScreen> {
  late final DetailArticleBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = DetailArticleBloc();
  }

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => DetailArticleBloc(),
      child: Scaffold(
        appBar: appBar(
            child: widget.argument.title ?? "Detail",
            onTapBack: () {
              Navigator.pop(context);
            }),
        body: Container(),
      ),
    );
  }
}
