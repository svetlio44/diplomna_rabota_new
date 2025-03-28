import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:diplomna_rabota_new/pages/welcome.dart';
import 'package:diplomna_rabota_new/pages/tabs.dart';
import 'package:diplomna_rabota_new/jobseeker/tabsSeeker.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp();
    await _handleAutoLogin();
  } catch (e) {
    print('Error initializing app: $e');
  }

  runApp(const MyApp());
}

Future<void> _handleAutoLogin() async {
  final prefs = await SharedPreferences.getInstance();
  final rememberMe = prefs.getBool('rememberMe') ?? false;
  final email = prefs.getString('email');
  final password = prefs.getString('password');

  if (rememberMe && email != null && password != null) {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      await prefs.remove('rememberMe');
      await prefs.remove('email');
      await prefs.remove('password');
    }
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, authSnapshot) {
        if (authSnapshot.connectionState == ConnectionState.waiting) {
          return _loadingScreen();
        }

        if (!authSnapshot.hasData) {
          return _unauthenticatedApp();
        }

        return FutureBuilder<DocumentSnapshot>(
          future: FirebaseFirestore.instance
              .collection('users')
              .doc(authSnapshot.data!.uid)
              .get(),
          builder: (context, userSnapshot) {
            if (userSnapshot.connectionState == ConnectionState.waiting) {
              return _loadingScreen();
            }

            if (!userSnapshot.hasData || !userSnapshot.data!.exists) {
              FirebaseAuth.instance.signOut();
              return _unauthenticatedApp();
            }

            final role = userSnapshot.data!.get('role') as String? ?? 'job_seeker';

            return MaterialApp(
              title: 'Social Network 2',
              debugShowCheckedModeBanner: false,
              theme: _appTheme(),
              home: role == 'job_seeker'
                  ? TabsExampleJobSeeker(role: role)
                  : TabsExample(role: role),
              onGenerateRoute: _generateRoute,
            );
          },
        );
      },
    );
  }

  Widget _loadingScreen() => MaterialApp(
    home: Scaffold(
      body: Center(child: CircularProgressIndicator()),
    ),
  );

  Widget _unauthenticatedApp() => MaterialApp(
    home: Welcome(),
    onGenerateRoute: _generateRoute,
    theme: _appTheme(),
  );

  ThemeData _appTheme() => ThemeData(
    fontFamily: "regular",
    primaryColor: Colors.blue, // Replace with your actual color
  );

  Route? _generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Welcome.id:
        return _buildPageRoute(const Welcome());
    // Add other routes here
      default:
        return _buildPageRoute(const Welcome());
    }
  }

  PageRouteBuilder _buildPageRoute(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.ease;
        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);
        return SlideTransition(position: offsetAnimation, child: child);
      },
    );
  }
}