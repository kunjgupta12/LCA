class ComplaintDetail {
  List<Content>? content;
  int? pageNumber;
  int? pageSize;
  int? totalElements;
  int? totalPages;
  bool? lastPage;

  ComplaintDetail(
      {this.content,
      this.pageNumber,
      this.pageSize,
      this.totalElements,
      this.totalPages,
      this.lastPage});

  ComplaintDetail.fromJson(Map<String, dynamic> json) {
    if (json['content'] != null) {
      content = <Content>[];
      json['content'].forEach((v) {
        content!.add(new Content.fromJson(v));
      });
    }
    pageNumber = json['pageNumber'];
    pageSize = json['pageSize'];
    totalElements = json['totalElements'];
    totalPages = json['totalPages'];
    lastPage = json['lastPage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.content != null) {
      data['content'] = this.content!.map((v) => v.toJson()).toList();
    }
    data['pageNumber'] = this.pageNumber;
    data['pageSize'] = this.pageSize;
    data['totalElements'] = this.totalElements;
    data['totalPages'] = this.totalPages;
    data['lastPage'] = this.lastPage;
    return data;
  }
}

class Content {
  int? id;
  int? customerId;
  String? customerName;
  String? customerPhoneNo;
  String? deviceImei;
  DeviceAddress? deviceAddress;
  int? technicianId;
  String? technicianName;
  String? assignDate;
  int? statusId;
  String? statusName;
  String? categoryTitle;
  String? description;
  Null? resolutionDesc;
  String? registeredDate;

  Content(
      {this.id,
      this.customerId,
      this.customerName,
      this.customerPhoneNo,
      this.deviceImei,
      this.deviceAddress,
      this.technicianId,
      this.technicianName,
      this.assignDate,
      this.statusId,
      this.statusName,
      this.categoryTitle,
      this.description,
      this.resolutionDesc,
      this.registeredDate});

  Content.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerId = json['customerId'];
    customerName = json['customerName'];
    customerPhoneNo = json['customerPhoneNo'];
    deviceImei = json['deviceImei'];
    deviceAddress = json['deviceAddress'] != null
        ? new DeviceAddress.fromJson(json['deviceAddress'])
        : null;
    technicianId = json['technicianId'];
    technicianName = json['technicianName'];
    assignDate = json['assignDate'];
    statusId = json['statusId'];
    statusName = json['statusName'];
    categoryTitle = json['categoryTitle'];
    description = json['description'];
    resolutionDesc = json['resolutionDesc'];
    registeredDate = json['registeredDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['customerId'] = this.customerId;
    data['customerName'] = this.customerName;
    data['customerPhoneNo'] = this.customerPhoneNo;
    data['deviceImei'] = this.deviceImei;
    if (this.deviceAddress != null) {
      data['deviceAddress'] = this.deviceAddress!.toJson();
    }
    data['technicianId'] = this.technicianId;
    data['technicianName'] = this.technicianName;
    data['assignDate'] = this.assignDate;
    data['statusId'] = this.statusId;
    data['statusName'] = this.statusName;
    data['categoryTitle'] = this.categoryTitle;
    data['description'] = this.description;
    data['resolutionDesc'] = this.resolutionDesc;
    data['registeredDate'] = this.registeredDate;
    return data;
  }
}

class DeviceAddress {
  String? createdOn;
  String? updatedOn;
  int? createdBy;
  int? updatedBy;
  int? id;
  String? city;
  int? pincode;
  String? state;
  String? country;
  String? fullAddress;
  double? lat;
  double? long;

  DeviceAddress(
      {this.createdOn,
      this.updatedOn,
      this.createdBy,
      this.updatedBy,
      this.id,
      this.city,
      this.pincode,
      this.state,
      this.country,
      this.fullAddress,
      this.lat,
      this.long});

  DeviceAddress.fromJson(Map<String, dynamic> json) {
    createdOn = json['createdOn'];
    updatedOn = json['updatedOn'];
    createdBy = json['createdBy'];
    updatedBy = json['updatedBy'];
    id = json['id'];
    city = json['city'];
    pincode = json['pincode'];
    state = json['state'];
    country = json['country'];
    fullAddress = json['fullAddress'];
    lat = json['lat'];
    long = json['long'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['createdOn'] = this.createdOn;
    data['updatedOn'] = this.updatedOn;
    data['createdBy'] = this.createdBy;
    data['updatedBy'] = this.updatedBy;
    data['id'] = this.id;
    data['city'] = this.city;
    data['pincode'] = this.pincode;
    data['state'] = this.state;
    data['country'] = this.country;
    data['fullAddress'] = this.fullAddress;
    data['lat'] = this.lat;
    data['long'] = this.long;
    return data;
  }
}
