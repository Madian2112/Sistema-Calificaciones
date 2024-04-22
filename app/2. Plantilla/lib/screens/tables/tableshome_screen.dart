import 'package:flutter/material.dart';

import 'components/banner.dart';
import 'components/tables_name.dart';

class TablesScreen extends StatelessWidget {
  static String routeName = "/home";

  const TablesScreen({super.key});
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
              TablesName(),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
