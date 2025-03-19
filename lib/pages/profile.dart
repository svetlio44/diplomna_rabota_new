import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  static const String id = 'Profile';

  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String _name = 'John Doe';
  String _email = 'john.doe@example.com';
  String _phone = '123-456-7890';
  String _age = '25';
  // примерни данни
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Name:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            Text(_name),
            SizedBox(height: 20),
            Text(
              'Email:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            Text(_email),
            SizedBox(height: 20),
            Text(
              'Phone:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            Text(_phone),
            SizedBox(height: 20),
            Text(
              'Age:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            Text(_age),
            SizedBox(height: 20),
            // ElevatedButton(
            //   onPressed: () {
            //     Navigator.pushNamed(context, 'EditProfile');
            //   },
            //   child: Text('Edit Profile'),
            // ),
          ],
        ),
      ),
    );
  }
}