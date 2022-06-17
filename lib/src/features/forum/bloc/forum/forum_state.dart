part of 'forum_bloc.dart';

class ForumState extends Equatable {
  final NetworkStates state;
  final dynamic message;
  final List<ThreadsModel>? threads;

  const ForumState({
    this.state = NetworkStates.onLoading,
    this.threads = const [],
    this.message = '',
  });

  ForumState copyWith({
    NetworkStates? state,
    final List<ThreadsModel>? threads,
    final dynamic message,
  }) {
    return ForumState(
      state: state ?? this.state,
      threads: threads ?? this.threads,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [state, threads, message];
}
