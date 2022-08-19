import 'package:flutter/material.dart';

enum WeatherState {
  sun,
  rain,
  thunderstorm,
  fog,
  snow;
}

class WeatherInfo {
  String name;
  Widget icon;
  String data;

  WeatherInfo({
    required this.name,
    required this.icon,
    required this.data,
  });
}
