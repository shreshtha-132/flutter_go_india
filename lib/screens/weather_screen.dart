import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../WeatherProvider.dart';

class WeatherScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final weatherProvider = Provider.of<WeatherProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Center(
            child:
                Text("Weather in ${weatherProvider.lastSearchedCity ?? ''}")),
      ),
      body: Center(
        child: weatherProvider.isLoading
            ? CircularProgressIndicator()
            : weatherProvider.errorMessage != null
                ? Text('Error: ${weatherProvider.errorMessage}')
                : weatherProvider.weatherData == null
                    ? Text('No data available')
                    : Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Card(
                          elevation: 4,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    weatherProvider.lastSearchedCity!,
                                    style: TextStyle(
                                        fontSize: 32,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(width: 10),
                                  Image.network(
                                      weatherProvider.weatherData!['current']
                                          ['weather_icons'][0]),
                                ],
                              ),
                              SizedBox(height: 10),
                              Text(
                                'Temperature: ${weatherProvider.weatherData!['current']['temperature']}°C',
                                style: TextStyle(fontSize: 24),
                              ),
                              SizedBox(height: 10),
                              Text(
                                'Condition: ${weatherProvider.weatherData!['current']['weather_descriptions'][0]}',
                                style: TextStyle(fontSize: 24),
                              ),
                              SizedBox(height: 10),
                              Text(
                                'Humidity: ${weatherProvider.weatherData!['current']['humidity']}%',
                                style: TextStyle(fontSize: 24),
                              ),
                              SizedBox(height: 10),
                              Text(
                                'Wind Speed: ${weatherProvider.weatherData!['current']['wind_speed']} km/h',
                                style: TextStyle(fontSize: 24),
                              ),
                              SizedBox(height: 20),
                              ElevatedButton(
                                onPressed: () {
                                  weatherProvider.fetchWeather(
                                      weatherProvider.lastSearchedCity!);
                                },
                                child: Text('Refresh'),
                              ),
                            ],
                          ),
                        ),
                      ),
      ),
    );
  }
}
