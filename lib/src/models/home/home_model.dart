class HomeModel {
  List<Category>? category;
  List<Home>? home;

  HomeModel({this.category, this.home});

  HomeModel.fromJson(Map<String, dynamic> json) {
    if (json['category'] != null) {
      category = <Category>[];
      json['category'].forEach((v) {
        category!.add(new Category.fromJson(v));
      });
    }
    if (json['home'] != null) {
      home = <Home>[];
      json['home'].forEach((v) {
        home!.add(new Home.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.category != null) {
      data['category'] = this.category!.map((v) => v.toJson()).toList();
    }
    if (this.home != null) {
      data['home'] = this.home!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Category {
  int? id;
  String? name;

  Category({this.id, this.name});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}

class Home {
  String? type;
  String? title;
  int? categoryId;
  List<Data>? data;

  Home({this.type, this.title, this.categoryId, this.data});

  Home.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    title = json['title'];
    categoryId = json['category_id'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['title'] = this.title;
    data['category_id'] = this.categoryId;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  String? title;
  String? image;
  String? author;

  Data({this.id, this.title, this.image, this.author});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    image = json['image'];
    author = json['author'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['image'] = this.image;
    data['author'] = this.author;
    return data;
  }
}