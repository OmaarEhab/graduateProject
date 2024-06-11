import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projtest/Routes/Aibe.dart';
import 'package:projtest/Routes/Dream.dart';
import 'package:projtest/Routes/Enactus.dart';
import 'package:projtest/Routes/Hult_Prize.dart';
import 'package:projtest/Routes/Rally.dart';
import 'package:projtest/Routes/Welcome.dart';
import 'package:projtest/Routes/news_feed.dart';
import 'package:projtest/Routes/profile.dart';
import 'package:projtest/Widgets/Dashboard.dart';
import 'package:projtest/database/shared_preferences.dart';
import 'package:projtest/models/app_user.dart';

class Clubs extends StatefulWidget {
  static const String screenRoute = 'Clubs';

  const Clubs({super.key});

  @override
  State<Clubs> createState() => _ClubsState();
}

class _ClubsState extends State<Clubs> {
  final fireAuth = FirebaseAuth.instance;
  final fireStore = FirebaseFirestore.instance;
  AppUser appUser = AppUser(
    userId: '',
    userName: '',
    email: '',
    studentClub: '',
    profileImage: '',
    role: '',
  );

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(.2),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 15),
          child: InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () {
              Navigator.pushNamed(
                context,
                Profile.screenRoute,
              );
            },
            child: Container(
              clipBehavior: Clip.hardEdge,
              decoration: const BoxDecoration(shape: BoxShape.circle),
              child: appUser.profileImage == ''
                  ? const Icon(Icons.person)
                  : CachedNetworkImage(
                      imageUrl: appUser.profileImage,
                      fit: BoxFit.cover,
                    ),
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white, size: 30),
        title: Text(
          appUser.userName,
          overflow: TextOverflow.fade,
          style: const TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            onPressed: () {
              signOut();
            },
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 100),
          Text(
            'Clubs',
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                letterSpacing: 2),
          ),
          const SizedBox(height: 20),
          Expanded(
            flex: 1,
            child: Image.asset('assets/images/CLUB (3).png'),
          ),
          const SizedBox(height: 20),
          const SizedBox(height: 1),
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
                children: [
                  ItemDashBoard(
                    title: 'Rally',
                    image: 'CLUB (1).png',
                    button: appUser.studentClub == 'Rally'
                        ? NewsFeed.screenRoute
                        : Rally.screenRoute,
                  ),
                  ItemDashBoard(
                    title: 'Dream',
                    image: 'CLUB (5).png',
                    button: appUser.studentClub == 'Dream'
                        ? NewsFeed.screenRoute
                        : Dream.screenRoute,
                  ),
                  ItemDashBoard(
                    title: 'Hult Prize',
                    image: 'CLUB (7).png',
                    button: appUser.studentClub == 'Hult'
                        ? NewsFeed.screenRoute
                        : Hult.screenRoute,
                  ),
                  ItemDashBoard(
                    title: 'Enactus',
                    image: 'CLUB (2).png',
                    button: appUser.studentClub == 'Enactus'
                        ? NewsFeed.screenRoute
                        : Enactus.screenRoute,
                  ),
                  ItemDashBoard(
                    title: 'Aibe',
                    image: 'CLUB (6).png',
                    button: appUser.studentClub == 'Aibe'
                        ? NewsFeed.screenRoute
                        : Aibe.screenRoute,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void signOut() {
    fireAuth.signOut();
    PreferenceUtils.setBool(PrefKeys.isLoggedIn, false);
    Navigator.pushNamedAndRemoveUntil(
      context,
      Welcome.screenRoute,
      (route) => false,
    );
  }

  Future<void> getUserData() async {
    String userId = fireAuth.currentUser!.uid;
    await fireStore.collection("users").doc(userId).get().then(
      (value) {
        setState(() {
          appUser = AppUser.fromMap(value.data()!);
        });
      },
    );
  }
}
