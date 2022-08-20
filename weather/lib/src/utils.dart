enum WeatherState {
  sun,
  rain,
  thunderstorm,
  fog,
  snow;
}

class WeatherInfo {
  final int temperature;
  final WeatherState state;
  final double windSpeed;
  final String windDirection;
  final int humidity;
  final int pressure;

  WeatherInfo({
    required this.temperature,
    required this.state,
    required this.windSpeed,
    required this.windDirection,
    required this.humidity,
    required this.pressure,
  });
}

// class WeatherInfo {
//   String name;
//   Widget icon;
//   String data;

//   WeatherInfo({
//     required this.name,
//     required this.icon,
//     required this.data,
//   });
// }
