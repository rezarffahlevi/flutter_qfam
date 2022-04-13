import 'package:bloc/bloc.dart';
import 'package:flutter_siap_nikah/src/models/default_response_model.dart';
import 'package:flutter_siap_nikah/src/models/home/category_model.dart';
import 'package:flutter_siap_nikah/src/models/home/home_model.dart';
import 'package:flutter_siap_nikah/src/models/home/product_model.dart';
import 'package:flutter_siap_nikah/src/services/home/home_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_siap_nikah/src/widgets/general.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(const SearchState()) {
    on<SearchEventGetData>(_getData);
    on<SearchEventRefresh>(_onRefresh);
  }
  HomeService homeService = HomeService();

  _onRefresh(SearchEventRefresh event, Emitter<SearchState> emit) async {
    add(SearchEventGetData());
  }

  _getData(SearchEventGetData event, Emitter<SearchState> emit) async {
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
