import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../src/utils.dart';
import '../widgets/blur_circle.dart';
import '../widgets/neomorphic_container.dart';
import '../../constants.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const durationAnimationFade = Duration(milliseconds: 500);
  static const curveAnimtionFade = Curves.easeIn;

  WeatherState weatherState = WeatherState.sun;
  Color cBackgroundStart = cHomeBackgroundSunStart;
  Color cBackgroundEnd = cHomeBackgroundSunEnd;

  void changeWeatherState() {
    weatherState = WeatherState
        .values[(weatherState.index + 1) % WeatherState.values.length];

    switch (weatherState) {
      case WeatherState.sun:
        cBackgroundStart = cHomeBackgroundSunStart;
        cBackgroundEnd = cHomeBackgroundSunEnd;
        break;
      case WeatherState.rain:
        cBackgroundStart = cHomeBackgroundRainStart;
        cBackgroundEnd = cHomeBackgroundRainEnd;
        break;
      case WeatherState.thunderstorm:
        cBackgroundStart = cHomeBackgroundThunderstormStart;
        cBackgroundEnd = cHomeBackgroundThunderstormEnd;
        break;
      case WeatherState.fog:
        cBackgroundStart = cHomeBackgroundFogStart;
        cBackgroundEnd = cHomeBackgroundFogEnd;
        break;
      case WeatherState.snow:
        cBackgroundStart = cHomeBackgroundSnowStart;
        cBackgroundEnd = cHomeBackgroundSnowEnd;
        break;
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
                      children: const <Widget>[
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
                    children: <Widget>[
                      IconButton(
                        icon: const Icon(Icons.more_vert),
                        tooltip: "Меню информации",
                        onPressed: () => setState(() {
                          changeWeatherState();
                        }),
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
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      _buildWeatherIconUI(context),
                      const SizedBox(height: 20),
                      _buildTemperatureInfoUI(context),
                    ],
                  ),
                  Column(
                    children: <Widget>[
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
          colors: <Color>[cBackgroundStart, cBackgroundEnd],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      duration: durationAnimationFade,
      curve: curveAnimtionFade,
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
          color: cBackgroundStart,
          borderRadius: 40,
          blur: 8,
          distance: 8,
          intensity: 0.25,
          duration: durationAnimationFade,
          curve: curveAnimtionFade,
          child: Stack(
            children: WeatherState.values.map<Widget>((state) {
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
                  opacity: state == weatherState ? 1 : 0,
                  duration: durationAnimationFade,
                  curve: curveAnimtionFade,
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
      children: <Widget>[
        Text(
          "24°C",
          style: GoogleFonts.roboto(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 40,
          ),
        ),
        Text(
          "Ясно",
          style: GoogleFonts.roboto(
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
        colors: <Color>[cBackgroundStart, cBackgroundEnd],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: 30,
      blur: 8,
      distance: 8,
      intensity: 0.25,
      duration: durationAnimationFade,
      curve: curveAnimtionFade,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const FaIcon(FontAwesomeIcons.wind,
                        color: Colors.white, size: 22),
                    const SizedBox(width: 4),
                    Text(
                      "1.3 м/с, СВ",
                      style: GoogleFonts.roboto(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 24),
                    ),
                  ],
                ),
                Text(
                  "Ветер",
                  style: GoogleFonts.roboto(
                      color: Colors.white.withOpacity(0.8), fontSize: 18),
                )
              ],
            ),
            const SizedBox(height: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const FaIcon(FontAwesomeIcons.droplet,
                        color: Colors.white, size: 22),
                    const SizedBox(width: 4),
                    Text(
                      "45%",
                      style: GoogleFonts.roboto(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 24),
                    ),
                  ],
                ),
                Text(
                  "Влажность",
                  style: GoogleFonts.roboto(
                      color: Colors.white.withOpacity(0.8), fontSize: 18),
                )
              ],
            ),
            const SizedBox(height: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const FaIcon(FontAwesomeIcons.gaugeHigh,
                        color: Colors.white, size: 22),
                    const SizedBox(width: 4),
                    Text(
                      "567 мм рт. ст.",
                      style: GoogleFonts.roboto(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 24),
                    ),
                  ],
                ),
                Text(
                  "Давление",
                  style: GoogleFonts.roboto(
                      color: Colors.white.withOpacity(0.8), fontSize: 18),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFooterUI(BuildContext context) {
    TextStyle textStyle = GoogleFonts.roboto(
      fontSize: 12,
      color: Colors.white.withOpacity(0.6),
    );

    return RichText(
      text: TextSpan(
        text: "Данные предоставлены ",
        style: textStyle,
        children: <InlineSpan>[
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
