import 'package:bloc/bloc.dart';
import 'package:flutter_qfam/src/features/home/bloc/home_root/home_root_bloc.dart';
import 'package:flutter_qfam/src/models/contents/category_model.dart';
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
    on<SearchEventGetCategory>(_getCategory);
    on<SearchEventSetSelectedCategory>(_setSelectedCategory);
    on<SearchEventRefresh>(_onRefresh);

    add(SearchEventRefresh());
  }
  ContentService apiService = ContentService();

  _onRefresh(SearchEventRefresh event, Emitter<SearchState> emit) async {
    add(SearchEventGetData());
    add(SearchEventGetCategory());
  }

  _getData(SearchEventGetData event, Emitter<SearchState> emit) async {
    try {
      emit(state.copyWith(state: NetworkStates.onLoading));
      var response = await apiService.getList();
      emit(state.copyWith(
          state: NetworkStates.onLoaded, contentsList: response?.data));
    } catch (e) {
      emit(state.copyWith(state: NetworkStates.onError));
    }
  }

  _getCategory(SearchEventGetCategory event, Emitter<SearchState> emit) async {
    try {
      emit(state.copyWith(state: NetworkStates.onLoading));
      var response = await apiService.getCategoryList();
      emit(state.copyWith(
          state: NetworkStates.onLoaded, categoryList: response?.data));
    } catch (e) {
      emit(state.copyWith(state: NetworkStates.onError));
    }
  }

  _setSelectedCategory(
      SearchEventSetSelectedCategory event, Emitter<SearchState> emit) async {
    emit(state.copyWith(selectedCategory: event.selectedCategory));
  }
}
