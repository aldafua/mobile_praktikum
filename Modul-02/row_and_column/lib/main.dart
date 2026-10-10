import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Row and Column',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Row and Column'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  KotakFavorit(
                    warna: Colors.blue,
                    teks: 'Favorit 1',
                  ),
                  SizedBox(width: 20),
                  KotakFavorit(
                    warna: Colors.lightBlue,
                    teks: 'Favorit 2',
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  KotakFavorit(
                    warna: Colors.blueAccent,
                    teks: 'Favorit 3',
                  ),
                  SizedBox(width: 20),
                  KotakFavorit(
                    warna: Colors.cyan,
                    teks: 'Favorit 4',
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

class KotakFavorit extends StatelessWidget {
  final Color warna;
  final String teks;

  KotakFavorit({
    required this.warna,
    required this.teks,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            color: warna,
            border: Border.all(
              color: Colors.black,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            Icons.favorite,
            color: Colors.red,
            size: 40,
          ),
        ),
        SizedBox(height: 8),
        Text(
          teks,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}