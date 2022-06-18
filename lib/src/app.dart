import 'package:flutter_qfam/src/commons/app_settings.dart';
import 'package:flutter_qfam/src/features/article/ui/detail_article_screen.dart';
import 'package:flutter_qfam/src/features/forum/ui/detail_forum_screen.dart';
import 'package:flutter_qfam/src/features/forum/ui/post_thread_screen.dart';
import 'package:flutter_qfam/src/features/home/bloc/home_root/home_root_bloc.dart';
import 'package:flutter_qfam/src/features/home/ui/home_root_screen.dart';
import 'package:flutter_qfam/src/features/search/ui/search_screen.dart';
import 'package:flutter_qfam/src/features/splash/ui/splash_screen.dart';
import 'package:flutter_qfam/src/models/contents/contents_model.dart';
import 'package:flutter_qfam/src/models/forum/threads_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeRootBloc>(
          create: (context) => HomeRootBloc(),
        ),
      ],
      child: MaterialApp(
        title: AppSettings.name,
        initialRoute: SplashScreen.routeName,
        theme: ThemeData(fontFamily: 'Nunito', brightness: Brightness.light),
        routes: {
          SplashScreen.routeName: (context) => const SplashScreen(),
          HomeRootScreen.routeName: (context) => const HomeRootScreen(),
          SearchScreen.routeName: (context) => const SearchScreen(),
          PostThreadScreen.routeName: (context) => PostThreadScreen(
              argument: ModalRoute.of(context)?.settings.arguments as int?),
          DetailForumScreen.routeName: (context) => DetailForumScreen(
              argument:
                  ModalRoute.of(context)?.settings.arguments as ThreadsModel),
          DetailArticleScreen.routeName: (context) => DetailArticleScreen(
              argument:
                  ModalRoute.of(context)?.settings.arguments as ContentsModel),
        },
      ),
    );
  }
}
