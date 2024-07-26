class DeviceStatus {
  int? id;
  int? deviceId;
  int? typeId;
  C? c;
  String? t;

  DeviceStatus({this.id, this.deviceId, this.typeId, this.c, this.t});

  DeviceStatus.fromJson(Map<String, dynamic> json) {
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
  String?p;
  int? v;
  int? dt;
  int? fc;
  int? lf;
  int? ms;
  int? nd;
  int? ns;
  int? pc;
  int? pi;
  int? ps;
  int? rs;
  int? sc;
  int? vs;
  int? bal;
  int? pit;
  int? prt;
  int? rsf;

  C(
      {this.v,
      this.dt,
      this.fc,
      this.lf,
      this.p,
      this.ms,
      this.nd,
      this.ns,
      this.pc,
      this.pi,
      this.ps,
      this.rs,
      this.sc,
      this.vs,
      this.bal,
      this.pit,
      this.prt,
      this.rsf});

  C.fromJson(Map<String, dynamic> json) {
    v = json['v'];//running valve number
    dt = json['dt'];
    fc = json['fc'];
    p=json['p'];
    lf = json['lf'];
    ms = json['ms'];
    nd = json['nd'];
    ns = json['ns'];
    pc = json['pc'];
    pi = json['pi'];
    ps = json['ps'];
    rs = json['rs'];
    sc = json['sc'];
    vs = json['vs'];
    bal = json['bal'];//balance time
    pit = json['pit'];
    prt = json['prt'];
    rsf = json['rsf'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['v'] = this.v;
    data['dt'] = this.dt;
    data['fc'] = this.fc;
    data['lf'] = this.lf;
    data['ms'] = this.ms;
    data['nd'] = this.nd;
    data['ns'] = this.ns;
    data['p']=this.p;
    data['pc'] = this.pc;
    data['pi'] = this.pi;
    data['ps'] = this.ps;
    data['rs'] = this.rs;
    data['sc'] = this.sc;
    data['vs'] = this.vs;
    data['bal'] = this.bal;
    data['pit'] = this.pit;
    data['prt'] = this.prt;
    data['rsf'] = this.rsf;
    return data;
  }
}
