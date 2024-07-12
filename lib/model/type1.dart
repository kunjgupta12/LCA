class type1 {
  type1({
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
  
  type1.fromJson(Map<String, dynamic> json){
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
    required this.ee,
    required this.pc,
    required this.st,
    required this.vc,
    required this.wa,
    required this.wb,
    required this.pit,
    required this.prt,
  });
  late final List<int> m;
  late final int ee;
  late final int pc;
  late final List<int> st;
  late final int vc;
  late final int wa;
  late final int wb;
  late final int pit;
  late final int prt;
  
  C.fromJson(Map<String, dynamic> json){
    m = List.castFrom<dynamic, int>(json['m']);
    ee = json['ee'];
    pc = json['pc'];
    st = List.castFrom<dynamic, int>(json['st']);
    vc = json['vc'];
    wa = json['wa'];
    wb = json['wb'];
    pit = json['pit'];
    prt = json['prt'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['m'] = m;
    _data['ee'] = ee;
    _data['pc'] = pc;
    _data['st'] = st;
    _data['vc'] = vc;
    _data['wa'] = wa;
    _data['wb'] = wb;
    _data['pit'] = pit;
    _data['prt'] = prt;
    return _data;
  }
}