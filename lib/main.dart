

import 'package:flutter/material.dart';
import 'package:weather_forecast_app_for_multiple_place/bhaktapur_weather.dart';
import 'package:weather_forecast_app_for_multiple_place/kathmandu_weather.dart';
import 'package:weather_forecast_app_for_multiple_place/lalitpur_weather.dart';
import 'package:weather_forecast_app_for_multiple_place/main_weather_app.dart';

void main()
{
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      routes: {
        '/': (contex)=>const MainWeather(),
        '/bhaktapur':(context)=>const BhaktapurWeatherForecast(),
        '/kathmandu':(context)=>const KathmanduWeatherForecast(),
        '/lalitpur':(context)=>const LalitpurWeatherForecast(),
      },
      initialRoute: '/',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),

    );
  }
}
