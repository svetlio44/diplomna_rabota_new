import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:diplomna_rabota_new/pages/forgot_password.dart';
import 'package:diplomna_rabota_new/pages/register.dart';
import 'package:diplomna_rabota_new/pages/tabs.dart';
import 'package:diplomna_rabota_new/widget/elevated_button.dart';
import 'package:diplomna_rabota_new/widget/text_btn.dart';
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
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  bool _rememberMe = false;

  @override
  void initState() {
    super.initState();
    _checkRememberMe();
  }

  Future<void> _checkRememberMe() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      bool? rememberMe = prefs.getBool('rememberMe');
      String? savedEmail = prefs.getString('email');
      String? savedPassword = prefs.getString('password');

      if (rememberMe == true && savedEmail != null && savedPassword != null) {
        setState(() {
          _rememberMe = true;
          _emailController.text = savedEmail;
          _passwordController.text = savedPassword;
        });
      }
    } catch (e) {
      print('Error retrieving preferences: $e');
      // Clear preferences if there's an error
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.clear();
    }
  }

  Future<void> _loginUser() async {
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill in all fields')),
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

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => TabsExample()),
        );
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
        SnackBar(content: Text('An unexpected error occurred')),
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