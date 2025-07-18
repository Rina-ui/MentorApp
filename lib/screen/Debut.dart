import 'package:flutter/material.dart';

class Debut extends StatefulWidget {
  const Debut({super.key});

  @override
  State<Debut> createState() => _DebutState();
}

class _DebutState extends State<Debut> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Debut'),
        centerTitle: true,
      ),
      body: Column(
        children: [

        ],
      ),
    );
  }
}
