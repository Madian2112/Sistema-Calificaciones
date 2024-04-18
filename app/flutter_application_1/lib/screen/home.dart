import 'package:flutter/material.dart';

class MenuPrincipal extends StatelessWidget {
  const MenuPrincipal({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromARGB(255, 224, 255, 47),
      child: Center(
        child: Text(
           'HOLA MUNDO',
        style: TextStyle(
        color: Color.fromARGB(255, 255, 164, 195),
         fontSize: 25,
  ),
),
      ),
    );
  }
}