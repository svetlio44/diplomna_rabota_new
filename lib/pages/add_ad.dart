import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddAd extends StatefulWidget {
  static const String id = 'AddAd';

  const AddAd({Key? key}) : super(key: key);

  @override
  _AddAdState createState() => _AddAdState();
}

class _AddAdState extends State<AddAd> {
  final _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String _title = '';
  String _description = '';
  String _price = '';
  String _phoneNumber = '';
  String _email = '';
  bool _isLoading = false;

  Future<void> _submitAd() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);

    try {
      final user = _auth.currentUser;
      if (user == null) {
        throw Exception('User not logged in');
      }

      _formKey.currentState!.save();

      await _firestore.collection('ads').add({
        'title': _title,
        'description': _description,
        'price': _price,
        'phoneNumber': _phoneNumber,
        'email': _email,
        'userId': user.uid,
        'createdAt': Timestamp.now(),
        'status': 'active', // Add this field
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Ad posted successfully!')),
      );
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create New Ad'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 20),
                _buildFormFields(),
                const SizedBox(height: 30),
                _buildSubmitButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFormFields() {
    return Column(
      children: [
        _buildTextField(
          label: 'Title',
          icon: Icons.title,
          onSaved: (v) => _title = v!,
          validator: (v) => v!.isEmpty ? 'Enter title' : null,
        ),
        _buildTextField(
          label: 'Description',
          icon: Icons.description,
          onSaved: (v) => _description = v!,
          validator: (v) => v!.isEmpty ? 'Enter description' : null,
        ),
        _buildTextField(
          label: 'Price',
          icon: Icons.attach_money,
          keyboardType: TextInputType.number,
          onSaved: (v) => _price = v!,
          validator: (v) => v!.isEmpty ? 'Enter price' : null,
        ),
        _buildTextField(
          label: 'Phone Number',
          icon: Icons.phone,
          keyboardType: TextInputType.phone,
          onSaved: (v) => _phoneNumber = v!,
          validator: (v) => v!.isEmpty ? 'Enter phone number' : null,
        ),
        _buildTextField(
          label: 'Email',
          icon: Icons.email,
          keyboardType: TextInputType.emailAddress,
          onSaved: (v) => _email = v!,
          validator: (v) => !v!.contains('@') ? 'Enter valid email' : null,
        ),
      ],
    );
  }

  Widget _buildTextField({
    required String label,
    required IconData icon,
    required FormFieldSetter<String> onSaved,
    required FormFieldValidator<String> validator,
    TextInputType? keyboardType,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        keyboardType: keyboardType,
        onSaved: onSaved,
        validator: validator,
      ),
    );
  }

  Widget _buildSubmitButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        icon: _isLoading
            ? const CircularProgressIndicator(color: Colors.white)
            : const Icon(Icons.upload),
        label: Text(_isLoading ? 'Submitting...' : 'Submit Ad'),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: _isLoading ? null : _submitAd,
      ),
    );
  }
}