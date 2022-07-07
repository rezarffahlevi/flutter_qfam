
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_qfam/firebase_options.dart';
import 'package:flutter_qfam/src/commons/app_settings.dart';
import 'package:flutter_qfam/src/features/article/ui/detail_article_screen.dart';
import 'package:flutter_qfam/src/features/article/ui/post_article_screen.dart';
import 'package:flutter_qfam/src/features/auth/bloc/auth_bloc.dart';
import 'package:flutter_qfam/src/features/auth/ui/login_screen.dart';
import 'package:flutter_qfam/src/features/auth/ui/register_screen.dart';
import 'package:flutter_qfam/src/features/forum/ui/detail_forum_screen.dart';
import 'package:flutter_qfam/src/features/forum/ui/post_thread_screen.dart';
import 'package:flutter_qfam/src/features/home/bloc/home_root/home_root_bloc.dart';
import 'package:flutter_qfam/src/features/home/ui/home_root_screen.dart';
import 'package:flutter_qfam/src/features/search/ui/search_screen.dart';
import 'package:flutter_qfam/src/features/splash/ui/splash_screen.dart';
import 'package:flutter_qfam/src/helpers/helpers.dart';
import 'package:flutter_qfam/src/helpers/notification_helper.dart';
import 'package:flutter_qfam/src/models/contents/contents_model.dart';
import 'package:flutter_qfam/src/models/forum/threads_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_qfam/src/widgets/widgets.dart';
import 'package:getwidget/components/toast/gf_toast.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  NotificationHelper notificationHelper = NotificationHelper();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(),
        ),
        BlocProvider<HomeRootBloc>(
          create: (context) => HomeRootBloc(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: AppSettings.name,
        navigatorKey: Helpers.navigatorKey,
        initialRoute: SplashScreen.routeName,
        theme: ThemeData(fontFamily: 'Nunito', brightness: Brightness.light),
        routes: {
          SplashScreen.routeName: (context) => const SplashScreen(),
          HomeRootScreen.routeName: (context) => const HomeRootScreen(),
          LoginScreen.routeName: (context) => const LoginScreen(),
          RegisterScreen.routeName: (context) => const RegisterScreen(),
          SearchScreen.routeName: (context) => SearchScreen(
              argument: ModalRoute.of(context)?.settings.arguments as String?),
          PostThreadScreen.routeName: (context) => PostThreadScreen(
              argument:
                  ModalRoute.of(context)?.settings.arguments as ThreadsModel?),
          PostArticleScreen.routeName: (context) => PostArticleScreen(
              argument:
                  ModalRoute.of(context)?.settings.arguments as ContentsModel?),
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
