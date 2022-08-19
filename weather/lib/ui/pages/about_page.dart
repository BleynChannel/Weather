import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../constants.dart';
import '../widgets/neomorphic_container.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[cAboutBackgroundStart, cAboutBackgroundEnd],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: cAboutAppBar,
          title: const Text("О нас"),
          foregroundColor: Colors.black,
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.only(
                left: 40, right: 40, top: 100, bottom: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                _buildLogoUI(context),
                Column(
                  children: <Widget>[
                    _buildInfoUI(context),
                    const SizedBox(height: 20),
                    _buildFooterUI(context),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLogoUI(BuildContext context) {
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
          gradient: const LinearGradient(
            colors: [cAboutLogoStart, cAboutLogoEnd],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: 40,
          blur: 8,
          distance: 8,
          intensity: 0.25,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: SvgPicture.asset("assets/image/logo.svg"),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoUI(BuildContext context) {
    TextStyle textStyle = TextStyle(
      fontSize: 20,
      color: Colors.black.withOpacity(0.75),
      fontWeight: FontWeight.normal,
      height: 1,
    );

    return NeomorphicContainer(
      gradient: const LinearGradient(
        colors: [cAboutBackgroundStart, cAboutBackgroundEnd],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: 30,
      blur: 8,
      distance: 8,
      intensity: 0.25,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: RichText(
          text: TextSpan(
            text: "Weather",
            style:
                textStyle.merge(const TextStyle(fontWeight: FontWeight.bold)),
            children: [
              TextSpan(
                text:
                    " - это приложение для отображения данных о погоде для определенного города",
                style: textStyle,
              ),
            ],
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _buildFooterUI(BuildContext context) {
    TextStyle textStyle = TextStyle(
      fontSize: 14,
      color: Colors.black.withOpacity(0.60),
      fontWeight: FontWeight.normal,
      height: 1,
    );

    return RichText(
      text: TextSpan(
        text: "Приложение сделал",
        style: textStyle,
        children: [
          TextSpan(
            text: "\nГоловин Владислав",
            style: textStyle.merge(
                const TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
          )
        ],
      ),
      textAlign: TextAlign.center,
    );
  }
}
