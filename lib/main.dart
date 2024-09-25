import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const MyHomePage(title: 'Weather App'),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.blue,
        ).copyWith(
          inversePrimary: Colors.white,
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _cityController = TextEditingController();
  String _temperature = '';
  String _weatherCondition = '';
  String _cityName = '';

  void getWeather() {
    final cityName = _cityController.text;
    final random = Random();
    final temperature = (50 + random.nextInt(51))
        .toString(); // Generates a random temperature between 50 and 100
    final weatherConditions = ['Cloudy', 'Sunny', 'Rainy'];
    final weatherCondition =
        weatherConditions[random.nextInt(weatherConditions.length)];

    setState(() {
      _cityName = cityName;
      _temperature = temperature;
      _weatherCondition = weatherCondition;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _cityController,
              decoration: const InputDecoration(
                labelText: 'Enter City',
                hintText: 'Enter city name',
              ),
            ),
            ElevatedButton(
              onPressed: getWeather, // Calls the getWeather function
              child: const Text('Get Weather'),
            ),
            const SizedBox(height: 30),
            Text('City: $_cityName'),
            Text('Temperature: $_temperature°F'),
            Text('Weather Condition: $_weatherCondition'),
          ],
        ),
      ),
    );
  }
}
