import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_go_india/screens/weather_screen.dart';

import '../WeatherProvider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _controller = TextEditingController();

  String? _errorMessage;

  void _searchWeather() {
    final city = _controller.text;
    if (city.isEmpty) {
      setState(() {
        _errorMessage = 'City name cannot be empty';
      });
    } else {
      setState(() {
        _errorMessage = null;
      });
      Provider.of<WeatherProvider>(context, listen: false).fetchWeather(city);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => WeatherScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isLandscape = size.width > size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Center(child: Text("What's The Weather?")),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: size.height * 0.3,
                child: Card(
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Icon(
                          Icons.wb_sunny,
                          size: isLandscape ? 80 : 100,
                          color: Colors.amber,
                        ),
                        SizedBox(height: 16),
                        Text(
                          'Enter a city to get the weather',
                          style: TextStyle(fontSize: isLandscape ? 16 : 18),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              SizedBox(
                height: size.height * 0.2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 300,
                      height: 50,
                      child: TextField(
                        controller: _controller,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'City Name',
                        ),
                      ),
                    ),
                    if (_errorMessage != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          _errorMessage!,
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              SizedBox(
                height: size.height * 0.1,
                child: Center(
                  child: ElevatedButton(
                    onPressed: _searchWeather,
                    child: Text('Search'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
