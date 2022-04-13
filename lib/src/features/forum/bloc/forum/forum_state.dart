part of 'forum_bloc.dart';
class ForumState extends Equatable {
  final NetworkStates state;

  const ForumState({
    this.state = NetworkStates.onLoading,
  });

  ForumState copyWith({
    NetworkStates? state,
  }) {
    return ForumState(
      state: state ?? this.state,
    );
  }

  @override
  List<Object?> get props => [state];
}
