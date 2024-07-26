class type3 {
  int? id;
  int? deviceId;
  int? typeId;
  C? c;
  String? t;

  type3({this.id, this.deviceId, this.typeId, this.c, this.t});

  type3.fromJson(Map<String, dynamic> json) {
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
  List<int>? fd;
  List<int>? vd;
  List<int>? pwd;
  List<int>? frtd;

  C({this.m, this.fd, this.vd, this.pwd, this.frtd});

  C.fromJson(Map<String, dynamic> json) {
    m = json['m'];
    fd = json['fd'].cast<int>();
    vd = json['vd'].cast<int>();
    pwd = json['pwd'].cast<int>();
    frtd = json['frtd'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['m'] = this.m;
    data['fd'] = this.fd;
    data['vd'] = this.vd;
    data['pwd'] = this.pwd;
    data['frtd'] = this.frtd;
    return data;
  }
}
