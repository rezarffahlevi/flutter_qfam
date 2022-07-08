import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_qfam/src/features/home/ui/home_root_screen.dart';
import 'package:flutter_qfam/src/helpers/notification_helper.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(const SplashState()) {
    on<SplashEventInit>(_init);
  }

  _init(SplashEventInit event, Emitter<SplashState> emit) async {
    await Future.delayed(const Duration(seconds: 2));
    var message = await FirebaseMessaging.instance.getInitialMessage();
    Navigator.pushReplacementNamed(event.context, HomeRootScreen.routeName);
    if (message != null) {
      debugPrint('getInitialMessage: ${message.notification?.title}');
      NotificationHelper.onSelectNotification(message.data['uuid']);
    }
    emit(state.copyWith(isLoading: false));
  }
}
