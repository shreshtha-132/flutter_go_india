import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class WeatherProvider with ChangeNotifier {
  final String apiKey = dotenv.env['API_KEY'] ?? '';
  // final String apiKey = 'bf37ed037ee6f380172b8531dab4154f';
  final String baseUrl = 'http://api.weatherstack.com/current';

  Map<String, dynamic>? _weatherData;
  String? _errorMessage;
  bool _isLoading = false;
  String? _lastSearchedCity;

  Map<String, dynamic>? get weatherData => _weatherData;
  String? get errorMessage => _errorMessage;
  bool get isLoading => _isLoading;
  String? get lastSearchedCity => _lastSearchedCity;

  Future<void> fetchWeather(String city) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response =
          await http.get(Uri.parse('$baseUrl?access_key=$apiKey&query=$city'));
      if (response.statusCode == 200) {
        _weatherData = json.decode(response.body);
        _errorMessage = null;
        _lastSearchedCity = city;
        saveLastSearchedCity(city);
      } else {
        _errorMessage = 'Failed to load weather data';
      }
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> saveLastSearchedCity(String city) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('lastSearchedCity', city);
  }

  Future<void> loadLastSearchedCity() async {
    final prefs = await SharedPreferences.getInstance();
    _lastSearchedCity = prefs.getString('lastSearchedCity');
    if (_lastSearchedCity != null) {
      fetchWeather(_lastSearchedCity!);
    }
  }
}
