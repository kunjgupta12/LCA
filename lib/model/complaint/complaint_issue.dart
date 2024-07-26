class Issue {
  String? createdOn;
  String? updatedOn;
  int? createdBy;
  int? updatedBy;
  int? id;
  String? title;
  String? description;

  Issue(
      {this.createdOn,
      this.updatedOn,
      this.createdBy,
      this.updatedBy,
      this.id,
      this.title,
      this.description});

  Issue.fromJson(Map<String, dynamic> json) {
    createdOn = json['createdOn'];
    updatedOn = json['updatedOn'];
    createdBy = json['createdBy'];
    updatedBy = json['updatedBy'];
    id = json['id'];
    title = json['title'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['createdOn'] = this.createdOn;
    data['updatedOn'] = this.updatedOn;
    data['createdBy'] = this.createdBy;
    data['updatedBy'] = this.updatedBy;
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    return data;
  }
}
