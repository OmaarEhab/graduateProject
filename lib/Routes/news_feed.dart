import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:projtest/Routes/comments.dart';
import 'package:projtest/Routes/donation.dart';
import 'package:projtest/Routes/profile.dart';
import 'package:projtest/Routes/submit_task.dart';
import 'package:projtest/models/app_post.dart';
import 'package:projtest/models/app_user.dart';
import 'package:projtest/utils/app_toast.dart';

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
  final descriptionController = TextEditingController();
  String postId = '';
  File imageFile = File('');
  List<AppPost> appPosts = [];
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
    getPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
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
              onPressed: () {
                Navigator.pushNamed(context, SubmitTask.screenRoute);
              },
              icon: const Icon(
                Icons.task,
                size: 30,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: 70,
                      clipBehavior: Clip.hardEdge,
                      decoration: const BoxDecoration(shape: BoxShape.circle),
                      child: appUser.profileImage == ''
                          ? const Icon(Icons.person)
                          : CachedNetworkImage(
                              imageUrl: appUser.profileImage,
                              fit: BoxFit.cover,
                            ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          TextFormField(
                            controller: descriptionController,
                            cursorColor: Colors.black,
                            decoration: InputDecoration(
                              hintText: "Whats on your mind",
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Visibility(
                            visible: imageFile.path != '',
                            child: ClipRRect(
                              clipBehavior: Clip.hardEdge,
                              borderRadius: BorderRadius.circular(16),
                              child: Image.file(
                                imageFile,
                                height: 200,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  pickImage();
                                },
                                icon: const Icon(Icons.image),
                              ),
                              IconButton(
                                onPressed: () {
                                  if (descriptionController.text.isNotEmpty) {
                                    addPost();
                                  }
                                },
                                icon: const Icon(Icons.send),
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: appPosts.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.only(top: 10),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            height: 70,
                            clipBehavior: Clip.hardEdge,
                            decoration:
                                const BoxDecoration(shape: BoxShape.circle),
                            child: appPosts[index].profileImage == ''
                                ? const Icon(Icons.person)
                                : CachedNetworkImage(
                                    imageUrl: appPosts[index].profileImage,
                                    fit: BoxFit.cover,
                                  ),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            appUser.userName,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          appPosts[index].description,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Visibility(
                        visible: appPosts[index].postImage != '',
                        child: ClipRRect(
                          clipBehavior: Clip.hardEdge,
                          borderRadius: BorderRadius.circular(16),
                          child: Image.network(
                            appPosts[index].postImage,
                            height: 200,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          '${appPosts[index].likes} Likes',
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Divider(
                        color: Colors.black,
                        height: 2,
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            onPressed: () {
                              like(appPosts[index].postId, index);
                            },
                            icon: Icon(
                              appPosts[index].liked
                                  ? Icons.thumb_up
                                  : Icons.thumb_up_outlined,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Comments(
                                    postId: appPosts[index].postId,
                                  ),
                                ),
                              );
                            },
                            icon: const Icon(Icons.comment),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.share),
                          ),
                        ],
                      )
                    ],
                  ),
                );
              },
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

  Future<void> addPost() async {
    postId = DateTime.now().millisecondsSinceEpoch.toString();
    await fireStore.collection('posts').doc(postId).set({
      'postId': postId,
      'userName': appUser.userName,
      'userId': appUser.userId,
      'profileImage': appUser.profileImage,
      'description': descriptionController.text,
      'postImage': '',
      'likes': 0,
      'studentClub': appUser.studentClub,
      'comments': [],
    });
    if(imageFile.path.isNotEmpty){
      await uploadImage(imageFile);
    }
    onAddPostSuccess();
  }

  void pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? file = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      imageFile = File(file!.path);
    });
  }

  Future<void> uploadImage(File image) async {
    String userId = fireAuth.currentUser!.uid;
    await storage.ref('postsImages/$userId/$postId').putFile(image).then(
      (value) async {
        await getImageUrl();
      },
    ).catchError(
      (error) {},
    );
  }

  Future<void> getImageUrl() async {
    String userId = fireAuth.currentUser!.uid;
    await storage.ref('postsImages/$userId/$postId').getDownloadURL().then(
      (value) {
        fireStore.collection("posts").doc(postId).update({
          'postImage': value,
        });
      },
    ).catchError(
      (error) {},
    );
  }

  void onAddPostSuccess() {
    setState(() {
      descriptionController.text = '';
      imageFile = File('');
    });
    displayToast('Posted');
    getPosts();
  }

  Future<void> getPosts() async {
    appPosts.clear();
    await fireStore.collection('posts').get().then((value) {
      for (var doc in value.docs) {
        if (doc.data()['studentClub'] == appUser.studentClub) {
          appPosts.add(AppPost.fromMap(doc.data()));
        }
      }
      setState(() {});
    });
  }

  Future<void> like(String postId, int index) async {
    if (appPosts[index].liked) {
      await fireStore.collection('posts').doc(postId).get().then((value) async {
        appPosts[index].likes = value.data()!['likes'] - 1;
        await fireStore
            .collection('posts')
            .doc(postId)
            .update({'likes': appPosts[index].likes});
      });
      setState(() {
        appPosts[index].liked = false;
      });
    } else {
      await fireStore.collection('posts').doc(postId).get().then((value) async {
        appPosts[index].likes = value.data()!['likes'] + 1;
        await fireStore
            .collection('posts')
            .doc(postId)
            .update({'likes': appPosts[index].likes});
      });
      setState(() {
        appPosts[index].liked = true;
      });
    }
  }
}
