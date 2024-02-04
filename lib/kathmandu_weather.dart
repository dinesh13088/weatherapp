import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_forecast_app_for_multiple_place/additional_information.dart';
import 'package:weather_forecast_app_for_multiple_place/main_card.dart';
import 'package:weather_forecast_app_for_multiple_place/weather_forecast.dart';
import 'package:http/http.dart' as http;

class KathmanduWeatherForecast extends StatefulWidget {
  const KathmanduWeatherForecast({super.key});

  @override
  State<KathmanduWeatherForecast> createState() =>
      _KathmanduWeatherForecastState();
}

class _KathmanduWeatherForecastState extends State<KathmanduWeatherForecast> {
  Future getFutureData() async {
    try {
      final res = await http.get(Uri.parse(
          'https://api.openweathermap.org/data/2.5/forecast?q=kathmandu&APPID=7dec4eb1beca78755c9348994f1bd2d5'));
      final data = jsonDecode(res.body);
      if (data['cod'] != '200') {
        throw 'unexpected error';
      }
      return data;
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  void initState() {
    super.initState();
    getFutureData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(179, 229, 252, 1),
      appBar: AppBar(
        title: const Text(
          'Kathmandu Weather',
        ),
        centerTitle: true,
        backgroundColor: Colors.grey,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushReplacementNamed('/kathmandu');
              },
              icon: const Icon(Icons.refresh))
        ],
      ),
      body: FutureBuilder(
        future: getFutureData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator.adaptive());
          }
          if (snapshot.hasError) {
            Text(snapshot.hasError.toString());
          }
          final data = snapshot.data!;
          final currentTemp = data['list'][0]['main']['temp'];
          final currentWeather = data['list'][0]['weather'][0]['main'];
          final humidity = data['list'][0]['main']['humidity'];
          final pressure = data['list'][0]['main']['pressure'];
          final windSpeed = data['list'][0]['wind']['speed'];

          return SafeArea(
              child: Container(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
        
              CurrentWeatherForecast(
                  temp: '$currentTemp',
                  status: '$currentWeather',
                  icon: currentWeather == 'Clouds' || currentWeather == 'Rain'
                      ? Icons.cloud
                      : Icons.sunny),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Weather Forecast',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 165,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (contex, index) {
                    final hourlytemp = data['list'][index + 1]['main']['temp'];
                    final hourlyWeather =
                        data['list'][index + 1]['weather'][0]['main'];
                    final hourlytime =
                        DateTime.parse(data['list'][index + 1]['dt_txt']);
                    return WeatherForecast(
                        temp: '$hourlytemp',
                        icon:
                            hourlyWeather == 'Clouds' || hourlyWeather == 'Rain'
                                ? Icons.cloud
                                : Icons.sunny,
                        status: DateFormat.Hm().format(hourlytime));
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
                        icon: Icons.water_drop,
                        value: '$humidity %'),
                    AdditonalInformation(
                        data: 'Pressure',
                        icon: Icons.beach_access,
                        value: '$pressure mbar'),
                    AdditonalInformation(
                        data: 'Wind Speed',
                        icon: Icons.wind_power_sharp,
                        value: '$windSpeed m/s'),
                  ],
                ),
              )
            ]),
          ));
        },
      ),
    );
  }
}
