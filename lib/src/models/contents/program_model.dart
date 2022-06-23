class ProgramModel {
  int? id;
  String? uuid;
  String? title;
  String? subtitle;
  String? description;
  String? status;
  String? thumbnail;
  int? price;
  String? dateTime;
  String? endDate;
  String? programByName;
  String? createdAt;
  String? updatedAt;

  int? isVideo;
  int? isExternal;
  String? createdByName;

  ProgramModel({
    this.id,
    this.uuid,
    this.title,
    this.subtitle,
    this.description,
    this.status,
    this.thumbnail,
    this.price,
    this.dateTime,
    this.endDate,
    this.programByName,
    this.createdAt,
    this.updatedAt,
    this.isVideo = 0,
    this.isExternal = 1,
    this.createdByName,
  });

  ProgramModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uuid = json['uuid'];
    title = json['title'];
    subtitle = json['subtitle'];
    description = json['description'];
    status = json['status'];
    thumbnail = json['thumbnail'];
    price = json['price'];
    dateTime = json['date_time'];
    endDate = json['end_date'];
    programByName = json['program_by_name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    createdByName = programByName;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['uuid'] = this.uuid;
    data['title'] = this.title;
    data['subtitle'] = this.subtitle;
    data['description'] = this.description;
    data['status'] = this.status;
    data['thumbnail'] = this.thumbnail;
    data['price'] = this.price;
    data['date_time'] = this.dateTime;
    data['end_date'] = this.endDate;
    data['program_by_name'] = this.programByName;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['createdByName'] = this.createdByName;
    return data;
  }
}
