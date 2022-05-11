part of 'detail_article_bloc.dart';

class DetailArticleState extends Equatable {
  final bool isLoading;

  const DetailArticleState({
    this.isLoading = false,
  });

  DetailArticleState copyWith({
    int? number,
    bool? isLoading,
  }) {
    return DetailArticleState(
      isLoading: isLoading ?? this.isLoading,
    );
  }
  
  @override
  List<Object?> get props => [isLoading];
}
