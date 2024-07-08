class Complaint {
  String? createdOn;
  String? updatedOn;
  int? createdBy;
  int? updatedBy;
  int? id;
  int? customer;
  int? device;
  int? technician;
  Status? status;
  int? category;
  String? description;
  String? resolutionDesc;

  Complaint(
      {this.createdOn,
      this.updatedOn,
      this.createdBy,
      this.updatedBy,
      this.id,
      this.customer,
      this.device,
      this.technician,
      this.status,
      this.category,
      this.description,
      this.resolutionDesc});

  Complaint.fromJson(Map<String, dynamic> json) {
    createdOn = json['createdOn'];
    updatedOn = json['updatedOn'];
    createdBy = json['createdBy'];
    updatedBy = json['updatedBy'];
    id = json['id'];
    customer = json['customer'];
    device = json['device'];
    technician = json['technician'];
    status =
        json['status'] != null ? new Status.fromJson(json['status']) : null;
    category = json['category'];
    description = json['description'];
    resolutionDesc = json['resolutionDesc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['createdOn'] = this.createdOn;
    data['updatedOn'] = this.updatedOn;
    data['createdBy'] = this.createdBy;
    data['updatedBy'] = this.updatedBy;
    data['id'] = this.id;
    data['customer'] = this.customer;
    data['device'] = this.device;
    data['technician'] = this.technician;
    if (this.status != null) {
      data['status'] = this.status!.toJson();
    }
    data['category'] = this.category;
    data['description'] = this.description;
    data['resolutionDesc'] = this.resolutionDesc;
    return data;
  }
}

class Status {
  int? id;
  String? status;

  Status({this.id, this.status});

  Status.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['status'] = this.status;
    return data;
  }
}
