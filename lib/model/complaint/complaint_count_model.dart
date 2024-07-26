class ComplaintCount {
  int? statusId;
  String? statusName;
  int? count;

  ComplaintCount({this.statusId, this.statusName, this.count});

  ComplaintCount.fromJson(Map<String, dynamic> json) {
    statusId = json['statusId'];
    statusName = json['statusName'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusId'] = this.statusId;
    data['statusName'] = this.statusName;
    data['count'] = this.count;
    return data;
  }
}
