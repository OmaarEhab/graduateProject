import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projtest/Routes/Aibe.dart';
import 'package:projtest/Routes/Dream.dart';
import 'package:projtest/Routes/Enactus.dart';
import 'package:projtest/Routes/Hult_Prize.dart';
import 'package:projtest/Routes/Rally.dart';
import 'package:projtest/Widgets/Dashboard.dart';

class Clubs extends StatelessWidget {
  static const String screenRoute = 'Clubs';

  const Clubs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(.2),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: const Padding(
          padding: EdgeInsets.only(left: 15),
          child: CircleAvatar(
            backgroundImage: AssetImage('images/gang.jpg'),
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white, size: 30),
        title: const Text(
          'Omar',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(CupertinoIcons.search))
        ],
      ),
      body: Column(
        children: [
          SizedBox(height: 100),
          Text(
            'Clubs',
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                letterSpacing: 2),
          ),
          SizedBox(height: 20),
          Expanded(
            child: Image.asset('images/CLUB (3).png'),
            flex: 1,
          ),
          const SizedBox(height: 20),
          SizedBox(height: 1),
          Expanded(
            flex: 4,
            child: Container(
              padding: const EdgeInsets.only(top: 20),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                ),
                color: Colors.white,
              ),
              child: GridView.count(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                children: const [
                  ItemDashBoard(
                    title: 'Rally',
                    image: 'CLUB (1).png',
                    button: Rally.screenRoute,
                  ),
                  ItemDashBoard(
                    title: 'Dream',
                    image: 'CLUB (5).png',
                    button: Dream.screenRoute,
                  ),
                  ItemDashBoard(
                    title: 'Hult Prize',
                    image: 'CLUB (7).png',
                    button: Hult.screenRoute,
                  ),
                  ItemDashBoard(
                    title: 'Enactus',
                    image: 'CLUB (2).png',
                    button: Enactus.screenRoute,
                  ),
                  ItemDashBoard(
                    title: 'Aibe',
                    image: 'CLUB (6).png',
                    button: Aibe.screenRoute,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
