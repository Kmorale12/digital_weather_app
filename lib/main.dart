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
  String _cityName =
      ''; //creates variables for weather conditions and city name
  List<Map<String, String>> _sevenDayForecast = [];

  void getWeather() {
    //function to get weather
    final cityName = _cityController.text;
    final random = Random();
    final temperature = (50 + random.nextInt(51))
        .toString(); // Generates a random temperature between 50 and 100
    final weatherConditions = ['Cloudy', 'Sunny', 'Rainy'];
    final weatherCondition =
        weatherConditions[random.nextInt(weatherConditions.length)];

    setState(() {
      //updates the state of the variables
      _cityName = cityName;
      _temperature = temperature;
      _weatherCondition = weatherCondition;
    });
  }

  void getSevenDayForecast() {
    //function to get 7 day forecast, uses random generator
    final random = Random();
    final weatherConditions = ['Cloudy', 'Sunny', 'Rainy'];
    List<Map<String, String>> forecast = [];

    for (int i = 0; i < 7; i++) {
      final temperature = (50 + random.nextInt(51))
          .toString(); // Generates a random temperature between 50 and 100
      final weatherCondition =
          weatherConditions[random.nextInt(weatherConditions.length)];
      forecast.add({
        'day': 'Day ${i + 1}',
        'temperature': temperature,
        'condition': weatherCondition,
      });
    }

    setState(() {
      _sevenDayForecast = forecast;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/cloudy.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
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
                ElevatedButton(
                  onPressed:
                      getSevenDayForecast, // Calls the getSevenDayForecast function
                  child: const Text('Get 7-Day Forecast'),
                ),
                const SizedBox(height: 30),
                Text('City: $_cityName'),
                Text('Temperature: $_temperature°F'),
                Text('Weather Condition: $_weatherCondition'),
                const SizedBox(height: 30),
                if (_sevenDayForecast.isNotEmpty)
                  SingleChildScrollView(
                    //scrollable view for 7 day forecast
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: _sevenDayForecast.map((dayForecast) {
                        return Container(
                          margin: const EdgeInsets.all(4.0),
                          padding: const EdgeInsets.all(
                              8.0), //creates a container for each day forecast
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.8),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Column(
                            children: [
                              Text(dayForecast['day']!),
                              Text('Temp: ${dayForecast['temperature']}°F'),
                              Text('Cond: ${dayForecast['condition']}'),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
