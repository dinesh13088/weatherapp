import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_forecast_app_for_multiple_place/additional_information.dart';
import 'package:weather_forecast_app_for_multiple_place/main_card.dart';
import 'package:weather_forecast_app_for_multiple_place/weather_forecast.dart';
import 'package:http/http.dart' as http;

class BhaktapurWeatherForecast extends StatefulWidget {
  const BhaktapurWeatherForecast({super.key});

  @override
  State<BhaktapurWeatherForecast> createState() =>
      _BhaktapurWeatherForecastState();
}

class _BhaktapurWeatherForecastState extends State<BhaktapurWeatherForecast> {
  Future getFutureWeatherData() async {
    try {
      final res = await http.get(Uri.parse(
          'https://api.openweathermap.org/data/2.5/forecast?q=bhaktapur&APPID=7dec4eb1beca78755c9348994f1bd2d5'));
      final data = jsonDecode(res.body);
      if (data['cod'] != '200') {
        throw 'error occured in getting weather data';
      }
      return data;
    } catch (e) {
      return 'unexpected error ';
    }
  }

  @override
  void initState() {
    super.initState();
    getFutureWeatherData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Bhaktapur Weather',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.grey,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushReplacementNamed('/bhaktapur');
              },
              icon: const Icon(Icons.refresh))
        ],
      ),
      backgroundColor: const Color.fromRGBO(179, 229, 252, 1),
      body: FutureBuilder(
        future: getFutureWeatherData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator.adaptive());
          }
          if (snapshot.hasError) {
            Text(snapshot.hasError.toString());
          }
          final data = snapshot.data!;
          final currenttemp = data['list'][0]['main']['temp'];
          final currentWeather = data['list'][0]['weather'][0]['main'];
          final humidity = data['list'][0]['main']['humidity'];
          final pressure = data['list'][0]['main']['pressure'];
          final windSpeed = data['list'][0]['wind']['speed'];

          return Container(
            padding: const EdgeInsets.all(15),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              CurrentWeatherForecast(
                icon: currentWeather == 'Clouds' || currentWeather == 'Rain'
                    ? Icons.cloud
                    : Icons.sunny,
                status: '$currentWeather',
                temp: '$currenttemp',
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Weather Forecast',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 170,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    final hourlyForecast =
                        data['list'][index + 1]['main']['temp'];
                    final hourlyWeather =
                        data['list'][index + 1]['weather'][0]['main'];
                    final time =
                        DateTime.parse(data['list'][index + 1]['dt_txt']);
                    return WeatherForecast(
                        temp: '$hourlyForecast',
                        icon: hourlyWeather == 'Clouds' ||
                                hourlyWeather == 'Rainy'
                            ? Icons.cloud
                            : Icons.sunny,
                        status: DateFormat.Hm().format(time));
                  },
                  itemCount: 5,
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Additional Information',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    AdditonalInformation(
                      data: 'Humidity',
                      icon: Icons.water_drop_rounded,
                      value: '$humidity %',
                    ),
                    AdditonalInformation(
                      data: 'Pressure',
                      icon: Icons.beach_access,
                      value: '$pressure mbr ',
                    ),
                    AdditonalInformation(
                      data: 'Wind Speed',
                      icon: Icons.wind_power,
                      value: '$windSpeed m/s',
                    ),
                  ],
                ),
              )
            ]),
          );
        },
      ),
    );
  }
}
