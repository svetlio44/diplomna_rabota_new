import 'package:flutter/material.dart';
import 'package:diplomna_rabota_new/pages/change_password.dart'; // Добавете този ред

class Profile extends StatefulWidget {
  static const String id = 'Profile';

  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final _formKey = GlobalKey<FormState>();
  String _name = 'John Doe';
  String _email = 'john.doe@example.com';
  String _phone = '123-456-7890';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                initialValue: _name,
                decoration: InputDecoration(labelText: 'Name'),
                onSaved: (value) {
                  _name = value!;
                },
              ),
              TextFormField(
                initialValue: _email,
                decoration: InputDecoration(labelText: 'Email'),
                onSaved: (value) {
                  _email = value!;
                },
              ),
              TextFormField(
                initialValue: _phone,
                decoration: InputDecoration(labelText: 'Phone'),
                onSaved: (value) {
                  _phone = value!;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    // Save the profile information to the database or perform other actions
                  }
                },
                child: Text('Save Changes'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, ChangePassword.id);
                },
                child: Text('Change Password'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}