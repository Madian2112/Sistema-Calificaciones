import 'package:flutter/material.dart';

class DiscountBanner extends StatelessWidget {
  const DiscountBanner({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 16,
      ),
      decoration: BoxDecoration(
         image: DecorationImage(
             image: AssetImage('images/log3.jpg'),
            fit: BoxFit.cover, 
          ),
        color: Color.fromARGB(255, 255, 255, 255),
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Text.rich(
        
        TextSpan(
          style: TextStyle(color: Colors.white),
          children: [
            
            TextSpan(text: "\n"),
            TextSpan(
              
              text: "Bienvenido",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
