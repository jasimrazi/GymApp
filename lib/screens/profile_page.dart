import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gymapp/screens/landing_page.dart';
import 'package:gymapp/utils.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late User? _user;
  Map<String, dynamic>? _userData;

  @override
  void initState() {
    super.initState();
    _user = FirebaseAuth.instance.currentUser;
    _fetchUserData();
  }

  void _fetchUserData() async {
    if (_user != null) {
      DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
          .collection('personal_info')
          .doc(_user!.uid)
          .get();

      setState(() {
        _userData = userSnapshot.data() as Map<String, dynamic>;
      });
    }
  }

  void _logout() async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => LandingPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'User Profile',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              _userData != null
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildTextField('Name', _userData!['name'] ?? ''),
                        SizedBox(height: 15),
                        _buildTextField('Gender', _userData!['gender'] ?? ''),
                        SizedBox(height: 15),
                        _buildTextField(
                            'Age', '${_userData!['age'] ?? ''} years'),
                        SizedBox(height: 15),
                        _buildTextField(
                            'Height', '${_userData!['height'] ?? ''} cm'),
                        SizedBox(height: 15),
                        _buildTextField(
                            'Weight', '${_userData!['weight'] ?? ''} kg'),
                      ],
                    )
                  : Center(
                      child: CircularProgressIndicator(),
                    ),
              Spacer(),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    _logout();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xff39FF14),
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 40),
                  ),
                  child: Text(
                    "Logout",
                    style: fontStyle(18, Colors.black, FontWeight.w700),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, String value) {
    return TextFormField(
      initialValue: value,
      readOnly: true,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Color(0xff39FF14)),
        contentPadding: EdgeInsets.all(20),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xff39FF14)),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xff39FF14)),
        ),
        hintStyle: fontStyle(22, Colors.white, FontWeight.w900),
      ),
    );
  }
}
