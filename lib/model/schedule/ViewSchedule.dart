class GetSchedule {
  String? createdOn;
  String? updatedOn;
  int? createdBy;
  int? updatedBy;
  int? id;
  int? device;
  int? program;
  String? startTime;
  String? startTime2;
  int? pumpInIt;
  int? pumpRechargeTime;
  bool? useToday;
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

  GetSchedule({
    this.createdOn,
    this.updatedOn,
    this.createdBy,
    this.updatedBy,
    this.id,
    this.device,
    this.program,
    this.startTime,
    this.startTime2,
    this.pumpInIt,
    this.pumpRechargeTime,
    this.useToday,
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
    this.valve12,
  });

  GetSchedule.fromJson(Map<String, dynamic> json) {
    createdOn = json['createdOn'];
    updatedOn = json['updatedOn'];
    createdBy = json['createdBy'];
    updatedBy = json['updatedBy'];
    id = json['id'];
    device = json['device'];
    program = json['program'];
    startTime = json['startTime'];
    startTime2 = json['startTime2'];
    pumpInIt = json['pumpInIt'];
    pumpRechargeTime = json['pumpRechargeTime'];
    useToday = json['useToday'];
    mode = json['mode'];
    sunday = json['sunday'];
    monday = json['monday'];
    tuesday = json['tuesday'];
    wednesday = json['wednesday'];
    thrusday = json['thrusday'];
    friday = json['friday'];
    saturday = json['saturday'];
    valve1 = json['valve1'] != null ? List<int>.from(json['valve1']) : null;
    valve2 = json['valve2'] != null ? List<int>.from(json['valve2']) : null;
    valve3 = json['valve3'] != null ? List<int>.from(json['valve3']) : null;
    valve4 = json['valve4'] != null ? List<int>.from(json['valve4']) : null;
    valve5 = json['valve5'] != null ? List<int>.from(json['valve5']) : null;
    valve6 = json['valve6'] != null ? List<int>.from(json['valve6']) : null;
    valve7 = json['valve7'] != null ? List<int>.from(json['valve7']) : null;
    valve8 = json['valve8'] != null ? List<int>.from(json['valve8']) : null;
    valve9 = json['valve9'] != null ? List<int>.from(json['valve9']) : null;
    valve10 = json['valve10'] != null ? List<int>.from(json['valve10']) : null;
    valve11 = json['valve11'] != null ? List<int>.from(json['valve11']) : null;
    valve12 = json['valve12'] != null ? List<int>.from(json['valve12']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['createdOn'] = createdOn;
    data['updatedOn'] = updatedOn;
    data['createdBy'] = createdBy;
    data['updatedBy'] = updatedBy;
    data['id'] = id;
    data['device'] = device;
    data['program'] = program;
    data['startTime'] = startTime;
    data['startTime2'] = startTime2;
    data['pumpInIt'] = pumpInIt;
    data['pumpRechargeTime'] = pumpRechargeTime;
    data['useToday'] = useToday;
    data['mode'] = mode;
    data['sunday'] = sunday;
    data['monday'] = monday;
    data['tuesday'] = tuesday;
    data['wednesday'] = wednesday;
    data['thrusday'] = thrusday;
    data['friday'] = friday;
    data['saturday'] = saturday;
    data['valve1'] = valve1;
    data['valve2'] = valve2;
    data['valve3'] = valve3;
    data['valve4'] = valve4;
    data['valve5'] = valve5;
    data['valve6'] = valve6;
    data['valve7'] = valve7;
    data['valve8'] = valve8;
    data['valve9'] = valve9;
    data['valve10'] = valve10;
    data['valve11'] = valve11;
    data['valve12'] = valve12;
    return data;
  }
}
