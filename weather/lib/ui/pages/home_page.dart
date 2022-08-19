import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import '../../constants.dart';

class HomePage extends StatelessWidget {
  final cBackgroundStart = cHomeBackgroundSunStart;
  final cBackgroundEnd = cHomeBackgroundSunEnd;

  const HomePage({Key? key}) : super(key: key);

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
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          body: Center(
            child: Padding(
              padding: const EdgeInsets.only(left: 40, right: 40, top: 40, bottom: 4),
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

  Widget _buildBackgroundUI(Widget? child) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[cBackgroundStart, cBackgroundEnd],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: child,
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
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40),
            color: cBackgroundStart,
            boxShadow: <BoxShadow>[
              BoxShadow(
                offset: const Offset(8, 8),
                blurRadius: 8,
                color: Colors.black.withOpacity(0.25),
              ),
              BoxShadow(
                offset: const Offset(-8, -8),
                blurRadius: 8,
                color: Colors.white.withOpacity(0.25),
              ),
            ],
          ),
          child: Lottie.asset("assets/lottie/sun.json"),
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
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        gradient: LinearGradient(
          colors: <Color>[cBackgroundStart, cBackgroundEnd],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            offset: const Offset(8, 8),
            blurRadius: 8,
            color: Colors.black.withOpacity(0.25),
          ),
          BoxShadow(
            offset: const Offset(-8, -8),
            blurRadius: 8,
            color: Colors.white.withOpacity(0.25),
          ),
        ],
      ),
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
