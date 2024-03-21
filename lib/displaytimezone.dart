import 'package:flutter/material.dart';
import 'package:healthflex/detailedWeather.dart';

class DisplayCountryWeather extends StatefulWidget {
  final Map<String, dynamic> weatherData;

  const DisplayCountryWeather({required this.weatherData});

  @override
  State<DisplayCountryWeather> createState() => _DisplayCountryWeatherState();
}

class _DisplayCountryWeatherState extends State<DisplayCountryWeather> {
  Widget _buildWeatherCard(int index, String  freq) {
    var data = widget.weatherData[freq][index];
    DateTime dateTime = DateTime.parse(widget.weatherData[freq][index]['time']);
    String date = "${_twoDigits(dateTime.day)}-${_twoDigits(dateTime.month)}-${dateTime.year}";
    String time = "${_twoDigits(dateTime.hour)}:${_twoDigits(dateTime.minute)}:${_twoDigits(dateTime.second)}";

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailedPage(
              weatherData: widget.weatherData[freq][index ],
            ),
          ),
        );
      },
      child: Card(
          elevation: 4,
          child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      'Temp: ${data['values']['temperature']}°C'),
                  SizedBox(height: 10,),
                  SizedBox(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [Text(time), Text(date)],
                    ),
                  ),
                ],
              ))),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Weather'),
          bottom: const TabBar(
            tabs: [
              Tab(text:'Minutes'),
              Tab(text:'Hourly'),
              Tab(text:'Daily'),
            ],
          ),
        ),
        body: Container(
          decoration: BoxDecoration(
            image: const DecorationImage(
              image: AssetImage('assets/images/blue_sky.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: TabBarView(
            children: [
              SafeArea(
                top: true,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: widget.weatherData['minutely'].length,
                    itemBuilder: (BuildContext context, int index) {
                      return _buildWeatherCard(index,'minutely');
                    },
                  ),
                ),
              ),
              SafeArea(
                top: true,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: widget.weatherData['hourly'].length,
                    itemBuilder: (BuildContext context, int index) {
                      return _buildWeatherCard(index,'hourly');
                    },
                  ),
                ),
              ),
              SafeArea(
                top: true,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: widget.weatherData['daily'].length,
                    itemBuilder: (BuildContext context, int index) {
                      return _buildWeatherCard(index,'daily');
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void timeStamp(String timestamp) {
    DateTime dateTime = DateTime.parse(timestamp);
    String date = "${dateTime.year}-${_twoDigits(dateTime.month)}-${_twoDigits(dateTime.day)}";
    String time = "${_twoDigits(dateTime.hour)}:${_twoDigits(dateTime.minute)}:${_twoDigits(dateTime.second)}";
    print("Date: $date");
    print("Time: $time");
  }

  String _twoDigits(int n) {
    if (n >= 10) return "$n";
    return "0$n";
  }

}



