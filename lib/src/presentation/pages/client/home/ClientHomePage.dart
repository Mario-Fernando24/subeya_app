import 'package:flutter/material.dart';

class Clienthomepage extends StatefulWidget {
  const Clienthomepage({super.key});

  @override
  State<Clienthomepage> createState() => _ClienthomepageState();
}

class _ClienthomepageState extends State<Clienthomepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Client Home Page'),
      )   ,
    );
  }
}