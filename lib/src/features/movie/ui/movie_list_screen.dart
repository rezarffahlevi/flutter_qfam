import 'package:flutter_siap_nikah/src/features/home/ui/home_screen.dart';
import 'package:flutter_siap_nikah/src/features/movie/bloc/movie_list/movie_list_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MovieListScreen extends StatefulWidget {
  static const String routeName = '/movie-list';

  const MovieListScreen({Key? key}) : super(key: key);

  @override
  _MovieListScreenState createState() => _MovieListScreenState();
}

class _MovieListScreenState extends State<MovieListScreen> {
  late final MovieListBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = MovieListBloc();
  }

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => MovieListBloc(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Movie List Screen'),
          actions: [],
        ),
        body: Container(),
      ),
    );
  }
}
