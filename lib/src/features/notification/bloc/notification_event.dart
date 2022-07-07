part of 'notification_bloc.dart';

abstract class NotificationEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class NotificationEventGetData extends NotificationEvent {
  int page;

  NotificationEventGetData({
    this.page = 1,
  });

  @override
  List<Object?> get props => [page];
}

class NotificationEventRefresh extends NotificationEvent {}
