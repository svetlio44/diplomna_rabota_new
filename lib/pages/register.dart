import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diplomna_rabota_new/pages/login.dart';
import 'package:diplomna_rabota_new/widget/elevated_button.dart';
import 'package:diplomna_rabota_new/widget/text_btn.dart';
import '../components/styles.dart';

// Registration page for new users
class Register extends StatefulWidget {
  static const String id = 'Register';

  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

// State class for the registration page
class _RegisterState extends State<Register> {
  // Form key for validation
  final _formKey = GlobalKey<FormState>();

  // Firebase instances
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  // User role selection
  String _selectedRole = 'job_seeker';

  // Late-initialized user input fields
  late String _email;
  late String _password;
  late String _firstName;
  late String _lastName;
  late String _phone;

  // Text controllers for form fields
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  // Loading state management
  bool _isLoading = false;

  // Password visibility toggle
  bool _isPasswordVisible = false;

  // Function to handle user registration
  Future<void> _registerUser() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      // Create user with email and password
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      // Send email verification
      await userCredential.user!.sendEmailVerification();

      // Save additional user data to Firestore
      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        'email': _emailController.text.trim(),
        'firstName': _firstNameController.text.trim(),
        'lastName': _lastNameController.text.trim(),
        'phone': _phoneController.text.trim(),
        'role': _selectedRole,
        'createdAt': FieldValue.serverTimestamp(),
        'emailVerified': false,
      });

      // Show success dialog
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          title: Text('Success!'),
          content: Text('A verification email has been sent to ${_emailController.text}. Please check your inbox.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            )
          ],
        ),
      );

      // Redirect to login page after 3 seconds
      Future.delayed(Duration(seconds: 3), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Login()),
        );
      });

    } on FirebaseAuthException catch (e) {
      // Handle Firebase authentication errors
      String errorMessage = 'Registration failed. Please try again.';
      if (e.code == 'weak-password') {
        errorMessage = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        errorMessage = 'An account already exists for that email.';
      } else if (e.code == 'invalid-email') {
        errorMessage = 'The email address is invalid.';
      } else if (e.code == 'network-request-failed') {
        errorMessage = 'Network error. Please check your internet connection.';
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
    } catch (e) {
      // Handle general errors
      print('Error during registration: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An unexpected error occurred. Please try again.')),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        // App bar configuration
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black87),
        elevation: 0,
      ),
      // Bottom navigation bar
      bottomNavigationBar: bottomNav(),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Page heading
                blackHeading('Sign up'),

                // Email input field
                _buildEmailField(),

                // First name and last name input fields in a row
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded(child: _buildFirstNameField()),
                    Expanded(child: _buildLastNameField())
                  ],
                ),

                // Phone number input field
                _buildPhoneField(),

                // Password input field with visibility toggle
                _buildPasswordField(),

                SizedBox(height: 20),

                // User role selection section
                Text(
                  'Register as:',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                _buildRoleRadio('Job Seeker', 'job_seeker'),
                _buildRoleRadio('Job Provider', 'job_provider'),

                // Terms and conditions text
                _termsAndConditions(),

                // Registration button
                _isLoading
                    ? Center(child: CircularProgressIndicator())
                    : MyElevatedButton(
                    onPressed: _registerUser,
                    colors: appColorBtn,
                    text: 'Sign up'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Build email input field
  Widget _buildEmailField() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        controller: _emailController,
        keyboardType: TextInputType.emailAddress,
        decoration: _inputDecoration('Your Email', Icons.check),
        validator: (value) {
          if (value == null || value.isEmpty) return 'Please enter email';
          if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
            return 'Please enter a valid email';
          }
          return null;
        },
      ),
    );
  }

  // Build first name input field
  Widget _buildFirstNameField() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        controller: _firstNameController,
        decoration: _inputDecoration('First Name', Icons.check),
        validator: (value) {
          if (value == null || value.isEmpty) return 'Please enter first name';
          return null;
        },
      ),
    );
  }

  // Build last name input field
  Widget _buildLastNameField() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        controller: _lastNameController,
        decoration: _inputDecoration('Last Name', Icons.check),
        validator: (value) {
          if (value == null || value.isEmpty) return 'Please enter last name';
          return null;
        },
      ),
    );
  }

  // Build phone number input field
  Widget _buildPhoneField() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        controller: _phoneController,
        keyboardType: TextInputType.phone,
        decoration: _inputDecoration('Phone', Icons.check),
        validator: (value) {
          if (value == null || value.isEmpty) return 'Please enter phone number';
          return null;
        },
      ),
    );
  }

  // Build password input field with visibility toggle
  Widget _buildPasswordField() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        controller: _passwordController,
        obscureText: !_isPasswordVisible,
        decoration: _inputDecoration(
          'Password',
          Icons.remove_red_eye,
          suffixIcon: IconButton(
            icon: Icon(_isPasswordVisible
                ? Icons.visibility
                : Icons.visibility_off),
            onPressed: () {
              setState(() {
                _isPasswordVisible = !_isPasswordVisible;
              });
            },
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) return 'Please enter password';
          if (value.length < 6) return 'Password must be at least 6 characters';
          return null;
        },
      ),
    );
  }

  // Create input decoration with optional suffix icon
  InputDecoration _inputDecoration(String label, IconData icon, {Widget? suffixIcon}) {
    return InputDecoration(
      labelText: label,
      suffixIcon: suffixIcon ?? Icon(icon),
      labelStyle: TextStyle(color: Colors.black54, fontSize: 12),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: appColor),
      ),
    );
  }

  // Build radio button for role selection
  Widget _buildRoleRadio(String title, String value) {
    return ListTile(
      title: Text(title),
      leading: Radio<String>(
        value: value,
        groupValue: _selectedRole,
        onChanged: (String? value) {
          setState(() => _selectedRole = value!);
        },
      ),
    );
  }

  // Build terms and conditions text
  Widget _termsAndConditions() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 36, vertical: 16),
            child: Text(
              'By signing up you agree to our Terms of use and Privacy Policy',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black45, fontSize: 12),
            ),
          ),
        )
      ],
    );
  }

  // Bottom navigation bar with login link
  bottomNav() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        greyText("Already have account?"),
        MyTextButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Login()));
            },
            colors: Colors.black,
            text: "Log in")
      ],
    );
  }

  // Image button widget (not currently used)
  imageButton(image, name) {
    return ElevatedButton.icon(
      icon: Image.asset(
        image,
        width: 24,
        height: 24,
      ),
      label: Text(name),
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.black, backgroundColor: Colors.white,
        shadowColor: Colors.black38,
        elevation: 5,
        padding: EdgeInsets.all(16),
        shape: (RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        )),
      ),
    );
  }

  // Text field widget (not currently used)
  Widget textField(String hint, IconData icon) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: TextField(
        decoration: InputDecoration(
          labelText: hint,
          suffixIcon: Icon(icon),
          labelStyle: TextStyle(color: Colors.black54, fontSize: 12),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: appColor),
          ),
        ),
      ),
    );
  }
}