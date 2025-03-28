
import 'package:flutter/material.dart';
import '../components/styles.dart';

class Notifications_Seeker extends StatefulWidget {
  static const String id = 'Notifications';

  const Notifications_Seeker({Key? key}) : super(key: key);

  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications_Seeker> {
  List<Map<String, String>> notifications = [
    {
      'title': 'New Bid',
      'description': 'Someone has placed a new bid on your ads.',
      'time': '5 minutes ago'
    },
    {
      'title': 'Item Liked',
      'description': 'Someone liked your ads.',
      'time': '10 minutes ago'
    },
    {
      'title': 'New Message',
      'description': 'You have a new message.',
      'time': '15 minutes ago'
    },
    {
      'title': 'New Bid',
      'description': 'Someone',
      'time': '20 minutes ago'
    }
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          // actions: [
          //   IconButton(onPressed: () {}, icon: Icon(Icons.more_horiz)),
          // ],
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black54),
          elevation: 0,
          centerTitle: true,
          title: Text('Notifications',
              style: TextStyle(color: Colors.black, fontFamily: 'medium')),
        ),
        body: ListView.builder(
          itemCount: notifications.length,
          itemBuilder: (context, index) {
            final notification = notifications[index];
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: ListTile(
                title: Text(notification['title'] ?? 'No title'),
                subtitle: Text(notification['description'] ?? 'No description'),
                trailing: Text(notification['time'] ?? 'No time'),
              ),
            );
          },
        ));
  }
}