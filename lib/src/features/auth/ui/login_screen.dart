import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_qfam/src/commons/spaces.dart';
import 'package:flutter_qfam/src/features/auth/bloc/auth_bloc.dart';
import 'package:flutter_qfam/src/features/auth/ui/register_screen.dart';
import 'package:flutter_qfam/src/helpers/helpers.dart';
import 'package:flutter_qfam/src/styles/my_colors.dart';
import 'package:flutter_qfam/src/styles/my_font_weight.dart';
import 'package:flutter_qfam/src/widgets/custom_loader.dart';
import 'package:flutter_qfam/src/widgets/widgets.dart';
import 'package:getwidget/getwidget.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = '/login';
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late AuthBloc bloc;
  CustomLoader loader = CustomLoader();

  @override
  void initState() {
    super.initState();
    bloc = context.read<AuthBloc>();
    bloc.add(AuthEventInitLogin(context: context));
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dimension = MediaQuery.of(context).size;

    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
          bloc: bloc,
          listener: (context, state) {
            bloc.refreshController.refreshCompleted();
            bloc.refreshController.loadComplete();
            if (state.state == NetworkStates.onLoading) {
              loader.showLoader(context);
            } else {
              loader.hideLoader();
            }
          },
          builder: (context, state) {
            return GestureDetector(
              onTap: () {
                Helpers.dismissKeyboard(context);
              },
              child: Wrapper(
                state: NetworkStates.onLoaded,
                isGlobalLoading: true,
                onLoading: GFShimmer(
                  child: Column(
                    children: [
                      Spaces.normalVertical(),
                      Column(
                        children: [
                          loadingBlock(dimension),
                          Spaces.normalVertical()
                        ],
                      ),
                    ],
                  ),
                ),
                onLoaded: Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                    colors: [
                      Color(0xfffbfbfb),
                      Color(0xfff7f7f7),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  )),
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        top: 30,
                        left: 0,
                        right: 0,
                        child: Image.asset(
                          'assets/images/login.png',
                          fit: BoxFit.fill,
                        ),
                      ),
                      Positioned(
                        top: dimension.height / 8,
                        left: dimension.width / 10,
                        child: Text(
                          'Menuju\nRumah Tangga\nBahagia',
                          maxLines: 3,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontFamily: 'arial',
                              fontWeight: MyFontWeight.bold,
                              fontStyle: FontStyle.italic),
                        ),
                      ),
                      DraggableScrollableSheet(
                          maxChildSize: .8,
                          initialChildSize: .5,
                          minChildSize: .5,
                          builder: (context, scrollController) {
                            return Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(40),
                                  topRight: Radius.circular(40),
                                ),
                                color: MyColors.primary.withOpacity(0.84),
                              ),
                              child: SingleChildScrollView(
                                controller: scrollController,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    _entryField('Email Anda',
                                        controller: bloc.txtEmail),
                                    _entryField('Password Anda',
                                        controller: bloc.txtPassword,
                                        isPassword: true),
                                    Spaces.smallVertical(),
                                    _labelButton(
                                        'Belum punya akun? Daftar di sini',
                                        onPressed: () {
                                      Navigator.of(context)
                                          .pushNamed(RegisterScreen.routeName);
                                    }),
                                    Spaces.normalVertical(),
                                    GFButton(
                                      onPressed: () {
                                        bloc.add(AuthEventOnLogin());
                                      },
                                      text: "Masuk",
                                      shape: GFButtonShape.pills,
                                      blockButton: true,
                                    ),
                                    Spaces.normalVertical(),
                                    Divider(),
                                    SizedBox(height: 100),
                                  ],
                                ),
                              ),
                            );
                          })
                    ],
                  ),
                ),
                onError: Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Text(state.message ?? 'Unknown Error'),
                  ),
                ),
              ),
            );
          }),
      floatingActionButton: Container(
        margin: EdgeInsets.only(top: 16),
        child: FloatingActionButton(
          onPressed: (() {}),
          child: IconButton(
            icon: Icon(Icons.chevron_left),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          heroTag: null,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
    );
  }

  Widget _entryField(String hint,
      {TextEditingController? controller, bool isPassword = false}) {
    return Center(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(30),
        ),
        child: TextField(
          controller: controller,
          keyboardType: TextInputType.emailAddress,
          style: TextStyle(
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.normal,
          ),
          obscureText: isPassword,
          decoration: InputDecoration(
            hintText: hint,
            border: InputBorder.none,
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(30.0)),
                borderSide: BorderSide(color: Colors.blue)),
            contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          ),
        ),
      ),
    );
  }

  Widget _labelButton(String title, {Function? onPressed}) {
    return Container(
        alignment: Alignment.bottomRight,
        margin: EdgeInsets.only(right: 10),
        child: new RichText(
          text: new TextSpan(
            children: [
              new TextSpan(
                text: 'Belum punya akun? ',
                style: new TextStyle(color: Colors.black),
              ),
              new TextSpan(
                text: 'Klik disini',
                style: new TextStyle(color: MyColors.link),
                recognizer: new TapGestureRecognizer()
                  ..onTap = () {
                    onPressed!();
                  },
              ),
            ],
          ),
        ));
  }
}
