import 'package:shop_app/screens/reportes/components/card.dart';

import 'package:flutter/material.dart';

class CalificacionesScreen extends StatelessWidget {
  static String routeName = "/calificaciones";

  const CalificacionesScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 16),
          child: Column(
            children: [
              RunningRScreen(),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
