import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:projtest/Routes/Registration.dart';
import 'package:projtest/Routes/Sign_in.dart';
import 'package:projtest/Widgets/MyButton.dart';

class Welcome extends StatefulWidget {
  static const String screenRoute = 'Welcome';

  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[50],
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 180,
                    child: Image.asset('assets/images/CLUB (3).png'),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Samsians',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w900,
                      color: Color(0xff2e386b),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 80),
            MyButton(
              color: Colors.yellow[900]!,
              title: 'Sign in',
              onPressed: () {
                Navigator.pushNamed(context, SignIn.screenRoute);
              },
            ),
            MyButton(
              color: Colors.blue[800]!,
              title: 'Register',
              onPressed: () {
                Navigator.pushNamed(context, Registration.screenRoute);
              },
            )
          ],
        ),
      ),
    );
  }
}
