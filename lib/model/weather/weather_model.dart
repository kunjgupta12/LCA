class Weather {
  Location? location;
  Current? current;
  Forecast? forecast;

  Weather({this.location, this.current, this.forecast});

  Weather.fromJson(Map<String, dynamic> json) {
    location = json['location'] != null
        ? new Location.fromJson(json['location'])
        : null;
    current =
        json['current'] != null ? new Current.fromJson(json['current']) : null;
    forecast = json['forecast'] != null
        ? new Forecast.fromJson(json['forecast'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.location != null) {
      data['location'] = this.location!.toJson();
    }
    if (this.current != null) {
      data['current'] = this.current!.toJson();
    }
    if (this.forecast != null) {
      data['forecast'] = this.forecast!.toJson();
    }
    return data;
  }
}

class Location {
  String? name;
  String? region;
  String? country;
  double? lat;
  double? lon;
  String? tzId;
  int? localtimeEpoch;
  String? localtime;

  Location(
      {this.name,
      this.region,
      this.country,
      this.lat,
      this.lon,
      this.tzId,
      this.localtimeEpoch,
      this.localtime});

  Location.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    region = json['region'];
    country = json['country'];
    lat = json['lat'];
    lon = json['lon'];
    tzId = json['tz_id'];
    localtimeEpoch = json['localtime_epoch'];
    localtime = json['localtime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['region'] = this.region;
    data['country'] = this.country;
    data['lat'] = this.lat;
    data['lon'] = this.lon;
    data['tz_id'] = this.tzId;
    data['localtime_epoch'] = this.localtimeEpoch;
    data['localtime'] = this.localtime;
    return data;
  }
}

class Current {
  double? tempC;
  Condition? condition;
  double? windKph;
  int? cloud;
  double? feelslikeC;

  Current(
      {this.tempC, this.condition, this.windKph, this.cloud, this.feelslikeC});

  Current.fromJson(Map<String, dynamic> json) {
    tempC = json['temp_c'];
    condition = json['condition'] != null
        ? new Condition.fromJson(json['condition'])
        : null;
    windKph = json['wind_kph'];
    cloud = json['cloud'];
    feelslikeC = json['feelslike_c'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['temp_c'] = this.tempC;
    if (this.condition != null) {
      data['condition'] = this.condition!.toJson();
    }
    data['wind_kph'] = this.windKph;
    data['cloud'] = this.cloud;
    data['feelslike_c'] = this.feelslikeC;
    return data;
  }
}

class Condition {
  String? text;
  String? icon;

  Condition({this.text, this.icon});

  Condition.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    icon = json['icon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['text'] = this.text;
    data['icon'] = this.icon;
    return data;
  }
}

class Forecast {
  List<Forecastday>? forecastday;

  Forecast({this.forecastday});

  Forecast.fromJson(Map<String, dynamic> json) {
    if (json['forecastday'] != null) {
      forecastday = <Forecastday>[];
      json['forecastday'].forEach((v) {
        forecastday!.add(new Forecastday.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.forecastday != null) {
      data['forecastday'] = this.forecastday!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Forecastday {
  Day? day;

  Forecastday({this.day});

  Forecastday.fromJson(Map<String, dynamic> json) {
    day = json['day'] != null ? new Day.fromJson(json['day']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.day != null) {
      data['day'] = this.day!.toJson();
    }
    return data;
  }
}

class Day {
  double? maxtempC;
  double? mintempC;
  double? totalprecipMm;
  int? avghumidity;
  int? dailyChanceOfRain;

  Day(
      {this.maxtempC,
      this.mintempC,
      this.totalprecipMm,
      this.avghumidity,
      this.dailyChanceOfRain});

  Day.fromJson(Map<String, dynamic> json) {
    maxtempC = json['maxtemp_c'];
    mintempC = json['mintemp_c'];
    totalprecipMm = json['totalprecip_mm'];
    avghumidity = json['avghumidity'];
    dailyChanceOfRain = json['daily_chance_of_rain'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['maxtemp_c'] = this.maxtempC;
    data['mintemp_c'] = this.mintempC;
    data['totalprecip_mm'] = this.totalprecipMm;
    data['avghumidity'] = this.avghumidity;
    data['daily_chance_of_rain'] = this.dailyChanceOfRain;
    return data;
  }
}
