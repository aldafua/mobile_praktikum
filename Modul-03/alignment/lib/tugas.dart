import 'package:flutter/material.dart';

void main() {
  runApp(TugasApp());
}

class TugasApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cuaca Malang',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Cuaca'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'Malang',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),

              Text(
                '25°',
                style: TextStyle(
                  fontSize: 72,
                  fontWeight: FontWeight.w300,
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Text(
                        'Minggu',
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                      SizedBox(height: 10),
                      Icon(
                        Icons.sunny,
                        color: Colors.black,
                        size: 30,
                      ),
                      SizedBox(height: 8),
                      Text(
                        '20°C',
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),

                  Column(
                    children: [
                      Text(
                        'Senin',
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                      SizedBox(height: 10),
                      Icon(
                        Icons.cloudy_snowing,
                        color: Colors.black,
                        size: 30,
                      ),
                      SizedBox(height: 8),
                      Text(
                        '23°C',
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),

                  Column(
                    children: [
                      Text(
                        'Selasa',
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                      SizedBox(height: 10),
                      Icon(
                        Icons.cloud,
                        color: Colors.black,
                        size: 30,
                      ),
                      SizedBox(height: 8),
                      Text(
                        '22°C',
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}