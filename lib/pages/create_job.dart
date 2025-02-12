import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class CreateJobScreen extends StatefulWidget {
  @override
  _CreateJobScreenState createState() => _CreateJobScreenState();
}

class _CreateJobScreenState extends State<CreateJobScreen> {
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _jobTypeController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  File? _image;

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<String?> _uploadImage(File image) async {
    try {
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      Reference ref = FirebaseStorage.instance.ref().child('job_images/$fileName');
      UploadTask uploadTask = ref.putFile(image);
      TaskSnapshot snapshot = await uploadTask;
      return await snapshot.ref.getDownloadURL();
    } catch (e) {
      print("Image upload failed: $e");
      return null;
    }
  }

  Future<void> _submitJob() async {
    if (_locationController.text.isEmpty ||
        _timeController.text.isEmpty ||
        _jobTypeController.text.isEmpty ||
        _priceController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Моля, попълнете всички полета")),
      );
      return;
    }

    String? imageUrl;
    if (_image != null) {
      imageUrl = await _uploadImage(_image!);
    }

    await FirebaseFirestore.instance.collection('jobs').add({
      'location': _locationController.text,
      'time': _timeController.text,
      'jobType': _jobTypeController.text,
      'price': _priceController.text,
      'imageUrl': imageUrl,
      'createdAt': Timestamp.now(),
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Заявката е публикувана успешно!")),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Създай заявка")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _locationController,
              decoration: InputDecoration(labelText: "Локация"),
            ),
            TextField(
              controller: _timeController,
              decoration: InputDecoration(labelText: "Време"),
            ),
            TextField(
              controller: _jobTypeController,
              decoration: InputDecoration(labelText: "Тип работа"),
            ),
            TextField(
              controller: _priceController,
              decoration: InputDecoration(labelText: "Цена"),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 10),
            _image == null
                ? Text("Няма избрана снимка")
                : Image.file(_image!, height: 100),
            ElevatedButton(
              onPressed: _pickImage,
              child: Text("Качи снимка"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitJob,
              child: Text("Публикувай заявката"),
            ),
          ],
        ),
      ),
    );
  }
}

//
// ElevatedButton(
// onPressed: () {
// Navigator.push(
// context,
// MaterialPageRoute(builder: (context) => CreateJobScreen()),
// );
// },
// child: Text("Създай заявка"),
// );