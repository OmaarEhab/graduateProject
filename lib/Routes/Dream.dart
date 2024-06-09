import 'package:flutter/material.dart';

class Dream extends StatelessWidget {
  const Dream({super.key});

  static const String screenRoute = 'Dream';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: const Text(
          'Dream',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
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


//انسخ بقيت الكلابس زي دريم و رالي 
//اعملهم stlss
//عرفهم في main routes
