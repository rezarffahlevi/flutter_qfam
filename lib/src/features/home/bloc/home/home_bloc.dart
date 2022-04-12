import 'package:bloc/bloc.dart';
import 'package:flutter_siap_nikah/src/models/default_response_model.dart';
import 'package:flutter_siap_nikah/src/models/home/category_model.dart';
import 'package:flutter_siap_nikah/src/models/home/home_model.dart';
import 'package:flutter_siap_nikah/src/models/home/product_model.dart';
import 'package:flutter_siap_nikah/src/services/home/home_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(const HomeState()) {
    // on<HomeEvent>((event, emit) {});
    on<HomeEventGetHomeData>(_getHomeData);
    on<HomeEventSetPhoto>(_setPhoto);
    on<HomeEventRefresh>(_onRefresh);

    add(HomeEventRefresh());
  }
  HomeService homeService = HomeService();

  _onRefresh(HomeEventRefresh event, Emitter<HomeState> emit) async {
    add(HomeEventGetHomeData());
  }

  _getHomeData(HomeEventGetHomeData event, Emitter<HomeState> emit) async {
    emit(state.copyWith(state: HomeStates.onLoading));
    var response = await homeService.getHomeData();
    emit(state.copyWith(
        listCategory: response?.data?.category,
        listHome: response?.data?.home,
        state: HomeStates.onLoaded));
  }

  _setPhoto(HomeEventSetPhoto event, Emitter<HomeState> emit) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('photo', event.photo ?? '');
    emit(state.copyWith(state: HomeStates.onLoading));
    await Future.delayed(const Duration(seconds: 1));
    emit(state.copyWith(photo: event.photo, state: HomeStates.onLoaded));
  }
}
