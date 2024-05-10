import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gymapp/screens/Signup%20Pages/membership_page.dart';
import 'package:gymapp/screens/notifications_page.dart';
import 'package:gymapp/screens/profile_page.dart';
import 'package:gymapp/screens/qr_page.dart';
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
    defaultTextStyle: fontStyle(12, Colors.white, FontWeight.w300),
    selectedTextStyle: TextStyle(color: Colors.black),
    selectedDecoration: BoxDecoration(
      color: Color(0xff39FF14),
      shape: BoxShape.circle,
    ),
    todayDecoration: BoxDecoration(
      color: Colors.transparent,
      shape: BoxShape.circle,
      border: Border.all(color: Color(0xff39FF14)),
    ),
    markersMaxCount: 1,
  );

  String membershipName = 'Tier 1';
  DateTime expiryDate = DateTime.now();
  String formattedExpiryDate = '';
  String checkinTime = '';
  String checkoutTime = '';
  Map<String, bool> attendanceData = {};

  @override
  void initState() {
    super.initState();
    _calendarFormat = CalendarFormat.month;
    _focusedDay = DateTime.now();
    _selectedDay = DateTime.now();
    fetchUserData();
    fetchAttendanceData();
  }

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
        expiryDate = expiryTimestamp.toDate();
        formattedExpiryDate = DateFormat('dd/MM/yyyy').format(expiryDate);

        Timestamp? checkinTimestamp = userSnapshot['checkin'];
        Timestamp? checkoutTimestamp = userSnapshot['checkout'];
        checkinTime = checkinTimestamp != null
            ? DateFormat('h:mm a').format(checkinTimestamp.toDate())
            : '';
        checkoutTime = checkoutTimestamp != null
            ? DateFormat('h:mm a').format(checkoutTimestamp.toDate())
            : '';
      });
    }
  }

  void fetchAttendanceData() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      QuerySnapshot<Map<String, dynamic>> attendanceSnapshot =
          await FirebaseFirestore.instance
              .collection('personal_info')
              .doc(user.uid)
              .collection('attendance')
              .get();

      setState(() {
        attendanceData = Map.fromEntries(attendanceSnapshot.docs.map(
          (doc) => MapEntry(doc.id, doc['marked']),
        ));
      });
    }
  }

  bool isDayFilled(DateTime date) {
    String formattedDate = DateFormat('yyyy-MM-dd').format(date);
    return attendanceData.containsKey(formattedDate) &&
        attendanceData[formattedDate] == true;
  }

  void markAttendance(DateTime date) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(date);
      await FirebaseFirestore.instance
          .collection('personal_info')
          .doc(user.uid)
          .collection('attendance')
          .doc(formattedDate)
          .set({'marked': true});
      setState(() {
        attendanceData[formattedDate] = true;
      });
    }
  }

  void unmarkAttendance(DateTime date) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(date);
      await FirebaseFirestore.instance
          .collection('personal_info')
          .doc(user.uid)
          .collection('attendance')
          .doc(formattedDate)
          .delete();
      setState(() {
        attendanceData.remove(formattedDate);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        actions: [
          InkWell(
            borderRadius: BorderRadius.circular(50),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NotificationPage(),
                ),
              );
            },
            child: Icon(Icons.notifications, color: Colors.white),
          ),
        ],
        leading: InkWell(
          borderRadius: BorderRadius.circular(50),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProfilePage(),
              ),
            );
          },
          child: Icon(
            Icons.person,
            color: Colors.white,
          ),
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
                    color: Colors.white10,
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
                            "Expiry: $formattedExpiryDate",
                            style: AppFonts.secondaryText(context),
                          ),
                        ],
                      ),
                      Text(
                        membershipName,
                        style: fontStyle(50, Colors.white, FontWeight.w900),
                      ),
                      SizedBox(height: 10),
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
                      color: Colors.white10,
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
                            checkinTime,
                            style: AppFonts.secondaryText(context),
                          ),
                          Text(
                            checkoutTime,
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
                      color: Colors.white10,
                      borderRadius: BorderRadius.all(Radius.circular(12))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Attendance",
                        style: AppFonts.primaryText(context),
                      ),
                      SizedBox(height: 15),
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
                        selectedDayPredicate: (day) => isDayFilled(day),
                        onDaySelected: (selectedDay, focusedDay) {
                          setState(() {
                            _selectedDay = selectedDay;
                            _focusedDay = focusedDay;
                          });
                        },
                        onDayLongPressed: (selectedDay, focusedDay) {
                          setState(() {
                            if (isDayFilled(selectedDay)) {
                              // If the day is already filled, unfill it
                              unmarkAttendance(selectedDay);
                            } else {
                              // If the day is not filled, mark it
                              markAttendance(selectedDay);
                            }
                          });
                        },
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 30),
                  padding: EdgeInsets.all(15),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.white10,
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
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FloatingActionButton(
          backgroundColor: Color(0xff39FF14),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => QRScanPage()),
            );
          },
          child: Icon(
            Icons.qr_code,
            size: 30,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
