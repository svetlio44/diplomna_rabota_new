import 'package:flutter/material.dart';
import 'package:diplomna_rabota_new/pages/tabs.dart';
import 'package:diplomna_rabota_new/widget/elevated_button.dart';
import '../components/styles.dart';

class EditProfile extends StatefulWidget {
  final String role;
  static const String id = 'EditProfile';

  const EditProfile({Key? key, required this.role}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_horiz, color: Colors.black),
          ),
        ],
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black54),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Edit Profile',
          style: TextStyle(color: Colors.black, fontFamily: 'medium'),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                children: [
                  Container(
                    child: const CircleAvatar(
                      backgroundImage: AssetImage('assets/images/39.jpg'),
                      radius: 55,
                    ),
                  ),
                  Positioned(
                    bottom: 3,
                    right: 0,
                    child: CircleAvatar(
                      radius: 14,
                      backgroundColor: appColorBtn,
                      child: const Icon(
                        Icons.edit_outlined,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              textField('Your Name'),
              textField('Your Email'),
              textField('Phone Number'),
              textField('Ads Count'),
              const SizedBox(height: 30),
              MyElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      // Use widget.role to access the passed parameter
                      builder: (context) => TabsExample(role: widget.role),
                    ),
                  );
                },
                colors: appColorBtn,
                text: 'Save changes',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget textField(String hint) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextField(
        decoration: InputDecoration(
          labelText: hint,
          labelStyle: const TextStyle(color: Colors.black54, fontSize: 12),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: appColor),
          ),
        ),
      ),
    );
  }
}