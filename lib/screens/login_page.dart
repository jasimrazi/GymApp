import 'package:flutter/material.dart';
import 'package:gymapp/screens/home_page.dart';
import 'package:gymapp/utils.dart';

class LoginPage extends StatelessWidget {
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
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomePage(),
                        )); // Add login functionality here
                  },
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
