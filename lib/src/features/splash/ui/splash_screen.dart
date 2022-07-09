import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_qfam/src/commons/app_settings.dart';
import 'package:flutter_qfam/src/commons/assets.dart';
import 'package:flutter_qfam/src/commons/spaces.dart';
import 'package:flutter_qfam/src/features/home/ui/home_root_screen.dart';
import 'package:flutter_qfam/src/features/splash/bloc/splash_bloc.dart';
import 'package:flutter_qfam/src/helpers/helpers.dart';
import 'package:flutter_qfam/src/styles/my_colors.dart';
import 'package:flutter_qfam/src/styles/my_font_weight.dart';
import 'package:flutter_qfam/src/styles/my_text_style.dart';

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
    bloc.add(SplashEventInit(context: context));
  }

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => bloc,
      child: BlocConsumer<SplashBloc, SplashState>(
          bloc: bloc,
          listener: (context, state) {
            if (state.version?.needUpdate == true) {
              showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return WillPopScope(
                      onWillPop: () async => false,
                      child: AlertDialog(
                        title: Text(
                            'Versi Terbaru Quality Family Sudah Tersedia.'),
                        content: Text(state.version?.message ??
                            'Yuk, perbaharui sekarang agar  bisa menggunakan semua fitur Quality Family.'),
                        actions: <Widget>[
                          state.version?.forceUpdate == true
                              ? Container()
                              : FlatButton(
                                  onPressed: () async {
                                    Navigator.of(context).pop();
                                    Navigator.pushReplacementNamed(
                                        context, HomeRootScreen.routeName);
                                  },
                                  child: Text('Update Nanti'),
                                ),
                          FlatButton(
                            onPressed: () {
                              Helpers.launchURL(url: state.version?.link ?? '');
                            },
                            child: Text('Update Sekarang'),
                          ),
                        ],
                      ),
                    );
                  });
            }
          },
          builder: (context, state) {
            return Scaffold(
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
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      height: 100,
                      width: 100,
                      // child: SvgPicture.asset(Assets.logo),
                      child: Image.asset(Assets.logo),
                    ),
                    // Spaces.normalVertical(),
                    // GFLoader(type: GFLoaderType.circle),
                    Spaces.normalVertical(),
                    Text(
                      AppSettings.name,
                      textAlign: TextAlign.center,
                      style: MyTextStyle.appBarTitle.copyWith(
                          fontWeight: MyFontWeight.bold,
                          fontFamily: 'GreatVibes',
                          color: MyColors.white),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
