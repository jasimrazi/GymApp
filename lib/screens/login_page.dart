import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Import Firebase Auth package
import 'package:gymapp/screens/home_page.dart';
import 'package:gymapp/utils.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void signInWithEmailAndPassword(BuildContext context) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: emailController.text, password: passwordController.text);
      // Navigate to the home page if login is successful
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } catch (e) {
      // Handle login errors here (e.g., show error message)
      print('Login Error: $e');
      // Show a snackbar or dialog to indicate login failure
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Login failed. Please check your credentials.'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(
                top: 45, left: 50, right: 50, bottom: 100),
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
                SizedBox(
                  height: 200,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: TextFormField(
                    controller: emailController,
                    cursorColor: Color(0xff39FF14),
                    decoration: InputDecoration(
                      hintText: 'Username',
                      contentPadding: EdgeInsets.all(20),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xff39FF14)),
                      ),
                      hintStyle: fontStyle(18, Colors.white, FontWeight.w700),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 50),
                  child: TextFormField(
                    controller: passwordController,
                    obscureText: true,
                    cursorColor: Color(0xff39FF14),
                    decoration: InputDecoration(
                      hintText: 'Password',
                      contentPadding: EdgeInsets.all(20),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xff39FF14)),
                      ),
                      hintStyle: fontStyle(18, Colors.white, FontWeight.w700),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () => signInWithEmailAndPassword(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                  ),
                  child: Text('Login',
                      style: fontStyle(18, Colors.black,
                          FontWeight.w700) // Set button text color to black
                      ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
