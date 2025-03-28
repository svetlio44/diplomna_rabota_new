import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diplomna_rabota_new/pages/forgot_password.dart';
import 'package:diplomna_rabota_new/pages/register.dart';
import 'package:diplomna_rabota_new/pages/tabs.dart'; // Ensure this contains TabsExampleJobSeeker
import 'package:diplomna_rabota_new/widget/elevated_button.dart';
import 'package:diplomna_rabota_new/widget/text_btn.dart';
import 'package:diplomna_rabota_new/jobseeker/tabsSeeker.dart';
import '../components/styles.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  static const String id = 'Login';

  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  bool _rememberMe = false;

  // ... keep existing initState and _checkRememberMe methods ...

  Future<void> _loginUser() async {
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields')),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      if (userCredential.user != null) {
        // Get user document from Firestore
        DocumentSnapshot userDoc = await _firestore
            .collection('users')
            .doc(userCredential.user!.uid)
            .get();

        if (!userDoc.exists) {
          throw Exception('User document not found');
        }

        // Get user role with default fallback
        final role = userDoc.get('role') as String? ?? 'job_seeker';

        // Save preferences
        try {
          if (_rememberMe) {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            await prefs.setBool('rememberMe', true);
            await prefs.setString('email', _emailController.text.trim());
            await prefs.setString('password', _passwordController.text.trim());
          } else {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            await prefs.remove('rememberMe');
            await prefs.remove('email');
            await prefs.remove('password');
          }
        } catch (e) {
          print('Error saving preferences: $e');
        }

        // Navigate based on role
        if (role == 'job_seeker') {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => TabsExampleJobSeeker()),
          );
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => TabsExample()),
          );
        }
      }
    } on FirebaseAuthException catch (e) {
      String errorMessage = 'An error occurred';
      if (e.code == 'user-not-found') {
        errorMessage = 'No user found for that email';
      } else if (e.code == 'wrong-password') {
        errorMessage = 'Wrong password provided for that user';
      } else if (e.code == 'network-request-failed') {
        errorMessage = 'Network error. Please check your connection';
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
    } catch (e) {
      print('Error during login: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('An unexpected error occurred')),
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
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black54),
        elevation: 0,
      ),
      bottomNavigationBar: bottomNav(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              blackHeading('Login'),
              SizedBox(height: 20),
              TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'Your Email',
                  border: UnderlineInputBorder(),
                ),
              ),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: UnderlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Checkbox(
                        value: _rememberMe,
                        onChanged: (value) {
                          setState(() {
                            _rememberMe = value!;
                          });
                        },
                      ),
                      Text('Remember Me'),
                    ],
                  ),
                  MyTextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const ForgotPassword()),
                      );
                    },
                    text: 'Forgot password?',
                    colors: Colors.black,
                  ),
                ],
              ),
              SizedBox(height: 30),
              _isLoading
                  ? Center(child: CircularProgressIndicator())
                  : MyElevatedButton(
                  onPressed: _loginUser,
                  colors: appColorBtn,
                  text: 'Login'),
            ],
          ),
        ),
      ),
    );
  }

  bottomNav() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        greyText("Don't have an account?"),
        MyTextButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Register()));
            },
            colors: Colors.black,
            text: "Sign Up")
      ],
    );
  }
}