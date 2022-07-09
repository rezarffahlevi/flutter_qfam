import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_qfam/src/features/home/ui/home_root_screen.dart';
import 'package:flutter_qfam/src/helpers/notification_helper.dart';
import 'package:flutter_qfam/src/models/version_model.dart';
import 'package:flutter_qfam/src/services/auth/auth_service.dart';
import 'package:package_info_plus/package_info_plus.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(const SplashState()) {
    on<SplashEventInit>(_init);
  }
  AuthService apiService = AuthService();

  _init(SplashEventInit event, Emitter<SplashState> emit) async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    String appName = packageInfo.appName;
    String packageName = packageInfo.packageName;
    String version = packageInfo.version;
    String buildNumber = packageInfo.buildNumber;

    var response = await apiService.checkVersion(params: {
      'platform': Platform.operatingSystem,
      'appName': appName,
      'packageName': packageName,
      'version': version,
      'buildNumber': buildNumber,
    });
    // await Future.delayed(const Duration(seconds: 2));
    var message = await FirebaseMessaging.instance.getInitialMessage();
    if (response?.data?.needUpdate) {
      emit(state.copyWith(version: response?.data));
    } else {
      Navigator.pushReplacementNamed(event.context, HomeRootScreen.routeName);
      if (message != null) {
        debugPrint('getInitialMessage: ${message.notification?.title}');
        NotificationHelper.onSelectNotification(message.data['uuid']);
      }
    }
  }
}
