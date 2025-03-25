import 'package:flutter/material.dart';
import 'package:diplomna_rabota_new/pages/login.dart';
import 'package:diplomna_rabota_new/widget/elevated_button.dart';
import 'package:diplomna_rabota_new/widget/text_btn.dart';
import '../components/styles.dart';

class Register extends StatefulWidget {
  static const String id = 'Register';

  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String _selectedRole = 'job_seeker'; // Default value

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black87),
        elevation: 0,
      ),
      bottomNavigationBar: bottomNav(),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              blackHeading('Sign up'),
              textField('Your Email', Icons.check),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(child: textField('First Name', Icons.check)),
                  Expanded(child: textField('Last Name', Icons.check))
                ],
              ),
              textField('Phone', Icons.check),
              textField('Password', Icons.remove_red_eye),
              SizedBox(height: 20),
              Text(
                'Register as:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              ListTile(
                title: Text('Job Seeker'),
                leading: Radio<String>(
                  value: 'job_seeker',
                  groupValue: _selectedRole,
                  onChanged: (String? value) {
                    setState(() {
                      _selectedRole = value!;
                    });
                  },
                ),
              ),
              ListTile(
                title: Text('Job Provider'),
                leading: Radio<String>(
                  value: 'job_provider',
                  groupValue: _selectedRole,
                  onChanged: (String? value) {
                    setState(() {
                      _selectedRole = value!;
                    });
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      padding:
                      EdgeInsets.symmetric(horizontal: 36, vertical: 16),
                      child: Text(
                        'By signing up you agree to our Terms of use and Privacy Policy',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.black45, fontSize: 12),
                      ),
                    ),
                  )
                ],
              ),
              MyElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Login()));
                  },
                  colors: appColorBtn,
                  text: 'Sign up'),
              Container(
                padding: EdgeInsets.symmetric(vertical: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [greyText('Or sign up with social account')],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: imageButton('assets/images/apple.png', 'Apple'),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: imageButton('assets/images/google.png', 'Google'),
                  ),
                ],
              ),
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
        greyText("Already have account?"),
        MyTextButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Register()));
            },
            colors: Colors.black,
            text: "Log in")
      ],
    );
  }

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