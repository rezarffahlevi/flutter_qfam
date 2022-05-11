import 'package:flutter_siap_nikah/src/commons/app_settings.dart';
import 'package:flutter_siap_nikah/src/features/article/ui/detail_article_screen.dart';
import 'package:flutter_siap_nikah/src/features/forum/ui/detail_forum_screen.dart';
import 'package:flutter_siap_nikah/src/features/home/bloc/home_root/home_root_bloc.dart';
import 'package:flutter_siap_nikah/src/features/home/ui/home_root_screen.dart';
import 'package:flutter_siap_nikah/src/features/home/ui/product_detail_screen.dart';
import 'package:flutter_siap_nikah/src/features/splash/ui/splash_screen.dart';
import 'package:flutter_siap_nikah/src/models/home/home_model.dart';
import 'package:flutter_siap_nikah/src/models/home/product_model.dart';
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
          DetailForumScreen.routeName: (context) => const DetailForumScreen(),
          DetailArticleScreen.routeName: (context) => DetailArticleScreen(
              argument: ModalRoute.of(context)?.settings.arguments as Data),
          ProductDetailScreen.routeName: (context) => ProductDetailScreen(
              argument:
                  ModalRoute.of(context)?.settings.arguments as ProductModel)
        },
      ),
    );
  }
}
