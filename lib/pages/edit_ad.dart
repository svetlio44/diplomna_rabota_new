import 'package:flutter/material.dart';

class EditAd extends StatefulWidget {
  static const String id = 'EditAd';

  final String title;
  final String description;
  final String price;
  final String imagePath;
  final String phoneNumber;
  final String email;

  const EditAd({
    Key? key,
    required this.title,
    required this.description,
    required this.price,
    required this.imagePath,
    required this.phoneNumber,
    required this.email,
  }) : super(key: key);

  @override
  _EditAdState createState() => _EditAdState();
}

class _EditAdState extends State<EditAd> {
  final _formKey = GlobalKey<FormState>();
  late String _title;
  late String _description;
  late String _price;
  late String _imagePath;
  late String _phoneNumber;
  late String _email;

  @override
  void initState() {
    super.initState();
    _title = widget.title;
    _description = widget.description;
    _price = widget.price;
    _imagePath = widget.imagePath;
    _phoneNumber = widget.phoneNumber;
    _email = widget.email;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Ad'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                initialValue: _title,
                decoration: InputDecoration(labelText: 'Title'),
                onSaved: (value) {
                  _title = value!;
                },
              ),
              TextFormField(
                initialValue: _description,
                decoration: InputDecoration(labelText: 'Description'),
                onSaved: (value) {
                  _description = value!;
                },
              ),
              TextFormField(
                initialValue: _price,
                decoration: InputDecoration(labelText: 'Price'),
                onSaved: (value) {
                  _price = value!;
                },
              ),
              TextFormField(
                initialValue: _phoneNumber,
                decoration: InputDecoration(labelText: 'Phone Number'),
                onSaved: (value) {
                  _phoneNumber = value!;
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
                initialValue: _imagePath,
                decoration: InputDecoration(labelText: 'Image Path'),
                onSaved: (value) {
                  _imagePath = value!;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    // Save the edited ad to the database or perform other actions
                  }
                },
                child: Text('Save Changes'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}