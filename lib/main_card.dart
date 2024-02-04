import 'package:flutter/material.dart';

class CurrentWeatherForecast extends StatelessWidget {
  final String temp;
  final String status;
  final IconData? icon;
  const CurrentWeatherForecast({
    super.key,
    required this.temp,
    required this.status,
    required this.icon
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:const  EdgeInsets.all(10),
      // color: Colors.grey,
      child: Card(
        elevation: 8,
        color: const Color.fromRGBO(179, 229, 252, 0.9),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          side: BorderSide.none,
        ),
        child: SizedBox(
          child: Center(
            child: Column(
              children: [
                Text(
                  '$temp k',
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                ),
                 Padding(
                  padding:const  EdgeInsets.only(top: 10, bottom: 10),
                  child: Icon(icon, size: 38),
                ),
                Text(
                  status,
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
