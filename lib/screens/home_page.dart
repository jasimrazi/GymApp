import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore package
import 'package:firebase_auth/firebase_auth.dart'; // Import FirebaseAuth package
import 'package:gymapp/screens/Signup%20Pages/membership_page.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:gymapp/utils.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late CalendarFormat _calendarFormat;
  late DateTime _focusedDay;
  late DateTime _selectedDay;
  CalendarStyle _calendarStyle = CalendarStyle(
    selectedDecoration: BoxDecoration(
      color: Colors.green,
      shape: BoxShape.circle,
    ),
    todayDecoration: BoxDecoration(
      color: Colors.transparent,
      shape: BoxShape.circle,
      border: Border.all(color: Colors.green),
    ),
    markersMaxCount: 1,
  );

  String membershipName = 'Tier 1'; // Default membership name
  DateTime expiryDate = DateTime.now(); // Default expiry date
  String formattedExpiryDate = '';

  @override
  void initState() {
    super.initState();
    _calendarFormat = CalendarFormat.month;
    _focusedDay = DateTime.now();
    _selectedDay = DateTime.now();
    fetchUserData(); // Fetch user data when the page is initialized
  }

  // Fetch user data including membership details from Firestore
  void fetchUserData() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
          .collection('personal_info')
          .doc(user.uid)
          .get();

      setState(() {
        membershipName = userSnapshot['membership_type'];
        Timestamp expiryTimestamp = userSnapshot['expiry_date'];
        expiryDate = expiryTimestamp.toDate(); // Convert Timestamp to DateTime
        formattedExpiryDate = DateFormat('dd/MM/yyyy').format(expiryDate);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        actions: [Icon(Icons.notifications, color: Colors.white)],
        leading: Icon(
          Icons.person,
          color: Colors.white,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(15),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white24,
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Membership",
                            style: AppFonts.primaryText(context),
                          ),
                          Text(
                            "Expiry: $formattedExpiryDate", // Display formatted expiry date
                            style: AppFonts.secondaryText(context),
                          ),
                        ],
                      ),
                      Text(
                        membershipName,
                        style: fontStyle(50, Colors.white, FontWeight.w900),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          InkWell(
                            borderRadius: BorderRadius.circular(100),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MembershipPage(),
                                ),
                              );
                            },
                            child: Container(
                              margin: EdgeInsets.only(right: 5),
                              padding: EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 12),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                border: Border.all(color: Color(0xff39FF14)),
                              ),
                              child: Text(
                                "Renew",
                                style: fontStyle(
                                    12, Colors.white, FontWeight.w100),
                              ),
                            ),
                          ),
                          InkWell(
                            borderRadius: BorderRadius.circular(100),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MembershipPage(),
                                ),
                              );
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 12),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                border: Border.all(color: Color(0xff39FF14)),
                              ),
                              child: Text(
                                "Upgrade",
                                style: fontStyle(
                                    12, Colors.white, FontWeight.w100),
                              ),
                            ),
                          ),
                          Spacer(),
                          InkWell(
                            borderRadius: BorderRadius.circular(100),
                            onTap: () {},
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 12),
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: Text(
                                "Cancel",
                                style: fontStyle(
                                    12, Colors.white, FontWeight.w100),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 30),
                  padding: EdgeInsets.all(15),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.white24,
                      borderRadius: BorderRadius.all(Radius.circular(12))),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Check In",
                            style: AppFonts.primaryText(context),
                          ),
                          Text(
                            "Check Out",
                            style: AppFonts.primaryText(context),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "7:00 PM",
                            style: AppFonts.secondaryText(context),
                          ),
                          Text(
                            "10:00 PM",
                            style: AppFonts.secondaryText(context),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 30),
                  padding: EdgeInsets.all(15),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.white24,
                      borderRadius: BorderRadius.all(Radius.circular(12))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Attendance",
                        style: AppFonts.primaryText(context),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TableCalendar(
                        firstDay: DateTime.utc(2022, 1, 1),
                        lastDay: DateTime.utc(2100, 12, 31),
                        focusedDay: _focusedDay,
                        calendarFormat: _calendarFormat,
                        startingDayOfWeek: StartingDayOfWeek.monday,
                        calendarStyle: _calendarStyle,
                        headerStyle: HeaderStyle(
                          formatButtonVisible: false,
                          titleCentered: true,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 30),
                  padding: EdgeInsets.all(15),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.white24,
                      borderRadius: BorderRadius.all(Radius.circular(12))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Payment History",
                        style: AppFonts.primaryText(context),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "₹ 1000",
                            style: AppFonts.secondaryText(context),
                          ),
                          Text(
                            "10:00 PM",
                            style: AppFonts.secondaryText(context),
                          ),
                        ],
                      ),
                    ],
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
