import 'package:bloc/bloc.dart';
import 'package:flutter_siap_nikah/src/models/default_response_model.dart';
import 'package:flutter_siap_nikah/src/models/home/category_model.dart';
import 'package:flutter_siap_nikah/src/models/home/home_model.dart';
import 'package:flutter_siap_nikah/src/models/home/product_model.dart';
import 'package:flutter_siap_nikah/src/services/home/home_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_siap_nikah/src/widgets/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(const ProfileState()) {
    on<ProfileEventGetData>(_getData);
    on<ProfileEventRefresh>(_onRefresh);
  }
  HomeService homeService = HomeService();

  _onRefresh(ProfileEventRefresh event, Emitter<ProfileState> emit) async {
    add(ProfileEventGetData());
  }

  _getData(ProfileEventGetData event, Emitter<ProfileState> emit) async {
    try {
      emit(state.copyWith(state: NetworkStates.onLoading));
      emit(state.copyWith(
          state: NetworkStates.onLoaded));
    } catch (e) {
      debugPrint(e.toString());
      emit(state.copyWith(state: NetworkStates.onError));
    }
  }
}
