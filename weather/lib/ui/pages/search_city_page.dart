import 'package:flutter/material.dart';

import '../../src/weather_parser.dart';
import '../widgets/neomorphic_container.dart';

class SearchCityPage extends StatefulWidget {
  final void Function(String) onChangeCity;

  const SearchCityPage({Key? key, required this.onChangeCity})
      : super(key: key);

  @override
  _SearchCityPageState createState() => _SearchCityPageState();
}

class _SearchCityPageState extends State<SearchCityPage> {
  static const commonTextStyle =
      TextStyle(fontSize: 16, fontWeight: FontWeight.w600);

  List<String> fillterCityList = [];

  void searchCity(String value) {
    setState(() {
      fillterCityList = WeatherParser.cityList.entries
          .where((element) => element.key.contains(value))
          .map((element) => element.key)
          .toList();
    });
  }

  void choiseSearchCity(String city) {
    widget.onChangeCity(city);
    Navigator.of(context).pop();
  }

  _SearchCityPageState() {
    fillterCityList =
        WeatherParser.cityList.entries.map((element) => element.key).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            title: _buildSearchUI(context),
            pinned: true,
            forceElevated: innerBoxIsScrolled,
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white,
            elevation: 0,
          ),
        ],
        body: ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          itemBuilder: (context, index) =>
              _buildCityItemUI(context, fillterCityList[index]),
          separatorBuilder: (context, index) => const SizedBox(
            height: 10,
          ),
          itemCount: fillterCityList.length,
        ),
      ),
    );
  }

  Widget _buildSearchUI(BuildContext context) {
    return SizedBox(
      height: 40,
      child: NeomorphicContainer(
        color: Colors.white,
        borderRadius: 30,
        border: Border.all(color: Colors.grey.shade400),
        blur: 8,
        distance: 4,
        intensity: 0.2,
        child: Padding(
          padding:
              const EdgeInsets.only(left: 16, right: 12, top: 8, bottom: 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: TextField(
                  autofocus: true,
                  textInputAction: TextInputAction.continueAction,
                  maxLines: 1,
                  decoration: const InputDecoration.collapsed(
                    hintText: "Введите ваш город",
                  ),
                  style: commonTextStyle,
                  onChanged: searchCity,
                ),
              ),
              const SizedBox(width: 8),
              const Icon(Icons.search, color: Colors.black),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCityItemUI(BuildContext context, String cityName) {
    ShapeBorder shapeBorder = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(24),
      side: BorderSide(color: Colors.grey.shade400),
    );

    return Material(
      color: Colors.white,
      shadowColor: Colors.black,
      elevation: 4,
      shape: shapeBorder,
      child: ListTile(
        visualDensity:
            const VisualDensity(vertical: VisualDensity.minimumDensity),
        title: Text(cityName, style: commonTextStyle),
        shape: shapeBorder,
        onTap: () => choiseSearchCity(cityName),
      ),
    );
  }
}
