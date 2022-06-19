import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_qfam/src/models/contents/banner_model.dart';
import 'package:flutter_qfam/src/models/contents/sections_model.dart';
import 'package:flutter_qfam/src/services/contents/content_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_qfam/src/widgets/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(const HomeState()) {
    // on<HomeEvent>((event, emit) {});
    on<HomeEventGetData>(_getHomeData);
    on<HomeEventGetBanner>(_getBanner);
    on<HomeEventRefresh>(_onRefresh);
    on<HomeEventSetActiveBanner>(_setActiveBanner);
    on<HomeEventSelectedCategory>(_selectedCategory);

    add(HomeEventRefresh());
  }
  ContentService apiService = ContentService();

  _onRefresh(HomeEventRefresh event, Emitter<HomeState> emit) async {
    add(HomeEventGetBanner());
    add(HomeEventGetData());
  }

  _getHomeData(HomeEventGetData event, Emitter<HomeState> emit) async {
    try {
      emit(state.copyWith(state: NetworkStates.onLoading));
      var response = await apiService.getHomeList();
      emit(state.copyWith(
          sections: response?.data,
          state: NetworkStates.onLoaded));
    } catch (e) {
      emit(state.copyWith(state: NetworkStates.onError, message: '${e}'));
    }
  }

  _getBanner(HomeEventGetBanner event, Emitter<HomeState> emit) async {
    try {
      emit(state.copyWith(state: NetworkStates.onLoading));
      var response = await apiService.getBannerList();
      emit(state.copyWith(
          bannerList: response?.data,
          state: NetworkStates.onLoaded));
    } catch (e) {
      emit(state.copyWith(state: NetworkStates.onError, message: '${e}'));
    }
  }

  _setActiveBanner(HomeEventSetActiveBanner event, Emitter<HomeState> emit) async {
    // final prefs = await SharedPreferences.getInstance();
    // await prefs.setString('photo', event.photo ?? '');
    emit(state.copyWith(activeBanner: event.activeBanner));
  }

  _selectedCategory(
      HomeEventSelectedCategory event, Emitter<HomeState> emit) async {
    emit(state.copyWith(selectedCategory: event.selectedCategory));
  }
}
