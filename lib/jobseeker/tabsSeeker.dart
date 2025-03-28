import 'package:flutter/material.dart';
import 'package:diplomna_rabota_new/jobseeker/home_seeker.dart';
import 'package:diplomna_rabota_new/jobseeker/message_seeker.dart';
import 'package:diplomna_rabota_new/jobseeker/my_profile_seeker.dart';
import '../components/styles.dart' as style;

class TabsExampleJobSeeker extends StatefulWidget {
  final String role;  // Add this
  const TabsExampleJobSeeker({Key? key, required this.role}) : super(key: key);

  @override
  _TabsExampleJobSeekerState createState() => _TabsExampleJobSeekerState();
}

class _TabsExampleJobSeekerState extends State<TabsExampleJobSeeker> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.white,
        bottomNavigationBar: TabBar(
          labelColor: style.appColor,
          unselectedLabelColor: const Color.fromARGB(255, 185, 196, 207),
          indicatorColor: Colors.transparent,
          labelPadding: const EdgeInsets.symmetric(horizontal: 0),
          labelStyle: const TextStyle(
            fontFamily: 'regular',
            fontSize: 12,
          ),
          onTap: (int index) => setState(() => _currentIndex = index),
          tabs: [
            Tab(
              icon: Icon(Icons.flash_on,
                  color: _currentIndex == 0
                      ? style.appColorBtn
                      : const Color.fromARGB(255, 185, 196, 207)),
            ),
            Tab(
              icon: Icon(Icons.messenger_outline,
                  color: _currentIndex == 1
                      ? style.appColorBtn
                      : const Color.fromARGB(255, 185, 196, 207)),
            ),
            Tab(
              icon: Icon(Icons.person,
                  color: _currentIndex == 2
                      ? style.appColorBtn
                      : const Color.fromARGB(255, 185, 196, 207)),
            ),
          ],
        ),
        body: const TabBarView(
          physics: NeverScrollableScrollPhysics(),
          children: [
            Home_Seeker(),
            Notifications_Seeker(),
            MyProfile_Seeker(),
          ],
        ),
      ),
    );
  }
}