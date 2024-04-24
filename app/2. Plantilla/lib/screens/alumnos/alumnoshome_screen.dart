import 'package:flutter/material.dart';

import 'components/banner.dart';
import 'components/alumos_name.dart';

class AlumnosScreen extends StatelessWidget {
  static String routeName = "/home";

  const AlumnosScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 16),
          child: Column(
            children: [
              DiscountBanner(),
              SizedBox(height: 20),
              WidgetAlumnos(),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
