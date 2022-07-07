import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_qfam/src/commons/spaces.dart';
import 'package:flutter_qfam/src/features/auth/bloc/auth_bloc.dart';
import 'package:flutter_qfam/src/helpers/helpers.dart';
import 'package:flutter_qfam/src/styles/my_text_style.dart';
import 'package:flutter_qfam/src/widgets/card/textfield.dart';
import 'package:flutter_qfam/src/widgets/custom_loader.dart';
import 'package:flutter_qfam/src/widgets/widgets.dart';
import 'package:getwidget/getwidget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = '/register';
  final int? argument;
  const RegisterScreen({Key? key, this.argument}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  late AuthBloc bloc;
  CustomLoader loader = CustomLoader();

  @override
  void initState() {
    super.initState();
    bloc = context.read<AuthBloc>();
    bloc.add(AuthEventInitRegister(context: context));
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dimension = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        Helpers.dismissKeyboard(context);
      },
      child: Scaffold(
        appBar: appBar(
          onTapBack: () {
            Navigator.pop(context);
          },
          child: 'Daftar',
        ),
        body: SmartRefresher(
          enablePullDown: true,
          enablePullUp: false,
          controller: _refreshController,
          onRefresh: () => bloc.add(AuthEventGetCurrentUser()),
          child: SingleChildScrollView(
            child: Column(
              children: [
                BlocConsumer<AuthBloc, AuthState>(
                    bloc: bloc,
                    listener: (context, state) {
                      _refreshController.refreshCompleted();
                      _refreshController.loadComplete();
                      if (state.state == NetworkStates.onLoading) {
                        loader.showLoader(context);
                      } else {
                        loader.hideLoader();
                      }
                    },
                    builder: (context, state) {
                      return Wrapper(
                        state: NetworkStates.onLoaded,
                        isGlobalLoading: true,
                        onLoaded: Container(
                          // height: dimension.height - 88,

                          padding: EdgeInsets.only(
                              left: 20, right: 20, top: 30, bottom: 30),
                          child: Form(
                            // key: bloc.formKey,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                _entryField('Nama',
                                    controller: bloc.txtName,
                                    keyboardType: TextInputType.name),
                                Spaces.normalVertical(),
                                _entryField('No Telp',
                                    controller: bloc.txtTelp,
                                    keyboardType: TextInputType.phone),
                                Spaces.normalVertical(),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Jenis Kelamin',
                                    style: MyTextStyle.h5.bold,
                                  ),
                                ),
                                Spaces.smallVertical(),
                                Row(
                                  children: [
                                    Row(
                                      children: [
                                        GFRadio(
                                          size: 20,
                                          value: 1,
                                          groupValue:
                                              state.formdataUser?.gender ==
                                                      'Laki-Laki'
                                                  ? 1
                                                  : 0,
                                          onChanged: (value) {
                                            bloc.add(AuthEventSetFormdataUser(
                                                gender: 'Laki-Laki'));
                                          },
                                          inactiveIcon: null,
                                          activeBorderColor: GFColors.SUCCESS,
                                          radioColor: GFColors.SUCCESS,
                                        ),
                                        Spaces.smallHorizontal(),
                                        GestureDetector(
                                            onTap: () {
                                              bloc.add(AuthEventSetFormdataUser(
                                                  gender: 'Laki-Laki'));
                                            },
                                            child: Text('Laki-Laki'))
                                      ],
                                    ),
                                    Spaces.largeHorizontal(),
                                    Row(
                                      children: [
                                        GFRadio(
                                          size: 20,
                                          value: 2,
                                          groupValue:
                                              state.formdataUser?.gender ==
                                                      'Perempuan'
                                                  ? 2
                                                  : 0,
                                          onChanged: (value) {
                                            bloc.add(AuthEventSetFormdataUser(
                                                gender: 'Perempuan'));
                                          },
                                          inactiveIcon: null,
                                          activeBorderColor: GFColors.SUCCESS,
                                          radioColor: GFColors.SUCCESS,
                                        ),
                                        Spaces.smallHorizontal(),
                                        GestureDetector(
                                            onTap: () {
                                              bloc.add(AuthEventSetFormdataUser(
                                                  gender: 'Perempuan'));
                                            },
                                            child: Text('Perempuan'))
                                      ],
                                    ),
                                  ],
                                ),
                                Spaces.normalVertical(),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Agama',
                                    style: MyTextStyle.h5.bold,
                                  ),
                                ),
                                Spaces.smallVertical(),
                                Container(
                                  height: 50,
                                  width: MediaQuery.of(context).size.width,
                                  child: DropdownButtonHideUnderline(
                                    child: GFDropdown(
                                      padding: const EdgeInsets.all(15),
                                      borderRadius: BorderRadius.circular(5),
                                      border: const BorderSide(
                                          color: Colors.black12, width: 1),
                                      dropdownButtonColor: Colors.white,
                                      value: state.formdataUser?.religion,
                                      onChanged: (newValue) {
                                        bloc.add(AuthEventSetFormdataUser(
                                            religion: newValue?.toString()));
                                      },
                                      items:
                                          ['Islam', 'Kristen', 'Hindu', 'Budha']
                                              .map((value) => DropdownMenuItem(
                                                    value: value,
                                                    child: Text(value),
                                                  ))
                                              .toList(),
                                    ),
                                  ),
                                ),
                                Spaces.normalVertical(),
                                _entryField(
                                  'Email',
                                  controller: bloc.txtEmail,
                                ),
                                Spaces.normalVertical(),
                                _entryField('Password',
                                    controller: bloc.txtPassword,
                                    obscureText: true,
                                    keyboardType:
                                        TextInputType.visiblePassword),
                                // Spaces.normalVertical(),
                                // _entryField(
                                //   'Ulangi Password',
                                // ),

                                Spaces.normalVertical(),
                                InkWell(
                                  onTap: () {},
                                  child: Container(
                                    margin: EdgeInsets.all(10),
                                    child: Row(
                                      children: [
                                        Icon(Icons.add_photo_alternate),
                                        Text('Upload gambar')
                                      ],
                                    ),
                                  ),
                                ),
                                Spaces.normalVertical(),
                                GFButton(
                                  onPressed: () {
                                    bloc.add(AuthEventOnRegister());
                                  },
                                  text: "Daftar",
                                  shape: GFButtonShape.pills,
                                  blockButton: true,
                                ),
                              ],
                            ),
                          ),
                        ),
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
                        onError: Align(
                          alignment: Alignment.center,
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 15.0),
                            child: Text(state.message ?? 'Unknown Error'),
                          ),
                        ),
                      );
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _entryField(
    String labelText, {
    TextEditingController? controller,
    String? errorText,
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.emailAddress,
  }) {
    return MyTextField(
      labelText: labelText,
      hintText: labelText,
      controller: controller,
      obscureText: obscureText,
      errorText: errorText,
      keyboardType: keyboardType,
    );
  }
}
