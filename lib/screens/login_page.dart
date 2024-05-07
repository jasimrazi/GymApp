import 'package:flutter/material.dart';
import 'package:gymapp/utils.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding:
              const EdgeInsets.only(top: 45, left: 20, right: 20, bottom: 100),
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
              TextFormField(
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
              SizedBox(height: 16),
              TextFormField(
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
              SizedBox(height: 50),
              ElevatedButton(
                onPressed: () {
                  // Add login functionality here
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
    );
  }
}
