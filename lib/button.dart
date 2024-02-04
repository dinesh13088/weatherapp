import 'package:flutter/material.dart';

class HomeButton extends StatelessWidget {
  final String name;
  final void Function()?  onpres;
  const HomeButton({super.key,
  required this.name,
  required this.onpres
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onpres,
        style: ButtonStyle(
            foregroundColor: const MaterialStatePropertyAll(Colors.white),
            backgroundColor: const MaterialStatePropertyAll(Colors.cyan),
            shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                side: BorderSide.none,
                borderRadius: BorderRadius.circular(4)))),
        child: Text(name,));
  }
}
