import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:projtest/Routes/donation.dart';
import 'package:projtest/Routes/profile.dart';
import 'package:projtest/models/app_user.dart';

class NewsFeed extends StatefulWidget {
  const NewsFeed({super.key});

  static const screenRoute = 'NewsFeed';

  @override
  State<NewsFeed> createState() => _NewsFeedState();
}

class _NewsFeedState extends State<NewsFeed> {
  final fireAuth = FirebaseAuth.instance;
  final fireStore = FirebaseFirestore.instance;
  final storage = FirebaseStorage.instance;
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
      appBar: AppBar(
        backgroundColor: setColor(),
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.home_filled,
                size: 30,
                color: Colors.white,
              ),
            ),
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, Profile.screenRoute);
              },
              icon: const Icon(
                Icons.person,
                size: 30,
                color: Colors.white,
              ),
            ),
            Image.asset(
              setIcon(),
              width: 55,
              height: 55,
            ),
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, Donation.screenRoute);
              },
              icon: const Icon(
                Icons.monetization_on,
                size: 30,
                color: Colors.white,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.task,
                size: 30,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
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

  Color setColor() {
    if (appUser.studentClub == 'Rally') {
      return Colors.red;
    } else if (appUser.studentClub == 'Dream') {
      return Colors.blueAccent;
    } else if (appUser.studentClub == 'Aibe') {
      return Colors.deepPurple;
    } else if (appUser.studentClub == 'Hult') {
      return Colors.pink;
    } else if (appUser.studentClub == 'Enactus') {
      return Colors.orangeAccent;
    }
    return Colors.white;
  }

  String setIcon() {
    if (appUser.studentClub == 'Rally') {
      return 'assets/images/CLUB (1).png';
    } else if (appUser.studentClub == 'Dream') {
      return 'assets/images/CLUB (5).png';
    } else if (appUser.studentClub == 'Aibe') {
      return 'assets/images/CLUB (6).png';
    } else if (appUser.studentClub == 'Hult') {
      return 'assets/images/CLUB (7).png';
    } else if (appUser.studentClub == 'Enactus') {
      return 'assets/images/CLUB (2).png';
    }
    return 'assets/images/CLUB (4).png';
  }
}
