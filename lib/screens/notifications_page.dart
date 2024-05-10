import 'package:flutter/material.dart';
import 'package:gymapp/utils.dart';

// Define NotificationModel class
class NotificationModel {
  final String text;
  final DateTime date;

  NotificationModel({
    required this.text,
    required this.date,
  });
}

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  // Sample list of notifications
  final List<NotificationModel> notifications = [
    NotificationModel(
      text: 'Your membership is expiring soon.',
      date: DateTime.now().add(Duration(days: 7)), // Example date
    ),
    // Add more sample notifications as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      body: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final notification = notifications[index];
          return ListTile(
            title:
                Text(notification.text, style: AppFonts.primaryText(context)),
            trailing: Text(
              '${notification.date.day}/${notification.date.month}/${notification.date.year}',
              style: AppFonts.secondaryText(context),
            ),
          );
        },
      ),
    );
  }
}
