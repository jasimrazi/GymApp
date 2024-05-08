import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Import FirebaseAuth package
import 'package:gymapp/screens/home_page.dart';
import 'package:gymapp/utils.dart'; // Import Firestore package

class MembershipPage extends StatefulWidget {
  const MembershipPage({Key? key});

  @override
  State<MembershipPage> createState() => _MembershipPageState();
}

class _MembershipPageState extends State<MembershipPage> {
  String selectedMembership = ''; // Variable to store the selected membership
  DateTime startDate =
      DateTime.now(); // Variable to store the membership start date

  void selectMembership(String membershipType) {
    setState(() {
      selectedMembership = membershipType;
      // Calculate the expiry date based on the selected membership
      switch (selectedMembership) {
        case 'Monthly':
          startDate = DateTime.now();
          break;
        case '3 Months':
          startDate = DateTime.now();
          break;
        case '1 Year':
          startDate = DateTime.now();
          break;
        default:
          startDate = DateTime.now();
      }
    });
  }

  void saveMembership(BuildContext context) async {
    String userId = getCurrentUserId(); // Get the current user ID

    CollectionReference personalInfoCollection =
        FirebaseFirestore.instance.collection('personal_info');

    try {
      // Get the existing personal info document for the user
      DocumentSnapshot<Map<String, dynamic>> personalInfoDoc =
          await personalInfoCollection.doc(userId).get()
              as DocumentSnapshot<Map<String, dynamic>>;

      // Add membership details to the existing document
      await personalInfoCollection.doc(userId).update({
        'membership_type': selectedMembership,
        'start_date': startDate,
        'expiry_date': calculateExpiryDate(startDate, selectedMembership),
      });

      // Navigate to the home page after saving membership info
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } catch (e) {
      // Handle error if saving to Firestore fails
      print('Error saving membership info: $e');
      // Show a snackbar or dialog to indicate saving failure
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Failed to save membership info. Please try again.'),
      ));
    }
  }

  // Function to calculate the expiry date based on the selected membership
  DateTime calculateExpiryDate(DateTime startDate, String membershipType) {
    switch (membershipType) {
      case 'Monthly':
        return startDate.add(Duration(days: 30));
      case '3 Months':
        return startDate.add(Duration(days: 90));
      case '1 Year':
        return startDate.add(Duration(days: 365));
      default:
        return startDate.add(Duration(days: 30));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                selectMembership('Monthly');
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: selectedMembership == 'Monthly'
                    ? Color(0xff39FF14)
                    : Colors.black,
                side: BorderSide(
                  color: Color(0xff39FF14),
                  width: 2,
                ),
                fixedSize: Size(200, 50), // Fixed height and width
              ),
              child: Text(
                'Monthly Membership',
                style: TextStyle(
                  color: selectedMembership == 'Monthly'
                      ? Colors.black
                      : Color(0xff39FF14),
                ),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                selectMembership('3 Months');
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: selectedMembership == '3 Months'
                    ? Color(0xff39FF14)
                    : Colors.black,
                side: BorderSide(
                  color: Color(0xff39FF14),
                  width: 2,
                ),
                fixedSize: Size(200, 50), // Fixed height and width
              ),
              child: Text(
                '3 Months Membership',
                style: TextStyle(
                  color: selectedMembership == '3 Months'
                      ? Colors.black
                      : Color(0xff39FF14),
                ),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                selectMembership('1 Year');
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: selectedMembership == '1 Year'
                    ? Color(0xff39FF14)
                    : Colors.black,
                side: BorderSide(
                  color: Color(0xff39FF14),
                  width: 2,
                ),
                fixedSize: Size(200, 50), // Fixed height and width
              ),
              child: Text(
                '1 Year Membership',
                style: TextStyle(
                  color: selectedMembership == '1 Year'
                      ? Colors.black
                      : Color(0xff39FF14),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xff39FF14),
        onPressed: () {
          saveMembership(context);
        },
        child: Icon(
          Icons.arrow_forward,
          color: Colors.black,
        ),
      ),
    );
  }

  // Function to get the current logged-in user ID from Firebase Auth
  String getCurrentUserId() {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return user.uid;
    } else {
      // User is not logged in
      return ''; // Return an empty string or handle the case as needed
    }
  }
}
