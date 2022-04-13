import 'package:flutter_siap_nikah/src/commons/app_settings.dart';
import 'package:flutter_siap_nikah/src/features/home/ui/home_screen.dart';
import 'package:flutter_siap_nikah/src/features/movie/ui/movie_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_siap_nikah/src/features/splash/bloc/splash_bloc.dart';
import 'package:flutter_siap_nikah/src/styles/my_colors.dart';
import 'package:flutter_siap_nikah/src/styles/my_font_weight.dart';
import 'package:flutter_siap_nikah/src/styles/my_text_style.dart';

class SplashScreen extends StatefulWidget {
  static const String routeName = '/';

  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final SplashBloc bloc = SplashBloc();
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
    bloc.add(SplashEventInit(isLoading: true, context: context));
    return BlocProvider(
      create: (BuildContext context) => SplashBloc(),
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            color: Colors.green,
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  MyColors.primary.withOpacity(0.3),
                  MyColors.background
                ]),
//              colors: [Color(0xFF307ADB).withOpacity(0.3), Color(0xFF8F79D4)]),
          ),
          child: Center(
            child: Text(
              AppSettings.name,
              textAlign: TextAlign.center,
              style: MyTextStyle.appBarTitle.copyWith(fontWeight: MyFontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
