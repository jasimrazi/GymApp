import 'package:flutter/material.dart';
import 'package:gymapp/screens/login_page.dart';
import 'package:gymapp/utils.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

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
              const EdgeInsets.only(top: 100, left: 20, right: 20, bottom: 50),
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
                  onPressed: () {},
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
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginPage(),
                          ));
                    },
                    child: RichText(
                        text: TextSpan(
                            style: AppFonts.secondaryText(context),
                            children: [
                          TextSpan(text: 'Aleadry a member?'),
                          TextSpan(
                              text: ' Login now',
                              style: TextStyle(
                                  decoration: TextDecoration.underline))
                        ])),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
