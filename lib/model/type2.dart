class type2 {
  type2({
    required this.id,
    required this.deviceId,
    required this.typeId,
    required this.c,
    required this.t,
  });
  late final int id;
  late final int deviceId;
  late final int typeId;
  late final C c;
  late final String t;
  
  type2.fromJson(Map<String, dynamic> json){
    id = json['id'];
    deviceId = json['deviceId'];
    typeId = json['typeId'];
    c = C.fromJson(json['c']);
    t = json['t'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['deviceId'] = deviceId;
    _data['typeId'] = typeId;
    _data['c'] = c.toJson();
    _data['t'] = t;
    return _data;
  }
}

class C {
  C({
    required this.m,
     this.fd,
  this.vd,
   this.pwd,
     this.frtd,
  });
  late final int m;
  late final List<int>? fd;
  late final List<int>? vd;
  late final List<int>? pwd;
  late final List<int>?frtd;
  
  C.fromJson(Map<String, dynamic> json){
    m = json['m'];
    fd = json['fd'] != null? List.castFrom<dynamic, int>(json['fd']):null;
    vd =json['vd']!=null ?List.castFrom<dynamic, int>(json['vd']) :null;
    pwd = json['pwd']!=null ?List.castFrom<dynamic, int>(json['pwd']):null;
    frtd =json['frtd']!=null?List.castFrom<dynamic, int>(json['frtd']):null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['m'] = m;
    _data['fd'] = fd;
    _data['vd'] = vd;
    _data['pwd'] = pwd;
    _data['frtd'] = frtd;
    return _data;
  }
}