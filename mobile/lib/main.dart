import 'package:flutter/material.dart';
import 'package:mobile/screens/home_screen.dart';
import 'package:mobile/screens/add_review_screen.dart';
import 'package:mobile/screens/review_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Avaliação de Filmes',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/add_review': (context) => AddReviewScreen(),
        '/reviews': (context) => ReviewsScreen(),
      },
    );
  }
}
