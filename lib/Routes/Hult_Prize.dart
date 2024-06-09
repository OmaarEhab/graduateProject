import 'package:flutter/material.dart';

class Hult extends StatelessWidget {
  const Hult({super.key});

  static const String screenRoute = 'Hult';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: const Text(
          'Hult Prize',
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
