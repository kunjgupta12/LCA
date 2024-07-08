class Device {
  final DateTime createdOn;
  final DateTime updatedOn;
  final int createdBy;
  final int updatedBy;
  final int id;
  final String imei;
  final String title;
  final bool expansionMode;
  final int valveCount;
  Address? address;

  Device(
      {required this.createdOn,
      required this.updatedOn,
      required this.createdBy,
      required this.updatedBy,
      required this.id,
      required this.imei,
      required this.title,
      required this.expansionMode,
      required this.valveCount,
      required this.address});

  factory Device.fromJson(Map<String, dynamic> json) {
    return Device(
        createdOn: DateTime.parse(json['createdOn']),
        updatedOn: DateTime.parse(json['updatedOn']),
        createdBy: json['createdBy'],
        updatedBy: json['updatedBy'],
        id: json['id'],
        imei: json['imei'],
        title: json['title'],
        expansionMode: json['expansionMode'],
        valveCount: json['valveCount'],
        address: json['address'] != null
            ? new Address.fromJson(json['address'])
            : null);
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

class ApiResponse {
  final List<Device> content;
  final int pageNumber;
  final int pageSize;
  final int totalElements;
  final int totalPages;
  final bool lastPage;

  ApiResponse({
    required this.content,
    required this.pageNumber,
    required this.pageSize,
    required this.totalElements,
    required this.totalPages,
    required this.lastPage,
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    var list = json['content'] as List;
    List<Device> deviceList = list.map((i) => Device.fromJson(i)).toList();

    return ApiResponse(
      content: deviceList,
      pageNumber: json['pageNumber'],
      pageSize: json['pageSize'],
      totalElements: json['totalElements'],
      totalPages: json['totalPages'],
      lastPage: json['lastPage'],
    );
  }
}
