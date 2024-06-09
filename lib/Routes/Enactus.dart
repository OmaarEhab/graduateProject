import 'package:flutter/material.dart';

class Enactus extends StatelessWidget {
  const Enactus({super.key});

  static const String screenRoute = 'Enactus';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent,
        title: const Text(
          'Enactus',
          style: TextStyle(color: Colors.black, fontSize: 25),
        ),
        centerTitle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
      ),
    );
  }
}
