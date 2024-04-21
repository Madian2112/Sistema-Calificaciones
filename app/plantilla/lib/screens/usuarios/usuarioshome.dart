import 'package:flutter/material.dart';
import 'components/banner.dart';
import 'usuarios_screen.dart';

class Usuarioscreen extends StatelessWidget {
  static String routeName = "/Usuarioscreen";

  const Usuarioscreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                DiscountBanner(), // Banner como encabezado
                SizedBox(height: 20),
                MyWidget(), // Contenido principal
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


