import 'package:requests/requests.dart';

import 'utils.dart';

class WeatherParser {
  static Map<String, int> cityList = getCityList();

  static const _apiKey = "b5dd10950dd8869fcf6d401041197b19";
  static const _urlGetWeather =
      "http://api.openweathermap.org/data/2.5/weather";

  static const List<String> _weatherStateGroupSun = [
    "01d",
    "01n",
    "02d",
    "02n",
    "03d",
    "03n",
    "04d",
    "04n",
  ];
  static const List<String> _weatherStateGroupRain = ["09d", "10d"];
  static const List<String> _weatherStateGroupThunderstorm = ["11d"];
  static const List<String> _weatherStateGroupFog = ["50d"];
  static const List<String> _weatherStateGroupSnow = ["13d"];

  Future<WeatherInfo?> parse(String city) async {
    if (!cityList.containsKey(city)) {
      return null;
    }

    //Получаем данные о погоде
    var r = await Requests.get(_urlGetWeather, queryParameters: {
      'id': cityList[city],
      'units': 'metric',
      'APPID': _apiKey,
    });
    r.raiseForStatus();
    var jsonData = r.json();

    //Сериализуем данные

    String dataState = jsonData['weather'][0]['icon'];
    WeatherState state;

    if (_weatherStateGroupSun.contains(dataState)) {
      state = WeatherState.sun;
    } else if (_weatherStateGroupRain.contains(dataState)) {
      state = WeatherState.rain;
    } else if (_weatherStateGroupThunderstorm.contains(dataState)) {
      state = WeatherState.thunderstorm;
    } else if (_weatherStateGroupFog.contains(dataState)) {
      state = WeatherState.fog;
    } else if (_weatherStateGroupSnow.contains(dataState)) {
      state = WeatherState.snow;
    } else {
      state = WeatherState.sun;
    }

    int dataWindDirection = jsonData['wind']['deg'];
    String windDirection;

    if (dataWindDirection >= 337.5 && dataWindDirection <= 360 ||
        dataWindDirection < 22.5) {
      windDirection = "С";
    } else if (dataWindDirection >= 22.5 && dataWindDirection < 67.5) {
      windDirection = "СВ";
    } else if (dataWindDirection >= 67.5 && dataWindDirection < 112.5) {
      windDirection = "В";
    } else if (dataWindDirection >= 112.5 && dataWindDirection < 157.5) {
      windDirection = "ЮВ";
    } else if (dataWindDirection >= 157.5 && dataWindDirection < 202.5) {
      windDirection = "Ю";
    } else if (dataWindDirection >= 202.5 && dataWindDirection < 247.5) {
      windDirection = "ЮЗ";
    } else if (dataWindDirection >= 247.5 && dataWindDirection < 292.5) {
      windDirection = "З";
    } else {
      windDirection = "СЗ";
    }

    int temperature = jsonData['main']['temp'] is int
        ? jsonData['main']['temp']
        : jsonData['main']['temp'].toInt();
    double windSpeed = jsonData['wind']['speed'] is int
        ? jsonData['wind']['speed'].toDouble()
        : jsonData['wind']['speed'];

    return WeatherInfo(
      temperature: temperature,
      state: state,
      windSpeed: windSpeed,
      windDirection: windDirection,
      humidity: jsonData['main']['humidity'],
      pressure: jsonData['main']['pressure'],
    );
  }

  static Map<String, int> getCityList() {
    //TODO: Сделать подгрузку данных через Cloud Firestore
    return {
      "Москва": 524901,
      "Санкт-Петербург": 498817,
      "Казань": 551487,
      "Нижний Новгород": 520555,
      "Екатеринбург": 1486209,
      "Калининград": 554234,
      "Владимир": 473247,
      "Архангельск": 581049,
      "Сочи": 491422,
      "Ростов-на-Дону": 501175,
      "Красноярск": 1502026,
      "Волгоград": 472757,
      "Пятигорск": 503550,
      "Йошкар-Ола": 466806,
      "Самара": 499099,
      "Иркутск": 2023469,
      "Ярославль": 468902,
      "Ульяновск": 479123,
      "Псков": 504341,
      "Воронеж": 472045,
      "Уфа": 479561,
      "Стерлитамак": 487495,
    };
  }
}
