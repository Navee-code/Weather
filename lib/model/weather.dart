class WeatherData {
  final List<MinuteForecast> minutely;
  final List<HourlyForecast> hourly;
  final List<DailyForecast> daily;
  final Location location;

  WeatherData({
    required this.minutely,
    required this.hourly,
    required this.daily,
    required this.location,
  });

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    return WeatherData(
      minutely: (json['timelines']['minutely'] as List)
          .map((item) => MinuteForecast.fromJson(item))
          .toList(),
      hourly: (json['timelines']['hourly'] as List)
          .map((item) => HourlyForecast.fromJson(item))
          .toList(),
      daily: (json['timelines']['daily'] as List)
          .map((item) => DailyForecast.fromJson(item))
          .toList(),
      location: Location.fromJson(json['location']),
    );
  }
}

class MinuteForecast {
  final DateTime time;
  final ForecastValues values;

  MinuteForecast({required this.time, required this.values});

  factory MinuteForecast.fromJson(Map<String, dynamic> json) {
    return MinuteForecast(
      time: DateTime.parse(json['time']),
      values: ForecastValues.fromJson(json['values']),
    );
  }
}

class HourlyForecast {
  final DateTime time;
  final ForecastValues values;

  HourlyForecast({required this.time, required this.values});

  factory HourlyForecast.fromJson(Map<String, dynamic> json) {
    return HourlyForecast(
      time: DateTime.parse(json['time']),
      values: ForecastValues.fromJson(json['values']),
    );
  }
}

class DailyForecast {
  final DateTime time;
  final ForecastValues values;

  DailyForecast({required this.time, required this.values});

  factory DailyForecast.fromJson(Map<String, dynamic> json) {
    return DailyForecast(
      time: DateTime.parse(json['time']),
      values: ForecastValues.fromJson(json['values']),
    );
  }
}

class ForecastValues {
  final double cloudBase;
  final double cloudCeiling;
  final int cloudCover;
  final double dewPoint;
  final double freezingRainIntensity;
  final int humidity;
  final int precipitationProbability;
  final double pressureSurfaceLevel;
  final double rainIntensity;
  final double sleetIntensity;
  final double snowIntensity;
  final double temperature;
  final double temperatureApparent;
  final int uvHealthConcern;
  final int uvIndex;
  final double visibility;
  final int weatherCode;
  final double windDirection;
  final double windGust;
  final double windSpeed;

  ForecastValues({
    required this.cloudBase,
    required this.cloudCeiling,
    required this.cloudCover,
    required this.dewPoint,
    required this.freezingRainIntensity,
    required this.humidity,
    required this.precipitationProbability,
    required this.pressureSurfaceLevel,
    required this.rainIntensity,
    required this.sleetIntensity,
    required this.snowIntensity,
    required this.temperature,
    required this.temperatureApparent,
    required this.uvHealthConcern,
    required this.uvIndex,
    required this.visibility,
    required this.weatherCode,
    required this.windDirection,
    required this.windGust,
    required this.windSpeed,
  });

  factory ForecastValues.fromJson(Map<String, dynamic> json) {
    return ForecastValues(
      cloudBase: json['cloudBase'],
      cloudCeiling: json['cloudCeiling'],
      cloudCover: json['cloudCover'],
      dewPoint: json['dewPoint'],
      freezingRainIntensity: json['freezingRainIntensity'],
      humidity: json['humidity'],
      precipitationProbability: json['precipitationProbability'],
      pressureSurfaceLevel: json['pressureSurfaceLevel'],
      rainIntensity: json['rainIntensity'],
      sleetIntensity: json['sleetIntensity'],
      snowIntensity: json['snowIntensity'],
      temperature: json['temperature'],
      temperatureApparent: json['temperatureApparent'],
      uvHealthConcern: json['uvHealthConcern'],
      uvIndex: json['uvIndex'],
      visibility: json['visibility'],
      weatherCode: json['weatherCode'],
      windDirection: json['windDirection'],
      windGust: json['windGust'],
      windSpeed: json['windSpeed'],
    );
  }
}

class Location {
  final double lat;
  final double lon;
  final String name;
  final String type;

  Location({required this.lat, required this.lon, required this.name, required this.type});

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      lat: json['lat'],
      lon: json['lon'],
      name: json['name'],
      type: json['type'],
    );
  }
}
