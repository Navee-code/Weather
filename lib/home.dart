import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:shimmer/shimmer.dart';

import 'displaytimezone.dart';


class WeatherScreen extends StatefulWidget {
  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  dynamic _weatherData;
  bool noData = false;
  TextEditingController _searchController = TextEditingController();

  checkInternetAvailability() async{
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        fetchWeatherForecast('Bangalore');
      }
    } on SocketException catch (_) {
      performSnackBar();

    }
  }
  performSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text("No internet connection !"),
      backgroundColor: Color(0xFF77A96B),
      elevation: 10,
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.all(0),
    ));
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkInternetAvailability();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 5, 10, 5), // Adjust padding here
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search location...',
                prefixIcon: Icon(Icons.search, size: 18), // Adjust icon size here
                suffixIcon: IconButton(
                  icon: Icon(Icons.done, size: 18), // Adjust icon size here
                  onPressed: () async {
                    setState(() async {
                      fetchWeatherForecast(_searchController.text);
                    });
                  },
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              style: TextStyle(fontSize: 12.0), // Adjust font size here
            ),
          ),
          Visibility(visible:noData,child: Padding(padding: EdgeInsets.all(16),child: Text('No data available'))),
          Visibility(
            visible: !noData,
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Center(
                child: _weatherData == null
                    ?_buildShimmerEffect()
                    :  Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DisplayCountryWeather(
                              weatherData: _weatherData['timelines'],
                            ),
                          ),
                        );
                      },
                      child: Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15), // Set border radius
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            image: const DecorationImage(
                              image: AssetImage('assets/images/blue_sky.jpg'),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  ' ${_weatherData['location']['name']}',
                                  style: const TextStyle(fontSize: 18, color: Colors.white),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  'Latitude:  ${_weatherData['location']['lat']}',
                                  style: const TextStyle(fontSize: 16, color: Colors.white),
                                ),
                                Text(
                                  'Longitude: ${_weatherData['location']['lon']}',
                                  style: const TextStyle(fontSize: 16, color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )

                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildShimmerEffect() {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(10, 5, 10, 5),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.grey, // Placeholder color
            ),
            width: double.infinity,
            height: 100, // Adjust height as needed
          ),
        ),
      ),
    );
  }



  void fetchWeatherForecast(String location) async {
    const String apiKey = 'KWMreg4pTcPeYwV28WVKK4tlUXMRkszi';
    final Uri uri = Uri.parse('https://api.tomorrow.io/v4/weather/forecast?location=$location&apikey=$apiKey');
    setState(() {
      noData = false;
      _weatherData = null;
    });
    print("FOrecast");
    try {
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        print("FOrecast  sucesss");
        final Map<String, dynamic> data = jsonDecode(response.body);
        setState(() {
          _weatherData = data;
        });
      } else {
        setState(() {
          noData = true;
        });
        print("FOrecast  else");
        throw Exception('Failed with status code: ${response.statusCode}');
      }
    } catch (e) {
      setState(() {
        noData = true;
      });
      print("FOrecast  Excep");
      throw Exception('Request failed: $e');
    }
  }
}


