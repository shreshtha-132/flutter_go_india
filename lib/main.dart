import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/home_screen.dart';
import 'screens/weather_screen.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'WeatherProvider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await dotenv.load(fileName: ".env");
    // print('API_KEY: ${dotenv.env['API_KEY']}');
  } catch (e) {
    print('Error loading .env file: $e');
  }

  runApp(
    ChangeNotifierProvider(
      create: (_) => WeatherProvider()..loadLastSearchedCity(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "What's the Weather ?",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
