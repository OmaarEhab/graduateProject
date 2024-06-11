import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:projtest/models/app_user.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  static const String screenRoute = 'Profile';

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
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
      backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(.2),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        title: OutlinedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text(
            'Back',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Text(
                'Profile',
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                    ),
              ),
              const SizedBox(height: 20),
              Expanded(
                flex: 1,
                child: Image.asset('assets/images/CLUB (3).png'),
              ),
              const SizedBox(height: 20),
              Expanded(
                flex: 4,
                child: Container(
                  width: double.infinity,
                  color: Colors.grey[300],
                  child: Column(
                    children: [
                      const SizedBox(height: 120),
                      Text(
                        appUser.userName,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Divider(
                        color: Colors.black,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Details',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.email,
                                    size: 40,
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    "Email\n${appUser.email}",
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.groups,
                                    size: 40,
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    "Student Club\n${appUser.studentClub}",
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.work,
                                    size: 40,
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    "Role\n${appUser.role}",
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
          PositionedDirectional(
            top: MediaQuery.of(context).size.height * 0.23,
            start: MediaQuery.of(context).size.width * 0.35,
            child: InkWell(
              onTap: () {
                pickImage();
              },
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              child: Container(
                width: 120,
                height: 120,
                clipBehavior: Clip.hardEdge,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: appUser.profileImage == ''
                    ? const Icon(
                        Icons.person,
                        size: 50,
                      )
                    : CachedNetworkImage(
                        imageUrl: appUser.profileImage,
                        fit: BoxFit.cover,
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? file = await picker.pickImage(source: ImageSource.gallery);
    uploadImage(File(file!.path));
  }

  Future<void> uploadImage(File image) async {
    String userId = fireAuth.currentUser!.uid;
    await storage.ref('profileImages/$userId').putFile(image).then(
      (value) {
        getImageUrl();
      },
    ).catchError(
      (error) {},
    );
  }

  Future<void> getImageUrl() async {
    String userId = fireAuth.currentUser!.uid;
    await storage.ref('profileImages/$userId').getDownloadURL().then(
      (value) {
        fireStore.collection("users").doc(userId).update({
          'profileImage': value,
        });
        setState(() {
          appUser.profileImage = value;
        });
      },
    ).catchError(
      (error) {},
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
