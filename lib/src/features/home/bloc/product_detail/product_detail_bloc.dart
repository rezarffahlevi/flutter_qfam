import 'package:bloc/bloc.dart';
import 'package:flutter_siap_nikah/src/models/home/product_model.dart';
import 'package:equatable/equatable.dart';

part 'product_detail_event.dart';
part 'product_detail_state.dart';

class ProductDetailBloc extends Bloc<ProductDetailEvent, ProductDetailState> {
  ProductDetailBloc() : super(ProductDetailState()) {
    on<ProductDetailEventSetDetail>(_setDetail);
    on<ProductDetailEventSetColor>(_setColor);
    on<ProductDetailEventSetSize>(_setSize);
  }

  _setDetail(ProductDetailEventSetDetail event,
      Emitter<ProductDetailState> emit) async {
    emit(state.copyWith(isLoading: true));
    emit(state.copyWith(product: event.product, isLoading: false));
  }

  _setColor(ProductDetailEventSetColor event,
      Emitter<ProductDetailState> emit) async {
    emit(state.copyWith(isLoading: true));
    emit(state.copyWith(color: event.color, isLoading: false));
  }

  _setSize(ProductDetailEventSetSize event,
      Emitter<ProductDetailState> emit) async {
    emit(state.copyWith(isLoading: true));
    emit(state.copyWith(size: event.size, isLoading: false));
  }
}
