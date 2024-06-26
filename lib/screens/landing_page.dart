import 'package:flutter/material.dart';
import 'package:gymapp/screens/Signup%20Pages/signup_page.dart';
import 'package:gymapp/screens/login_page.dart';
import 'package:gymapp/utils.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Import FirebaseAuth package
import 'package:gymapp/screens/home_page.dart'; // Import HomePage if it's in a different file

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding:
              const EdgeInsets.only(top: 100, left: 50, right: 50, bottom: 50),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "GYM",
                      style: fontStyle(
                        100,
                        Colors.white,
                        FontWeight.w800,
                      ),
                    ),
                    Text(
                      "+",
                      style: fontStyle(
                        100,
                        Color(0xff39FF14),
                        FontWeight.w800,
                      ),
                    ),
                  ],
                ),
                Spacer(),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SignupPage(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Colors.white, // Set button text color to black
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Text(
                      "Sign Up",
                      style: fontStyle(18, Colors.black, FontWeight.w700),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: InkWell(
                    onTap: () {
                      checkLoggedInUser(); // Check if the user is logged in
                    },
                    child: RichText(
                        text: TextSpan(
                      style: AppFonts.secondaryText(context),
                      children: [
                        TextSpan(text: 'Already a member?'),
                        TextSpan(
                          text: ' Login now',
                          style:
                              TextStyle(decoration: TextDecoration.underline),
                        )
                      ],
                    )),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Check if the user is already logged in
  void checkLoggedInUser() {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      // User is already logged in, navigate to HomePage
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(),
        ),
      );
    } else {
      // User is not logged in, navigate to LoginPage
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LoginPage(),
        ),
      );
    }
  }
}
