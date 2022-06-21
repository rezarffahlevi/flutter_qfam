class CategoryModel {
  int? id;
  String? category;
  String? image;

  CategoryModel({this.id, this.category, this.image});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    category = json['category'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['category'] = this.category;
    data['image'] = this.image;
    return data;
  }
}
