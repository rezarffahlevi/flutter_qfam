import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_qfam/src/features/forum/ui/forum_screen.dart';
import 'package:flutter_qfam/src/features/home/ui/home_screen.dart';
import 'package:flutter_qfam/src/features/profile/ui/profile_screen.dart';
import 'package:flutter_qfam/src/features/search/ui/search_screen.dart';
import 'package:flutter_qfam/src/helpers/notification_helper.dart';
import 'package:flutter_qfam/src/models/profile/user_model.dart';
import 'package:flutter_qfam/src/widgets/widgets.dart';
import 'package:uni_links/uni_links.dart';

part 'home_root_event.dart';
part 'home_root_state.dart';

class HomeRootBloc extends Bloc<HomeRootEvent, HomeRootState> {
  HomeRootBloc() : super(const HomeRootState()) {
    on<HomeRootEventSelectedIndex>(_setIndex);
    initUniLinks();
  }
  late StreamSubscription _sub;

  Future<void> initUniLinks() async {
    // Attach a listener to the stream
    _sub = uriLinkStream.listen((Uri? uri) {
      // Use the uri and warn the user, if it is not correct
      debugPrint('uri ${uri} ${uri?.queryParameters}');
      var params = uri?.queryParameters;
      NotificationHelper.onSelectNotification(params?['id']);
    }, onError: (err) {
      // Handle exception by warning the user their action did not succeed
      debugPrint('uri error ${err}');
    });

    // NOTE: Don't forget to call _sub.cancel() in dispose()
  }

  _setIndex(
      HomeRootEventSelectedIndex event, Emitter<HomeRootState> emit) async {
    emit(state.copyWith(index: event.index));
  }

  List<Widget> children = [
    HomeScreen(),
    SearchScreen(),
    ForumScreen(),
    ProfileScreen(),
  ];
}
