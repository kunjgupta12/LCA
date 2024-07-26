class LoginModel {
  String? token;
  Data? data;

  LoginModel({this.token, this.data});

  LoginModel.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<Role>? role;
  User? user;

  Data({this.role, this.user});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['role'] != null) {
      role = <Role>[];
      json['role'].forEach((v) {
        role!.add(new Role.fromJson(v));
      });
    }
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.role != null) {
      data['role'] = this.role!.map((v) => v.toJson()).toList();
    }
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class Role {
  String? authority;

  Role({this.authority});

  Role.fromJson(Map<String, dynamic> json) {
    authority = json['authority'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['authority'] = this.authority;
    return data;
  }
}

class User {
  String? createdOn;
  String? updatedOn;
  int? createdBy;
  int? updatedBy;
  int? id;
  String? firstName;
  String? lastName;
  String? phoneNo;
  Address? address;
  String? email;
  String? startDate;
  Null? endDate;
  String? imgUrl;

  User(
      {this.createdOn,
      this.updatedOn,
      this.createdBy,
      this.updatedBy,
      this.id,
      this.firstName,
      this.lastName,
      this.phoneNo,
      this.address,
      this.email,
      this.startDate,
      this.endDate,
      this.imgUrl});

  User.fromJson(Map<String, dynamic> json) {
    createdOn = json['createdOn'];
    updatedOn = json['updatedOn'];
    createdBy = json['createdBy'];
    updatedBy = json['updatedBy'];
    id = json['id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    phoneNo = json['phoneNo'];
    address =
        json['address'] != null ? new Address.fromJson(json['address']) : null;
    email = json['email'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    imgUrl = json['img_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['createdOn'] = this.createdOn;
    data['updatedOn'] = this.updatedOn;
    data['createdBy'] = this.createdBy;
    data['updatedBy'] = this.updatedBy;
    data['id'] = this.id;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['phoneNo'] = this.phoneNo;
    if (this.address != null) {
      data['address'] = this.address!.toJson();
    }
    data['email'] = this.email;
    data['startDate'] = this.startDate;
    data['endDate'] = this.endDate;
    data['img_url'] = this.imgUrl;
    return data;
  }
}

class Address {
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

  Address(
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

  Address.fromJson(Map<String, dynamic> json) {
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
