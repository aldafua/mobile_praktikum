import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Alignment',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Alignment'),
        ),
        body: const Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                'Suhu:',
                style: TextStyle(
                  fontSize: 30,
                ),
              ),
              Text(
                '25°C',
                style: TextStyle(
                  fontSize: 75,
                ),
              ),
              Icon(
                Icons.sunny,
                color: Colors.amber,
                size: 45,
              ),
            ],
          ),
        ),
      ),
    );
  }
}