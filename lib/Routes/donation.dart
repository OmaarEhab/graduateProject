import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projtest/models/app_user.dart';
import 'package:projtest/utils/app_toast.dart';

class Donation extends StatefulWidget {
  const Donation({super.key});

  static const screenRoute = 'Donation';

  @override
  State<Donation> createState() => _DonationState();
}

class _DonationState extends State<Donation> {
  final fireAuth = FirebaseAuth.instance;
  final fireStore = FirebaseFirestore.instance;
  String transactionNumber = '';
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
    transactionNumber = Random().nextInt(999999999).toString().padLeft(9, '0');
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
      body: Column(
        children: [
          Text(
            'Donation',
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
              child:  Center(
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 20),
                      const Center(
                        child: Text(
                          "THANK YOU",
                          style: TextStyle(fontSize: 30),
                        ),
                      ),
                      const SizedBox(height: 30),
                      Container(
                        width: 200.0,
                        height: 200.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.0),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 5.0,
                              spreadRadius: 2.0,
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Image.asset(
                            'assets/images/fawry.png',
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      const SizedBox(height: 32.0),
                      const Text(
                        'Transaction Number:',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      Text(
                        transactionNumber,
                        style: const TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const Spacer(),
                      SizedBox(
                        width: 250,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:  Colors.green,
                          ),
                          onPressed: () {
                            storeReceipt();
                          },
                          child: const Text(
                            'Confirm',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
  Future<void> storeReceipt() async {
    String id = DateTime.now().millisecondsSinceEpoch.toString();
    String userId = fireAuth.currentUser!.uid;
    await fireStore.collection("users").doc(userId).get().then((value) {
      appUser = AppUser.fromMap(value.data()!);
    });
    await fireStore.collection("receipts").doc(id).set({
      'donationId': id,
      'transactionNumber': transactionNumber,
      'donorName': appUser.userName,
      'donorId': appUser.userId,
      'donorRole' : appUser.role,
      'donorStudentClub':appUser.studentClub,
      'donorEmail':appUser.email
    });
    onDonationSuccess();
  }
  void onDonationSuccess() {
    displayToast("Thanks for Donation");
    Navigator.pop(context);
  }
}
