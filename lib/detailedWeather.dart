import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DetailedPage extends StatefulWidget {
  final Map<String, dynamic> weatherData;

  const DetailedPage({required this.weatherData});

  @override
  State<DetailedPage> createState() => _DetailedPageState();
}

class _DetailedPageState extends State<DetailedPage> {

  Widget _buildWeatherInfo(String label, String value) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: TextStyle(fontSize: 16),
            ),
            Text(
              value,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather'),
      ),
      body: Container(
        decoration: BoxDecoration(
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
              _buildWeatherInfo('Temperature', '${widget.weatherData['values']['temperature']}°C'),
              _buildWeatherInfo('Humidity', '${widget.weatherData['values']['humidity']}%'),
              _buildWeatherInfo('Pressure', '${widget.weatherData['values']['pressureSurfaceLevel']} hPa'),
              _buildWeatherInfo('Wind Speed', '${widget.weatherData['values']['windSpeed']} m/s'),
              _buildWeatherInfo('Visibility', '${widget.weatherData['values']['visibility']} km'),
              _buildWeatherInfo('Weather Code', '${widget.weatherData['values']['weatherCode']}'),
              _buildWeatherInfo('UV Index', '${widget.weatherData['values']['uvIndex']}'),
            ],
          ),
        ),
      ),
    );
  }
}
