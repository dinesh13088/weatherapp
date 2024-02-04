import 'package:flutter/material.dart';
import 'package:weather_forecast_app_for_multiple_place/button.dart';

class MainWeather extends StatelessWidget {
  const MainWeather({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton:const  Icon(Icons.add,color: Colors.white,),
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushReplacementNamed('/');
              },
              icon: const Icon(Icons.refresh))
        ],
        backgroundColor: Colors.blueAccent,
        title: const Text('Weather App'),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(
                  'https://images.unsplash.com/photo-1561553543-e4c7b608b98d?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
              fit: BoxFit.cover),
        ),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              HomeButton(
                name: 'Bhaktapur',
                onpres: () {
                  Navigator.of(context).pushNamed('/bhaktapur');

                },
              ),
              HomeButton(
                name: 'Kathmandu',
                onpres: () {
                  Navigator.of(context).pushNamed('/kathmandu');
                },
              ),
              HomeButton(
                name: 'Lalitpur',
                onpres: () {
                  Navigator.of(context).pushNamed('/lalitpur');
                },
              ),
            ],
          )
        ]),
      ),
    );
  }
}
