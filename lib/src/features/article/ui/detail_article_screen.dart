import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_qfam/src/features/article/bloc/detail_article/detail_article_bloc.dart';
import 'package:flutter_qfam/src/models/contents/contents_model.dart';
import 'package:flutter_qfam/src/widgets/widgets.dart';

class DetailArticleScreen extends StatefulWidget {
  static const String routeName = '/detail-article';
  final ContentsModel argument;
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
            // child: widget.argument.t itle ?? "Detail",
            onTapBack: () {
              Navigator.pop(context);
            }),
        body: Container(),
      ),
    );
  }
}
