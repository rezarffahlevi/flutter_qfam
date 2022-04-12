class ProductArgument {
  final int? id;
  final String? title;
  final String? subTitle;
  final String? description;
  final int? price;
  final int? rating;
  final int? ratingCount;
  final bool? isFavorite;
  final String? image;
  final List<ProductOptions>? productOptions;
  final List<String>? sizeOptions;

  ProductArgument(
      {this.id,
      this.title,
      this.subTitle,
      this.description,
      this.price,
      this.rating,
      this.ratingCount,
      this.isFavorite,
      this.image,
      this.productOptions,
      this.sizeOptions});
}

class ProductOptions {
  final String? color;
  final String? image;

  ProductOptions({this.color, this.image});
}
