import 'package:flutter/material.dart';
import 'package:projtest/Routes/Aibe.dart';
import 'package:projtest/Routes/Clubs.dart';
import 'package:projtest/Routes/Dream.dart';
import 'package:projtest/Routes/Enactus.dart';
import 'package:projtest/Routes/Hult_Prize.dart';
import 'package:projtest/Routes/Rally.dart';
import 'package:projtest/Routes/Registration.dart';
import 'package:projtest/Routes/Sign_in.dart';
import 'Routes/Welcome.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const ProjectTest());
}

class ProjectTest extends StatelessWidget {
  const ProjectTest({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Samsians',
      theme: ThemeData(primarySwatch: Colors.blue),
      //home: const Welcome(),
      initialRoute: Welcome.screenRoute,
      routes: {
        //Main pages of the App

        Welcome.screenRoute: (context) => const Welcome(),
        Registration.screenRoute: (context) => const Registration(),
        SignIn.screenRoute: (context) => const SignIn(),
        Clubs.screenRoute: (context) => const Clubs(),

        //Applying pages for student activties (Clubs)

        Rally.screenRoute: (context) => const Rally(),
        Dream.screenRoute: (context) => const Dream(),
        Enactus.screenRoute: (context) => const Enactus(),
        Aibe.screenRoute: (context) => const Aibe(),
        Hult.screenRoute: (context) => const Hult(),
      },
    );
  }
}
