class VersionModel {
  bool? needUpdate;
  bool? forceUpdate;
  String? message;
  String? link;
  String? newVersion;

  VersionModel(
      {this.needUpdate,
      this.forceUpdate,
      this.message,
      this.link,
      this.newVersion});

  VersionModel.fromJson(Map<String, dynamic> json) {
    needUpdate = json['need_update'];
    forceUpdate = json['force_update'];
    message = json['message'];
    link = json['link'];
    newVersion = json['new_version'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['need_update'] = this.needUpdate;
    data['force_update'] = this.forceUpdate;
    data['message'] = this.message;
    data['link'] = this.link;
    data['new_version'] = this.newVersion;
    return data;
  }
}
