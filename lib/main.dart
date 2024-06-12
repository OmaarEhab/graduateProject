import 'package:flutter/material.dart';
import 'package:projtest/Routes/Aibe.dart';
import 'package:projtest/Routes/Clubs.dart';
import 'package:projtest/Routes/Dream.dart';
import 'package:projtest/Routes/Enactus.dart';
import 'package:projtest/Routes/Hult_Prize.dart';
import 'package:projtest/Routes/Rally.dart';
import 'package:projtest/Routes/Registration.dart';
import 'package:projtest/Routes/Sign_in.dart';
import 'package:projtest/Routes/comments.dart';
import 'package:projtest/Routes/donation.dart';
import 'package:projtest/Routes/news_feed.dart';
import 'package:projtest/Routes/profile.dart';
import 'package:projtest/Routes/submit_task.dart';
import 'package:projtest/database/shared_preferences.dart';
import 'Routes/Welcome.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PreferenceUtils.init();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyCDE_4SFoHFjhK_pyDZxg8aj7BCT7cJRC4",
      appId: "1:477421556764:android:ebba407c332af29235fbd9",
      messagingSenderId: "477421556764",
      projectId: "samsians-52e59",
      storageBucket: "samsians-52e59.appspot.com",
    ),
  );
  runApp(const ProjectTest());
}

class ProjectTest extends StatelessWidget {
  const ProjectTest({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Samsians',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      //home: const Welcome(),
      initialRoute: PreferenceUtils.getBool(PrefKeys.isLoggedIn)
          ? Clubs.screenRoute
          : Welcome.screenRoute,
      routes: {
        //Main pages of the App

        Welcome.screenRoute: (context) => const Welcome(),
        Registration.screenRoute: (context) => const Registration(),
        SignIn.screenRoute: (context) => const SignIn(),
        Clubs.screenRoute: (context) => const Clubs(),
        Profile.screenRoute: (context) => const Profile(),
        NewsFeed.screenRoute: (context) => const NewsFeed(),
        Donation.screenRoute: (context) => const Donation(),
        SubmitTask.screenRoute: (context) => const SubmitTask(),
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
