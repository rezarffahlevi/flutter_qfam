import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_qfam/src/models/profile/user_model.dart';
import 'package:flutter_qfam/src/services/profile/forum_service.dart';
import 'package:flutter_qfam/src/widgets/widgets.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(const ProfileState()) {
    on<ProfileEventGetData>(_getData);
    on<ProfileEventRefresh>(_onRefresh);
  }
  ProfileService apiService = ProfileService();

  _onRefresh(ProfileEventRefresh event, Emitter<ProfileState> emit) async {
    add(ProfileEventGetData());
  }

  _getData(ProfileEventGetData event, Emitter<ProfileState> emit) async {
    try {
      emit(state.copyWith(state: NetworkStates.onLoading));
      var response = await apiService.getCurrentUser();
      emit(state.copyWith(state: NetworkStates.onLoaded, currentUser: response?.data));
    } catch (e) {
      emit(state.copyWith(state: NetworkStates.onError, message: e.toString()));
    }
  }
}
