import 'package:flutter/material.dart';

class ChangePassword extends StatefulWidget {
  static const String id = 'ChangePassword';

  const ChangePassword({Key? key}) : super(key: key);

  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final _formKey = GlobalKey<FormState>();
  String _oldPassword = '';
  String _newPassword = '';
  String _confirmPassword = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Change Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'Old Password'),
                obscureText: true,
                onSaved: (value) {
                  _oldPassword = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'New Password'),
                obscureText: true,
                onSaved: (value) {
                  _newPassword = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Confirm Password'),
                obscureText: true,
                onSaved: (value) {
                  _confirmPassword = value!;
                },
                validator: (value) {
                  if (value != _newPassword) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    // Implement password change functionality here
                  }
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