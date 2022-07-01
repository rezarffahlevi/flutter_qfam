import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_qfam/src/commons/preferences_base.dart';
import 'package:flutter_qfam/src/features/auth/arguments/auth_argument.dart';
import 'package:flutter_qfam/src/features/auth/ui/login_screen.dart';
import 'package:flutter_qfam/src/features/home/bloc/home_root/home_root_bloc.dart';
import 'package:flutter_qfam/src/features/home/ui/home_root_screen.dart';
import 'package:flutter_qfam/src/helpers/helpers.dart';
import 'package:flutter_qfam/src/helpers/notification_helper.dart';
import 'package:flutter_qfam/src/models/profile/user_model.dart';
import 'package:flutter_qfam/src/services/auth/auth_service.dart';
import 'package:flutter_qfam/src/widgets/widgets.dart';
import 'package:getwidget/getwidget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthState()) {
    on<AuthEventRefresh>(_onRefresh);
    on<AuthEventGetCurrentUser>(_getCurrentUser);
    on<AuthEventSetFormdataUser>(_onChangeFormdata);
    on<AuthEventInitLogin>(_initLogin);
    on<AuthEventInitRegister>(_initRegister);
    on<AuthEventOnLogin>(_onLogin);
    on<AuthEventOnLogout>(_onLogout);
    on<AuthEventOnRegister>(_onRegister);
  }

  RefreshController refreshController =
      RefreshController(initialRefresh: false);
  AuthService apiService = AuthService();

  // late HomeRootBloc homeRootBloc;

  final txtEmail = TextEditingController();
  final txtPassword = TextEditingController();
  final txtName = TextEditingController();
  final txtTelp = TextEditingController();

  _initLogin(AuthEventInitLogin event, Emitter<AuthState> emit) {
    txtEmail.addListener(() {
      add(AuthEventSetFormdataUser(email: txtEmail.text));
    });
    txtPassword.addListener(() {
      add(AuthEventSetFormdataUser(password: txtPassword.text));
    });
    emit(state.copyWith(context: event.context));
  }

  _initRegister(AuthEventInitRegister event, Emitter<AuthState> emit) {
    txtEmail.addListener(() {
      add(AuthEventSetFormdataUser(email: txtEmail.text));
    });
    txtPassword.addListener(() {
      add(AuthEventSetFormdataUser(password: txtPassword.text));
    });
    txtName.addListener(() {
      add(AuthEventSetFormdataUser(name: txtName.text));
    });
    txtTelp.addListener(() {
      add(AuthEventSetFormdataUser(telp: txtTelp.text));
    });
    emit(state.copyWith(context: event.context));
  }

  _getCurrentUser(
      AuthEventGetCurrentUser event, Emitter<AuthState> emit) async {
    try {
      emit(state.copyWith(state: NetworkStates.onLoading));
      var fcmToken = await NotificationHelper.getFcmToken();
      var response =
          await apiService.getCurrentUser(params: {'fcm': fcmToken});
      emit(state.copyWith(
          currentUser: response?.data, state: NetworkStates.onLoaded));
    } catch (e) {
      emit(state.copyWith(
          state: NetworkStates.onError,
          currentUser: UserModel(),
          message: '${e}'));
    }
  }

  _onRefresh(AuthEventRefresh event, Emitter<AuthState> emit) async {
    add(AuthEventGetCurrentUser());
  }

  _onChangeFormdata(
      AuthEventSetFormdataUser event, Emitter<AuthState> emit) async {
    emit(state.copyWith(state: NetworkStates.onLoading));
    UserModel? formdataUser = UserModel(
      email: state.formdataUser?.email,
      password: state.formdataUser?.password,
      name: state.formdataUser?.name,
      telp: state.formdataUser?.telp,
      gender: state.formdataUser?.gender,
      religion: state.formdataUser?.religion,
      photo: state.formdataUser?.photo,
    );
    if (event.email != null) formdataUser.email = event.email;
    if (event.password != null) formdataUser.password = event.password;
    if (event.name != null) formdataUser.name = event.name;
    if (event.telp != null) formdataUser.telp = event.telp;
    if (event.gender != null) formdataUser.gender = event.gender;
    if (event.religion != null) formdataUser.religion = event.religion;
    if (event.photo != null) formdataUser.photo = event.photo;

    emit(state.copyWith(
        formdataUser: formdataUser, state: NetworkStates.onLoaded));
  }

  _onLogin(AuthEventOnLogin event, Emitter<AuthState> emit) async {
    try {
      Helpers.dismissKeyboard(state.context as BuildContext);
      emit(state.copyWith(state: NetworkStates.onLoading));
      var fcmToken = await NotificationHelper.getFcmToken();
      var params = {
        "email": state.formdataUser?.email,
        "password": state.formdataUser?.password,
        "fcm": fcmToken,
      };
      var response = await apiService.onLogin(params: params);
      ResponseLoginModel? data = response?.data;
      if (response?.code == '00') {
        AuthArgument? formdataUser = AuthArgument(
            email: state.formdataUser?.email,
            password: state.formdataUser?.password);
        await Prefs.setAuth(formdataUser);
        await Prefs.setToken('${data?.tokenType} ${data?.token}');
        Navigator.pop(state.context as BuildContext);
      }
      GFToast.showToast('${response?.message}', state.context as BuildContext,
          toastPosition: GFToastPosition.BOTTOM);
      emit(state.copyWith(
          currentUser: data?.user, state: NetworkStates.onLoaded));
    } catch (e) {
      GFToast.showToast('$e', state.context as BuildContext,
          toastPosition: GFToastPosition.BOTTOM);
      emit(state.copyWith(state: NetworkStates.onError, message: '${e}'));
    }
  }

  _onRegister(AuthEventOnRegister event, Emitter<AuthState> emit) async {
    try {
      Helpers.dismissKeyboard(state.context as BuildContext);
      emit(state.copyWith(state: NetworkStates.onLoading));
      var params = {
        "email": state.formdataUser?.email,
        "password": state.formdataUser?.password,
        "name": state.formdataUser?.name,
        "telp": state.formdataUser?.telp,
        "gender": state.formdataUser?.gender,
        "religion": state.formdataUser?.religion,
        "role": state.formdataUser?.role,
        "photo": state.formdataUser?.photo,
      };
      var response = await apiService.onRegister(params: params);
      ResponseLoginModel? data = response?.data;
      if (response?.code == '00') {
        AuthArgument? formdataUser = AuthArgument(
            email: state.formdataUser?.email,
            password: state.formdataUser?.password);
        await Prefs.setAuth(formdataUser);
        await Prefs.setToken('${data?.tokenType} ${data?.token}');
        Navigator.popUntil(state.context as BuildContext,
            (Route<dynamic> route) => route.isFirst);
      }
      GFToast.showToast('${response?.message}', state.context as BuildContext,
          toastPosition: GFToastPosition.BOTTOM);
      emit(state.copyWith(
          currentUser: data?.user, state: NetworkStates.onLoaded));
    } catch (e) {
      GFToast.showToast('$e', state.context as BuildContext,
          toastPosition: GFToastPosition.BOTTOM);
      emit(state.copyWith(state: NetworkStates.onError, message: '${e}'));
    }
  }

  _onLogout(AuthEventOnLogout event, Emitter<AuthState> emit) async {
    try {
      emit(state.copyWith(state: NetworkStates.onLoading));
      var response = await apiService.onLogout();
      await Prefs.setAuth(null);
      await Prefs.setToken(null);
      emit(state.copyWith(
          currentUser: UserModel(), state: NetworkStates.onLoaded));
      add(AuthEventGetCurrentUser());
      Navigator.of(state.context as BuildContext)
          .pushNamed(LoginScreen.routeName);
      GFToast.showToast(
          'Anda harus login terlebih dahulu.', state.context as BuildContext,
          toastPosition: GFToastPosition.BOTTOM);
    } catch (e) {
      debugPrint('catch _onLogout ${e}');
      emit(state.copyWith(state: NetworkStates.onError, message: '${e}'));
    }
  }
}
