import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_qfam/src/features/home/bloc/home_root/home_root_bloc.dart';
import 'package:flutter_qfam/src/models/contents/category_model.dart';
import 'package:flutter_qfam/src/models/contents/contents_model.dart';
import 'package:flutter_qfam/src/models/default_response_model.dart';
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
    _initSearch();
  }
  ContentService apiService = ContentService();
  final txtSearch = TextEditingController();

  _initSearch() {
    Timer? timer;
    txtSearch.addListener(() {
      if (timer == null) {
        timer = Timer(Duration(seconds: 1), () {
          add(SearchEventGetData(page: 1, search: txtSearch.text, categoryId: state.selectedCategory));
        timer = null;
        });
      }
    });
  }

  _onRefresh(SearchEventRefresh event, Emitter<SearchState> emit) async {
    add(SearchEventGetData(search: state.search, categoryId: state.selectedCategory, page: 1));
    add(SearchEventGetCategory());
  }

  _getData(SearchEventGetData event, Emitter<SearchState> emit) async {
    try {
      emit(state.copyWith(state: NetworkStates.onLoading));
      var response = await apiService.getList(params: {
        'page': event.page,
        'category_id': event.categoryId,
        'search': event.search,
      });

      List<ContentsModel>? contentsList = [];
      if (event.page > 1) {
        contentsList = state.contentsList;
        contentsList?.addAll(response?.data);
      } else {
        contentsList = response?.data;
      }
      emit(state.copyWith(
          page: event.page,
          selectedCategory: event.categoryId,
          search: event.search,
          state: NetworkStates.onLoaded,
          contentsList: contentsList,
          response: response));
    } catch (e) {
      emit(state.copyWith(state: NetworkStates.onError, message: e.toString()));
    }
  }

  _getCategory(SearchEventGetCategory event, Emitter<SearchState> emit) async {
    try {
      emit(state.copyWith(state: NetworkStates.onLoading));
      var response = await apiService.getCategoryList();
      emit(state.copyWith(
          state: NetworkStates.onLoaded, categoryList: response?.data));
    } catch (e) {
      emit(state.copyWith(state: NetworkStates.onError, message: e.toString()));
    }
  }

  _setSelectedCategory(
      SearchEventSetSelectedCategory event, Emitter<SearchState> emit) async {
    add(SearchEventGetData(page: 1, categoryId: event.selectedCategory, search: state.search));
    emit(state.copyWith(selectedCategory: event.selectedCategory));
  }
}
