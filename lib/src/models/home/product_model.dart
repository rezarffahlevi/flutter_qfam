class ProductModel {
  int? id;
  String? title;
  String? subTitle;
  String? description;
  int? price;
  int? rating;
  int? ratingCount;
  bool? isFavorite;
  String? image;
  List<ProductOptions>? productOptions;
  List<String>? sizeOptions;

  ProductModel(
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

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    subTitle = json['sub_title'];
    description = json['description'];
    price = json['price'];
    rating = json['rating'];
    ratingCount = json['rating_count'];
    isFavorite = json['is_favorite'];
    image = json['image'];
    if (json['product_options'] != null) {
      productOptions = <ProductOptions>[];
      json['product_options'].forEach((v) {
        productOptions!.add(new ProductOptions.fromJson(v));
      });
    }
    sizeOptions = json['size_options'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['sub_title'] = this.subTitle;
    data['description'] = this.description;
    data['price'] = this.price;
    data['rating'] = this.rating;
    data['rating_count'] = this.ratingCount;
    data['is_favorite'] = this.isFavorite;
    data['image'] = this.image;
    if (this.productOptions != null) {
      data['product_options'] =
          this.productOptions!.map((v) => v.toJson()).toList();
    }
    data['size_options'] = this.sizeOptions;
    return data;
  }
}

class ProductOptions {
  String? color;
  String? image;

  ProductOptions({this.color, this.image});

  ProductOptions.fromJson(Map<String, dynamic> json) {
    color = json['color'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['color'] = this.color;
    data['image'] = this.image;
    return data;
  }
}
