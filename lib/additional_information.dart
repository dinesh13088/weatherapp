import 'package:flutter/material.dart';

class AdditonalInformation extends StatelessWidget {
  final String value;
  final String data;
   final IconData? icon;

  const AdditonalInformation({super.key,
  required this.data,
  required this.icon,
  required this.value
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:const  EdgeInsets.all(8),
      child:  Column(children: [
        Icon(icon ,size: 45,),
        Padding(
          padding: const EdgeInsets.only(top:8.0,bottom: 8),
          child: Text(data,style: const TextStyle(fontSize: 23,fontWeight: FontWeight.bold),),
        ),
        Text(value,style:const  TextStyle(fontSize: 23,fontWeight: FontWeight.bold),)
      ]),
    );
  }
}