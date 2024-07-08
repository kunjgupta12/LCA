class type2 {
  int? id;
  int? deviceId;
  int? typeId;
  C? c;
  String? t;

  type2({this.id, this.deviceId, this.typeId, this.c, this.t});

  type2.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    deviceId = json['deviceId'];
    typeId = json['typeId'];
    c = json['c'] != null ? new C.fromJson(json['c']) : null;
    t = json['t'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['deviceId'] = this.deviceId;
    data['typeId'] = this.typeId;
    if (this.c != null) {
      data['c'] = this.c!.toJson();
    }
    data['t'] = this.t;
    return data;
  }
}

class C {
  int? m;
  List<int>? vd;

  C({this.m, this.vd});

  C.fromJson(Map<String, dynamic> json) {
    m = json['m'];
    vd = json['vd'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['m'] = this.m;
    data['vd'] = this.vd;
    return data;
  }
}
