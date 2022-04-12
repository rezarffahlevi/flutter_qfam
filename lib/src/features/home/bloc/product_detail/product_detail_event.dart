part of 'product_detail_bloc.dart';

abstract class ProductDetailEvent extends Equatable {

  @override
  List<Object?> get props => [];
}
class ProductDetailEventSetDetail extends ProductDetailEvent {
  final ProductModel? product;

  ProductDetailEventSetDetail({this.product});

  @override
  List<Object?> get props => [product];
}

class ProductDetailEventSetColor extends ProductDetailEvent {
  final String? color;

  ProductDetailEventSetColor({this.color});

  @override
  List<Object?> get props => [color];
}

class ProductDetailEventSetSize extends ProductDetailEvent {
  final String? size;

  ProductDetailEventSetSize({this.size});

  @override
  List<Object?> get props => [size];
}