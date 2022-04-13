import 'package:bloc/bloc.dart';
import 'package:flutter_siap_nikah/src/features/forum/ui/forum_screen.dart';
import 'package:flutter_siap_nikah/src/features/home/ui/home_screen.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_siap_nikah/src/features/profile/ui/profile_screen.dart';
import 'package:flutter_siap_nikah/src/features/search/ui/search_screen.dart';

part 'home_root_event.dart';
part 'home_root_state.dart';

class HomeRootBloc extends Bloc<HomeRootEvent, HomeRootState> {
  HomeRootBloc() : super(const HomeRootState()) {
    on<HomeRootEventSelectedIndex>(_setIndex);
  }

  _setIndex(HomeRootEventSelectedIndex event, Emitter<HomeRootState> emit) async {
    emit(state.copyWith(index: event.index));
  }

  final List<Widget> children = [
    HomeScreen(),
    SearchScreen(),
    ForumScreen(),
    ProfileScreen(),
  ];
}