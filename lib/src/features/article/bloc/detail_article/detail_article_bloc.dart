import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'detail_article_event.dart';
part 'detail_article_state.dart';

class DetailArticleBloc extends Bloc<DetailArticleEvent, DetailArticleState> {
  DetailArticleBloc() : super(DetailArticleState()) {
    on<DetailArticleEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
