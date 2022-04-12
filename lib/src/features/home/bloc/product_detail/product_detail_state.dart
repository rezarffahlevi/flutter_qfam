part of 'product_detail_bloc.dart';

class ProductDetailState extends Equatable {
  final bool isLoading;
  final ProductModel? product;
  final String? color;
  final String? size;

  const ProductDetailState({
    this.isLoading = true,
    this.product,
    this.color,
    this.size,
  });

  ProductDetailState copyWith({
    bool? isLoading,
    ProductModel? product,
    String? color,
    String? size,
  }) {
    return ProductDetailState(
      isLoading: isLoading ?? this.isLoading,
      product: product ?? this.product,
      color: color ?? this.color,
      size: size ?? this.size,
    );
  }

  @override
  List<Object?> get props => [isLoading, product, color, size];
}

