import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../src/utils.dart';
import '../widgets/blur_circle.dart';
import '../widgets/neomorphic_container.dart';
import '../../constants.dart';
import 'about_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const _durationAnimationFade = Duration(milliseconds: 500);
  static const _curveAnimtionFade = Curves.easeIn;
  static final List<WeatherInfo> _weatherInfo = [
    WeatherInfo(
      name: "Ветер",
      icon: const FaIcon(FontAwesomeIcons.wind, color: Colors.white, size: 22),
      data: "1.3 м/с, СВ",
    ),
    WeatherInfo(
      name: "Влажность",
      icon:
          const FaIcon(FontAwesomeIcons.droplet, color: Colors.white, size: 22),
      data: "45%",
    ),
    WeatherInfo(
      name: "Давление",
      icon: const FaIcon(FontAwesomeIcons.gaugeHigh,
          color: Colors.white, size: 22),
      data: "567 мм рт. ст.",
    ),
  ];

  WeatherState _weatherState = WeatherState.sun;
  Color _cBackgroundStart = cHomeBackgroundSunStart;
  Color _cBackgroundEnd = cHomeBackgroundSunEnd;

  void changeWeatherState() {
    _weatherState = WeatherState
        .values[(_weatherState.index + 1) % WeatherState.values.length];

    switch (_weatherState) {
      case WeatherState.sun:
        _cBackgroundStart = cHomeBackgroundSunStart;
        _cBackgroundEnd = cHomeBackgroundSunEnd;
        break;
      case WeatherState.rain:
        _cBackgroundStart = cHomeBackgroundRainStart;
        _cBackgroundEnd = cHomeBackgroundRainEnd;
        break;
      case WeatherState.thunderstorm:
        _cBackgroundStart = cHomeBackgroundThunderstormStart;
        _cBackgroundEnd = cHomeBackgroundThunderstormEnd;
        break;
      case WeatherState.fog:
        _cBackgroundStart = cHomeBackgroundFogStart;
        _cBackgroundEnd = cHomeBackgroundFogEnd;
        break;
      case WeatherState.snow:
        _cBackgroundStart = cHomeBackgroundSnowStart;
        _cBackgroundEnd = cHomeBackgroundSnowEnd;
        break;
    }
  }

  void onMenuSelected(String value) {
    if (value == "О нас") {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const AboutPage(),
        ),
      );
    } else {
      setState(() {
        changeWeatherState();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return _buildBackgroundUI(
      SafeArea(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            titleSpacing: 0,
            title: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(child: Container()),
                Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: GestureDetector(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: const [
                        Padding(
                          padding: EdgeInsets.only(bottom: 1),
                          child: Text("Стерлитамак"),
                        ),
                        Icon(Icons.expand_more),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      PopupMenuButton<String>(
                        icon: const Icon(Icons.more_vert),
                        tooltip: "Меню информации",
                        itemBuilder: (context) => ["О нас", "Сменить погоду"]
                            .map<PopupMenuItem<String>>(
                                (item) => PopupMenuItem<String>(
                                      value: item,
                                      child: Text(item),
                                    ))
                            .toList(),
                        onSelected: onMenuSelected,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          body: Center(
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 40, right: 40, top: 40, bottom: 4),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      _buildWeatherIconUI(context),
                      const SizedBox(height: 20),
                      _buildTemperatureInfoUI(context),
                    ],
                  ),
                  Column(
                    children: [
                      _buildWeatherInfoUI(context),
                      const SizedBox(height: 30),
                      _buildFooterUI(context),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBackgroundUI(Widget child) {
    return AnimatedContainer(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [_cBackgroundStart, _cBackgroundEnd],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      duration: _durationAnimationFade,
      curve: _curveAnimtionFade,
      child: Stack(
        children: [
          const Positioned(
            top: 16,
            left: -120,
            child: BlurCircle(
              color: cHomeBackgroundBlurCircle1,
              size: 240,
              blurRadius: 140,
            ),
          ),
          const Positioned(
            bottom: 150,
            right: -60,
            child: BlurCircle(
              color: cHomeBackgroundBlurCircle2,
              size: 160,
              blurRadius: 100,
            ),
          ),
          child,
        ],
      ),
    );
  }

  Widget _buildWeatherIconUI(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        minWidth: 100,
        minHeight: 100,
        maxWidth: 200,
        maxHeight: 200,
      ),
      child: AspectRatio(
        aspectRatio: 1,
        child: NeomorphicContainer(
          color: _cBackgroundStart,
          borderRadius: 40,
          blur: 8,
          distance: 8,
          intensity: 0.25,
          duration: _durationAnimationFade,
          curve: _curveAnimtionFade,
          child: Stack(
            children: WeatherState.values.map((state) {
              Widget child;

              switch (state) {
                case WeatherState.sun:
                  child = lottieSun;
                  break;
                case WeatherState.rain:
                  child = lottieRain;
                  break;
                case WeatherState.thunderstorm:
                  child = lottieThunderstorm;
                  break;
                case WeatherState.fog:
                  child = lottieFog;
                  break;
                case WeatherState.snow:
                  child = lottieSnow;
                  break;
              }

              return Center(
                child: AnimatedOpacity(
                  opacity: state == _weatherState ? 1 : 0,
                  duration: _durationAnimationFade,
                  curve: _curveAnimtionFade,
                  child: child,
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  Widget _buildTemperatureInfoUI(BuildContext context) {
    return Column(
      children: [
        const Text(
          "24°C",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 40,
          ),
        ),
        Text(
          "Ясно",
          style: TextStyle(
            color: Colors.white.withOpacity(0.75),
            fontSize: 26,
          ),
        ),
      ],
    );
  }

  Widget _buildWeatherInfoUI(BuildContext context) {
    return NeomorphicContainer(
      gradient: LinearGradient(
        colors: [_cBackgroundStart, _cBackgroundEnd],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: 30,
      blur: 8,
      distance: 8,
      intensity: 0.25,
      duration: _durationAnimationFade,
      curve: _curveAnimtionFade,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: _weatherInfo.map((item) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    item.icon,
                    const SizedBox(width: 4),
                    Text(
                      item.data,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 24),
                    ),
                  ],
                ),
                Text(
                  item.name,
                  style: TextStyle(
                      color: Colors.white.withOpacity(0.8), fontSize: 18),
                )
              ],
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildFooterUI(BuildContext context) {
    TextStyle textStyle = TextStyle(
      fontSize: 12,
      color: Colors.white.withOpacity(0.6),
    );

    return RichText(
      text: TextSpan(
        text: "Данные предоставлены ",
        style: textStyle,
        children: [
          TextSpan(
            text: "OpenWeather",
            style:
                textStyle.merge(const TextStyle(fontWeight: FontWeight.bold)),
          ),
          TextSpan(
            text: "\n©2022 Golovin Vladislav | Все права защищены",
            style: textStyle,
          ),
        ],
      ),
      textAlign: TextAlign.center,
    );
  }
}
