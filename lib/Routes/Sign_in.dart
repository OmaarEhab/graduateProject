import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:projtest/Routes/Clubs.dart';
import 'package:projtest/Widgets/MyButton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:projtest/database/shared_preferences.dart';
import 'package:projtest/utils/app_connectivity.dart';
import 'package:projtest/utils/app_toast.dart';

class SignIn extends StatefulWidget {
  static const String screenRoute = 'Sign_in';

  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final fireAuth = FirebaseAuth.instance;
  final fireStore = FirebaseFirestore.instance;
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool obscure = true;

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[50],
      appBar: AppBar(
        backgroundColor: Colors.teal[300],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 20),
                SizedBox(
                  height: 180,
                  child: Image.asset('assets/images/CLUB (3).png'),
                ),
                const SizedBox(
                  height: 80,
                ),
                TextFormField(
                  controller: emailController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your email';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.emailAddress,
                  textAlign: TextAlign.center,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    suffixIcon: Icon(Icons.email),
                    hintText: 'Email',
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue, width: 1),
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.orange, width: 2),
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                TextFormField(
                  controller: passwordController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a password';
                    }
                    return null;
                  },
                  obscureText: obscure,
                  textAlign: TextAlign.center,
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          obscure = !obscure;
                        });
                      },
                      icon: Icon(
                        obscure ? Icons.visibility_off : Icons.visibility,
                      ),
                    ),
                    hintText: 'Password',
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue, width: 1),
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.orange, width: 2),
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                MyButton(
                  color: Colors.yellow[900]!,
                  title: 'Sign in',
                  onPressed: () async {
                    login();
                  },
                ),
                MyButton(
                  color: Colors.red[900]!,
                  title: 'Login With Google',
                  onPressed: () async {
                    signInWithGoogle();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> login() async {
    if (!formKey.currentState!.validate()) {
      return;
    }
    try {
      await fireAuth.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      onLoginSuccess();
    } catch (error) {
      if (await AppConnectivity.checkConnection()) {
        displayToast('Invalid Credentials!');
      } else {
        displayToast('Check Your internet!');
      }
    }
  }

  Future<void> signInWithGoogle() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    final GoogleSignIn googleSignIn = GoogleSignIn();

    final GoogleSignInAccount? googleSignInAccount =
    await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      try {
        final UserCredential userCredential =
        await auth.signInWithCredential(credential);
        user = userCredential.user;
        if (user != null) {
          // Store user data in Firestore
          fireStore.collection('users').doc(user.uid).set({
            'userId': user.uid,
            'userName': user.displayName,
            'email': user.email,
            'studentClub':'',
            'role':'',
            'profileImage':user.photoURL
          });
          onLoginSuccess();
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'account-exists-with-different-credential') {
          displayToast('Account Already Exist');
        } else if (e.code == 'invalid-credential') {
          displayToast('Invalid Credentials');
        }
      } catch (e) {
        displayToast(e.toString());
      }
    }
  }

  void onLoginSuccess() {
    PreferenceUtils.setBool(PrefKeys.isLoggedIn, true);
    showDialog(
      context: context,
      builder: (context) {
        return const Center(child: CircularProgressIndicator());
      },
    );
    Future.delayed(
      const Duration(seconds: 1),
      () {
        Navigator.pushNamedAndRemoveUntil(
          context,
          Clubs.screenRoute,
          (route) => false,
        );
      },
    );
  }
}
