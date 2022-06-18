import 'package:bloc/bloc.dart';
import 'package:flutter_qfam/src/models/contents/contents_model.dart';
import 'package:flutter_qfam/src/services/contents/content_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_qfam/src/widgets/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(const SearchState()) {
    on<SearchEventGetData>(_getData);
    on<SearchEventRefresh>(_onRefresh);

    add(SearchEventRefresh());
  }

  ContentService apiService = ContentService();

  _onRefresh(SearchEventRefresh event, Emitter<SearchState> emit) async {
    add(SearchEventGetData());
  }

  _getData(SearchEventGetData event, Emitter<SearchState> emit) async {
    try {
      emit(state.copyWith(state: NetworkStates.onLoading));
      var response = await apiService.getList();
      emit(state.copyWith(
          state: NetworkStates.onLoaded, contentsList: response?.data));
    } catch (e) {
      debugPrint(e.toString());
      emit(state.copyWith(state: NetworkStates.onError));
    }
  }
}
