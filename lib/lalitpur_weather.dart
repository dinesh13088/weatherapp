import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_forecast_app_for_multiple_place/additional_information.dart';
import 'package:weather_forecast_app_for_multiple_place/main_card.dart';
import 'package:weather_forecast_app_for_multiple_place/weather_forecast.dart';
import 'package:http/http.dart' as http;
import 'package:dynamic_weather_icons/dynamic_weather_icons.dart';


class LalitpurWeatherForecast extends StatefulWidget {
  const LalitpurWeatherForecast({super.key});

  @override
  State<LalitpurWeatherForecast> createState() =>
      _LalitpurWeatherForecastState();
}

class _LalitpurWeatherForecastState extends State<LalitpurWeatherForecast> {
  Future<Map<String,dynamic>> getCurrentweather() async {
    try {
      final res = await http.get(Uri.parse(
          'https://api.openweathermap.org/data/2.5/forecast?q=lalitpur&APPID=7dec4eb1beca78755c9348994f1bd2d5'));
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
    getCurrentweather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(179, 229, 252, 1),
      appBar: AppBar(
        title: const Text(
          'Lalitpur Weather',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.grey,
                actions: [IconButton(onPressed: (){Navigator.of(context).pushReplacementNamed('/lalitpur');}, icon: const Icon(Icons.refresh))],
        
        
      ),
      body: FutureBuilder(
        future: getCurrentweather(),
        builder: (context,snapshot){
          if(snapshot.connectionState==ConnectionState.waiting)
          {
            return const Center(child:  CircularProgressIndicator());
          }
          if(snapshot.hasError)
          {
            Text(snapshot.error.toString());
          }
          final data = snapshot.data!;
          final currentTemp = data['list'][0]['main']['temp'];
          final currentatmosphere =data['list'][0]['weather'][0]['main'];
          final humidity =data['list'][0]['main']['humidity'];
          final pressure =data['list'][0]['main']['pressure'];
          final windsSpeed =data['list'][0]['wind']['speed'];
          
          

          return  SafeArea(
            child: Container(
            padding: const EdgeInsets.all(15.0),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
               CurrentWeatherForecast(
                  temp: '$currentTemp', status: '$currentatmosphere', icon: currentatmosphere=='Clouds'||currentatmosphere=='Rain'?WeatherIcon.getIcon('wi-day-cloudy'):WeatherIcon.getIcon('wi-day-sunny')),
              const Padding(
                padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
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
                    final forecastTemp = data['list'][index+1]['main']['temp'];
                    final forecastAtmoshphere =data['list'][index+1]['weather'][0]['main'];
                    final time=DateTime.parse(data['list'][index+1]['dt_txt']);

                    return  WeatherForecast(
                        temp: '$forecastTemp', icon: forecastAtmoshphere=='Clouds'|| forecastAtmoshphere=='Rain'?WeatherIcon.getIcon('wi-day-cloudy'):WeatherIcon.getIcon('wi-day-sunny'), status: DateFormat.Hm().format(time));
                  },
                  itemCount: 5,
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 10.0, bottom: 10),
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
                        data: 'Humidity', icon:WeatherIcon.getIcon('wi-humidity') , value: '$humidity %'),
                    AdditonalInformation(
                        data:'Pressure' , icon: Icons.umbrella, value: '$pressure mbar'),
                    AdditonalInformation(
                        data: 'Wind Speed',
                        icon: WeatherIcon.getIcon('wi-strong-wind'),
                        value: '$windsSpeed m/s'),
                  ],
                ),
              )
            ]),
                    ),
          );


        },
      ),
    );
  }
}
