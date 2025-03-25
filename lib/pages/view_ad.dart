import 'package:flutter/material.dart';
import 'dart:io';

class ViewAd extends StatelessWidget {
  static const String id = 'ViewAd';

  final String title;
  final String description;
  final String price;
  final String phoneNumber;
  final String email;
  final String? imagePath;

  const ViewAd({
    Key? key,
    required this.title,
    required this.description,
    required this.price,
    required this.phoneNumber,
    required this.email,
    this.imagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('View Ad'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Връща назад към предходната страница
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                description,
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 10),
              Text(
                'Price: $price',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                'Phone Number: $phoneNumber',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 10),
              Text(
                'Email: $email',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 10),
              imagePath != null && imagePath!.isNotEmpty
                  ? Image.file(File(imagePath!))
                  : Text('No image available'),
            ],
          ),
        ),
      ),
    );
  }
}