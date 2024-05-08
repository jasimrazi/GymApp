import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Import Firebase Auth package
import 'package:gymapp/screens/Signup%20Pages/personalinfo_page.dart';
import 'package:gymapp/utils.dart';

class SignupPage extends StatefulWidget {
  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>(); // Add form key for validation

  void signUpWithEmailAndPassword(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: emailController.text, password: passwordController.text);
        // Check if userCredential is not null (account created successfully)
        if (userCredential.user != null) {
          // Navigate to the next page (PersonalInfo) after signup
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => PersonalInfo()),
          );
        } else {
          // Show a snackbar to indicate signup failure (account already exists)
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Account already exists. Please log in.'),
          ));
        }
      } on FirebaseAuthException catch (e) {
        // Handle signup errors here (e.g., show error message)
        print('Signup Error: $e');
        // Show a snackbar or dialog to indicate signup failure
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Signup failed. Please try again.'),
        ));
      }
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
            child: Form(
              key: _formKey, // Assign the form key
              child: Center(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 15),
                      child: TextFormField(
                        controller: emailController,
                        cursorColor: Color(0xff39FF14),
                        decoration: InputDecoration(
                          hintText: 'Email',
                          contentPadding: EdgeInsets.all(20),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xff39FF14)),
                          ),
                          hintStyle:
                              fontStyle(18, Colors.white, FontWeight.w700),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Email is required';
                          }
                          return null;
                        },
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
                          hintStyle:
                              fontStyle(18, Colors.white, FontWeight.w700),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Password is required';
                          }
                          return null;
                        },
                      ),
                    ),
                    // Next page arrow at the bottom right corner
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xff39FF14),
        onPressed: () {
          signUpWithEmailAndPassword(context);
        },
        child: Icon(
          Icons.arrow_forward,
          color: Colors.black,
          size: 32,
        ),
      ),
    );
  }
}
