import 'dart:convert';

class Schedule {
  ProgramA? programA;
  ProgramB? programB;
  bool? useToday;
  int? prt;
  int? pit;
  Schedule({this.programA, this.programB, this.useToday, this.prt, this.pit});

  Schedule.fromJson(Map<String, dynamic> json) {
    programA = json['programA'] != null
        ?  ProgramA.fromJson(json['programA'])
        : null;
    programB = json['programB'] != null
        ?  ProgramB.fromJson(json['programB'])
        : null;
    useToday = json['useToday'];
    pit = json['pumpInIt'] != null ? json['pit'] : 5;
    prt = json['pumpRechargeTime'] != null ? json['prt'] : 1;
  }

  Map<String, dynamic> toJson(JsonCodec json) {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.programA != null) {
      data['programA'] = this.programA!.toJson();
    }
    if (this.programB != null) {
      data['programB'] = this.programB!.toJson();
    }
    data['useToday'] = this.useToday!;
    if (this.pit != null) {
    data['pumpInIt'] = this.pit!;}
        if (this.prt != null) {
    data['pumpRechargeTime'] = this.prt!;}
    return data;
  }
}
class ProgramB {
  String? title;
  String? startTime;
  String? startTime2;
  bool? frmToday;
  int? programId;
  bool? mode;
  bool? sunday;
  bool? monday;
  bool? tuesday;
  bool? wednesday;
  bool? thrusday;
  bool? friday;
  bool? saturday;
  List<int>? valve1;
  List<int>? valve2;
  List<int>? valve3;
  List<int>? valve4;
  List<int>? valve5;
  List<int>? valve6;
  List<int>? valve7;
  List<int>? valve8;
  List<int>? valve9;
  List<int>? valve10;
  List<int>? valve11;
  List<int>? valve12;

  ProgramB(
      {this.title,
      this.startTime,
      this.startTime2,
      this.programId,
      this.mode,
      this.sunday,
      this.monday,
      this.tuesday,
      this.wednesday,
      this.thrusday,
      this.friday,
      this.saturday,
      this.valve1,
      this.valve2,
      this.valve3,
      this.valve4,
      this.valve5,
      this.valve6,
      this.valve7,
      this.valve8,
      this.valve9,
      this.valve10,
      this.valve11,
      this.valve12});

  ProgramB.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    startTime = json['startTime'];
    startTime2 = json['startTime2'];
    programId = json['programId'];
    mode = json['mode'];
    sunday = json['sunday'];
    monday = json['monday'];
    tuesday = json['tuesday'];
    wednesday = json['wednesday'];
    thrusday = json['thrusday'];
    friday = json['friday'];
    saturday = json['saturday'];
    valve1 = json['valve1'].cast<int>();
    valve2 = json['valve2'].cast<int>();
    valve3 = json['valve3'].cast<int>();
    valve4 = json['valve4'].cast<int>();
    valve5 = json['valve5'].cast<int>();
    valve6 = json['valve6'].cast<int>();
    valve7 = json['valve7'].cast<int>();
    valve8 = json['valve8'].cast<int>();
    valve9 = json['valve9'].cast<int>();
    valve10 = json['valve10'].cast<int>();
    valve11 = json['valve11'].cast<int>();
    valve12 = json['valve12'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['startTime'] = this.startTime;
    data['startTime2'] = this.startTime2;
    data['frmToday'] = this.frmToday;
    data['programId'] = this.programId;
    data['mode'] = this.mode;
    data['sunday'] = this.sunday;
    data['monday'] = this.monday;
    data['tuesday'] = this.tuesday;
    data['wednesday'] = this.wednesday;
    data['thrusday'] = this.thrusday;
    data['friday'] = this.friday;
    data['saturday'] = this.saturday;
    data['valve1'] = this.valve1;
    data['valve2'] = this.valve2;
    data['valve3'] = this.valve3;
    data['valve4'] = this.valve4;
    data['valve5'] = this.valve5;
    data['valve6'] = this.valve6;
    data['valve7'] = this.valve7;
    data['valve8'] = this.valve8;
    data['valve9'] = this.valve9;
    data['valve10'] = this.valve10;
    data['valve11'] = this.valve11;
    data['valve12'] = this.valve12;
    return data;
  }
}

class ProgramA {
  String? title;
  String? startTime;
  String? startTime2;
  bool? frmToday;
  int? programId;
  bool? mode;
  bool? sunday;
  bool? monday;
  bool? tuesday;
  bool? wednesday;
  bool? thrusday;
  bool? friday;
  bool? saturday;
  List<int>? valve1;
  List<int>? valve2;
  List<int>? valve3;
  List<int>? valve4;
  List<int>? valve5;
  List<int>? valve6;
  List<int>? valve7;
  List<int>? valve8;
  List<int>? valve9;
  List<int>? valve10;
  List<int>? valve11;
  List<int>? valve12;

  ProgramA(
      {this.title,
      this.startTime,
      this.startTime2,
      this.programId,
      this.mode,
      this.sunday,
      this.monday,
      this.tuesday,
      this.wednesday,
      this.thrusday,
      this.friday,
      this.saturday,
      this.valve1,
      this.valve2,
      this.valve3,
      this.valve4,
      this.valve5,
      this.valve6,
      this.valve7,
      this.valve8,
      this.valve9,
      this.valve10,
      this.valve11,
      this.valve12});

  ProgramA.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    startTime = json['startTime'];
    startTime2 = json['startTime2'];
    programId = json['programId'];
    mode = json['mode'];
    sunday = json['sunday'];
    monday = json['monday'];
    tuesday = json['tuesday'];
    wednesday = json['wednesday'];
    thrusday = json['thrusday'];
    friday = json['friday'];
    saturday = json['saturday'];
    valve1 = json['valve1'].cast<int>();
    valve2 = json['valve2'].cast<int>();
    valve3 = json['valve3'].cast<int>();
    valve4 = json['valve4'].cast<int>();
    valve5 = json['valve5'].cast<int>();
    valve6 = json['valve6'].cast<int>();
    valve7 = json['valve7'].cast<int>();
    valve8 = json['valve8'].cast<int>();
    valve9 = json['valve9'].cast<int>();
    valve10 = json['valve10'].cast<int>();
    valve11 = json['valve11'].cast<int>();
    valve12 = json['valve12'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['title'] = this.title;
    data['startTime'] = this.startTime;
    data['startTime2'] = this.startTime2;
    data['frmToday'] = this.frmToday;
    data['programId'] = this.programId;
    data['mode'] = this.mode;
    data['sunday'] = this.sunday;
    data['monday'] = this.monday;
    data['tuesday'] = this.tuesday;
    data['wednesday'] = this.wednesday;
    data['thrusday'] = this.thrusday;
    data['friday'] = this.friday;
    data['saturday'] = this.saturday;
    data['valve1'] = this.valve1;
    data['valve2'] = this.valve2;
    data['valve3'] = this.valve3;
    data['valve4'] = this.valve4;
    data['valve5'] = this.valve5;
    data['valve6'] = this.valve6;
    data['valve7'] = this.valve7;
    data['valve8'] = this.valve8;
    data['valve9'] = this.valve9;
    data['valve10'] = this.valve10;
    data['valve11'] = this.valve11;
    data['valve12'] = this.valve12;
    return data;
  }
}
