import 'package:flutter/material.dart';

class WeatherForecast extends StatelessWidget {
  final String  temp;
 final IconData? icon;
 final String status;
  const WeatherForecast({super.key,
  required this.temp,
  required this.icon,
  required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return  Container(
      padding: const EdgeInsets.all(8),
      height: 20,
      child:  Card(
        elevation:8 ,
        color:  const Color.fromRGBO(179, 229, 252, 0.9),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text('$temp K',style: const TextStyle(fontSize: 24,fontWeight: FontWeight.bold),),
          
               Padding(
                padding:  const EdgeInsets.only(top: 8,bottom: 8),
                child: Icon(icon,size: 40),
              ),
              Text(status ,style: const TextStyle(fontSize: 24,fontWeight: FontWeight.bold),overflow: TextOverflow.ellipsis,),
            ],
          ),
        ),


      ),
    );
  }
}