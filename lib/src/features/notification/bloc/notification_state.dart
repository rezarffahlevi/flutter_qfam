part of 'notification_bloc.dart';

class NotificationState extends Equatable {
  final NetworkStates state;
  final int page;
  final DefaultResponseModel? resNotif;
  final List<NotificationModel>? list;

  const NotificationState({
    this.state = NetworkStates.onLoading,
    this.page = 1,
    this.resNotif,
    this.list,
  });

  NotificationState copyWith({
    NetworkStates? state,
    int? page = 1,
    DefaultResponseModel? resNotif,
    List<NotificationModel>? list,
  }) {
    return NotificationState(
      state: state ?? this.state,
      page: page ?? this.page,
      resNotif: resNotif ?? this.resNotif,
      list: list ?? this.list,
    );
  }

  @override
  List<Object?> get props => [state, page, resNotif, list];
}
