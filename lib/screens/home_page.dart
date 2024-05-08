import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gymapp/utils.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
                    borderRadius: BorderRadius.all(Radius.circular(12))),
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
                          "Expiry: 12/05/23",
                          style: AppFonts.secondaryText(context),
                        ),
                      ],
                    ),
                    Text(
                      "Tier 1",
                      style: fontStyle(50, Colors.white, FontWeight.w900),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        InkWell(
                          borderRadius: BorderRadius.circular(100),
                          onTap: () {},
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
                              style:
                                  fontStyle(12, Colors.white, FontWeight.w100),
                            ),
                          ),
                        ),
                        InkWell(
                          borderRadius: BorderRadius.circular(100),
                          onTap: () {},
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 12),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              border: Border.all(color: Color(0xff39FF14)),
                            ),
                            child: Text(
                              "Upgrade",
                              style:
                                  fontStyle(12, Colors.white, FontWeight.w100),
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
                              style:
                                  fontStyle(12, Colors.white, FontWeight.w100),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
