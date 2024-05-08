import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Import FirebaseAuth package
import 'package:gymapp/screens/Signup%20Pages/membership_page.dart';
import 'package:gymapp/utils.dart'; // Import Firestore package

class PersonalInfo extends StatefulWidget {
  const PersonalInfo({Key? key});

  @override
  State<PersonalInfo> createState() => _PersonalInfoState();
}

class _PersonalInfoState extends State<PersonalInfo> {
  final TextEditingController nameController = TextEditingController();
  String genderValue = 'Male'; // Default gender value
  final TextEditingController ageController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();

  void savePersonalInfo(BuildContext context) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      String userId = user.uid;
      CollectionReference personalInfoCollection =
          FirebaseFirestore.instance.collection('personal_info');

      try {
        print('Saving personal info for user: $userId');
        print('Name: ${nameController.text}');
        print('Gender: $genderValue');
        print('Age: ${ageController.text}');
        print('Height: ${heightController.text}');
        print('Weight: ${weightController.text}');

        await personalInfoCollection.doc(userId).set({
          'name': nameController.text,
          'gender': genderValue,
          'age': int.tryParse(ageController.text) ?? 0,
          'height': double.tryParse(heightController.text) ?? 0.0,
          'weight': double.tryParse(weightController.text) ?? 0.0,
        });

        print('Personal info saved successfully.');

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MembershipPage()),
        );
      } catch (e) {
        // Print detailed error message
        print('Error saving personal info: $e');
        // Show a snackbar or dialog with the error message
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Failed to save personal info. Error: $e'),
        ));
      }
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: nameController,
              cursorColor: Color(0xff39FF14),
              decoration: InputDecoration(
                labelText: 'Name',
                labelStyle: TextStyle(color: Color(0xff39FF14)),
                focusedBorder: UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: Color(0xff39FF14)), // Green color
                ),
              ),
            ),
            SizedBox(height: 16),
            DropdownButtonFormField<String>(
              isExpanded: false,
              style: TextStyle(color: Colors.black),
              borderRadius: BorderRadius.circular(15),
              value: genderValue,
              onChanged: (newValue) {
                setState(() {
                  genderValue = newValue!;
                });
              },
              items: ['Male', 'Female', 'Other']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              decoration: InputDecoration(
                labelText: 'Gender',
                labelStyle: TextStyle(color: Color(0xff39FF14)),
                focusedBorder: UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: Color(0xff39FF14)), // Green color
                ),
              ),
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: ageController,
              cursorColor: Color(0xff39FF14),
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Age',
                labelStyle: TextStyle(color: Color(0xff39FF14)),
                focusedBorder: UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: Color(0xff39FF14)), // Green color
                ),
              ),
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: heightController,
              cursorColor: Color(0xff39FF14),
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Height (in cm)',
                labelStyle: TextStyle(color: Color(0xff39FF14)),
                focusedBorder: UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: Color(0xff39FF14)), // Green color
                ),
              ),
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: weightController,
              cursorColor: Color(0xff39FF14),
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Weight (in kg)',
                labelStyle: TextStyle(color: Color(0xff39FF14)),
                focusedBorder: UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: Color(0xff39FF14)), // Green color
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xff39FF14),
        onPressed: () {
          savePersonalInfo(context);
        },
        child: Icon(
          Icons.arrow_forward,
          color: Colors.black,
        ),
      ),
    );
  }
}
