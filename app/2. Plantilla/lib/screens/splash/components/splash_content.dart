import 'package:flutter/material.dart';

import '../../../constants.dart';

class SplashContent extends StatefulWidget {
  const SplashContent({
    Key? key,
    this.text,
    this.image,
  }) : super(key: key);
  final String? text, image;

  @override
  State<SplashContent> createState() => _SplashContentState();
}

class _SplashContentState extends State<SplashContent> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
          Padding(  padding: const EdgeInsets.all(16.0),),
            Padding(  padding: const EdgeInsets.all(16.0),),
        const Spacer(),
        const Text(
          "Academia Nova",
          style: TextStyle(
            fontSize: 32,
            color: kPrimaryColor,
            fontWeight: FontWeight.bold,
          ),






        ),
        Text(
          widget.text!,
          textAlign: TextAlign.center,
        ),
        const Spacer(flex: 30),
        Image.asset(
          widget.image!,
          height: 265,
          width: 435,
        ),
      ],
    );
  }
}
