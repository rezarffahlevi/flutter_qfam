import 'package:bloc/bloc.dart';
import 'package:flutter_qfam/src/features/forum/ui/forum_screen.dart';
import 'package:flutter_qfam/src/features/home/ui/home_screen.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_qfam/src/features/profile/ui/profile_screen.dart';
import 'package:flutter_qfam/src/features/search/ui/search_screen.dart';
import 'package:flutter_qfam/src/models/profile/user_model.dart';
import 'package:flutter_qfam/src/services/profile/forum_service.dart';
import 'package:flutter_qfam/src/widgets/widgets.dart';

part 'home_root_event.dart';
part 'home_root_state.dart';

class HomeRootBloc extends Bloc<HomeRootEvent, HomeRootState> {
  HomeRootBloc() : super(const HomeRootState()) {
    on<HomeRootEventSelectedIndex>(_setIndex);
    on<HomeRootEventGetCurrentUser>(_currentUser);
  }
  ProfileService apiService = ProfileService();

  _currentUser(
      HomeRootEventGetCurrentUser event, Emitter<HomeRootState> emit) async {
    try {
      emit(state.copyWith(state: NetworkStates.onLoading));
      var response = await apiService.getCurrentUser();
      emit(state.copyWith(
          currentUser: response?.data, state: NetworkStates.onLoaded));
      // return response!.data;
    } catch (e) {
      emit(state.copyWith(state: NetworkStates.onError, message: '${e}'));
      return null;
    }
  }

  _setIndex(
      HomeRootEventSelectedIndex event, Emitter<HomeRootState> emit) async {
    emit(state.copyWith(index: event.index));
  }

  final List<Widget> children = [
    HomeScreen(),
    SearchScreen(),
    ForumScreen(),
    ProfileScreen(),
  ];
}
