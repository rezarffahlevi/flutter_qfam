class DefaultResponseModel {
  String? code;
  String? message;
  dynamic error;
  dynamic data;
  dynamic detail;
  PaginationModel? pagination;

  DefaultResponseModel(
      {this.code, this.message, this.error, this.data, this.detail});

  DefaultResponseModel.fromJson(
      {required Map<String, dynamic> json,
      dynamic jsonData,
      dynamic jsonDetail}) {
    code = json['code'];
    message = json['message'];
    error = json['error'];
    data = jsonData != null ? jsonData : null;
    pagination = json['pagination'] != null
        ? new PaginationModel.fromJson(json['pagination'])
        : null;
    detail = jsonDetail != null ? jsonDetail : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    data['error'] = this.error;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    if (this.pagination != null) {
      data['pagination'] = this.pagination!.toJson();
    }
    if (this.detail != null) {
      data['detail'] = this.detail!.toJson();
    }
    return data;
  }
}

class PaginationModel {
  int? count;
  int? currentPage;
  int? lastPage;
  int? perPage;
  int? total;

  PaginationModel(
      {this.count, this.currentPage, this.lastPage, this.perPage, this.total});

  PaginationModel.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    currentPage = json['current_page'];
    lastPage = json['last_page'];
    perPage = json['per_page'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    data['current_page'] = this.currentPage;
    data['last_page'] = this.lastPage;
    data['per_page'] = this.perPage;
    data['total'] = this.total;
    return data;
  }
}
