import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:diplomna_rabota_new/pages/welcome.dart';
import 'package:diplomna_rabota_new/pages/add_ad.dart';
import 'package:diplomna_rabota_new/pages/view_ad.dart';
import 'package:diplomna_rabota_new/pages/edit_ad.dart';
import 'package:diplomna_rabota_new/pages/ads_list.dart';
import 'package:diplomna_rabota_new/pages/delete_ad.dart';
import 'package:diplomna_rabota_new/pages/search_ads.dart';
import 'package:diplomna_rabota_new/pages/profile.dart';
import 'package:diplomna_rabota_new/pages/change_password.dart';
import 'package:diplomna_rabota_new/pages/tabs.dart'; // Import TabsExample
import '../components/styles.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? rememberMe = prefs.getBool('rememberMe');
    String? email = prefs.getString('email');
    String? password = prefs.getString('password');

    if (rememberMe == true && email != null && password != null) {
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
      } catch (e) {
        prefs.remove('rememberMe');
        prefs.remove('email');
        prefs.remove('password');
      }
    }
  } catch (e) {
    print('Error initializing app: $e');
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // Check if the authentication process is still loading
        if (snapshot.connectionState == ConnectionState.waiting) {
          return MaterialApp(
            home: Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        }

        // User is authenticated, navigate to TabsExample
        if (snapshot.hasData) {
          print('User is authenticated, navigating to TabsExample');
          return MaterialApp(
            title: 'Social Network 2',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              fontFamily: "regular",
              primaryColor: appColor,
            ),
            home: TabsExample(), // Navigate to TabsExample when authenticated
            onGenerateRoute: (settings) {
              switch (settings.name) {
                case Welcome.id:
                  return _buildPageRoute(const Welcome());
                case AddAd.id:
                  return _buildPageRoute(const AddAd());
                case ViewAd.id:
                  final args = settings.arguments as Map<String, dynamic>;
                  return _buildPageRoute(ViewAd(
                    title: args['title'],
                    description: args['description'],
                    price: args['price'],
                    imagePath: args['imagePath'],
                    phoneNumber: args['phoneNumber'],
                    email: args['email'],
                  ));
                case EditAd.id:
                  final args = settings.arguments as Map<String, dynamic>;
                  return _buildPageRoute(EditAd(
                    title: args['title'],
                    description: args['description'],
                    price: args['price'],
                    imagePath: args['imagePath'],
                    phoneNumber: args['phoneNumber'],
                    email: args['email'],
                  ));
                case AdsList.id:
                  return _buildPageRoute(const AdsList());
                case DeleteAd.id:
                  final args = settings.arguments as Map<String, dynamic>;
                  return _buildPageRoute(DeleteAd(
                    title: args['title'],
                    description: args['description'],
                    price: args['price'],
                  ));
                case SearchAds.id:
                  return _buildPageRoute(const SearchAds());
                case Profile.id:
                  return _buildPageRoute(const Profile());
                case ChangePassword.id:
                  return _buildPageRoute(const ChangePassword());
                default:
                  return _buildPageRoute(const Welcome());
              }
            },
          );
        }

        // User is not authenticated, show welcome/login screen
        print('User is not authenticated, showing welcome screen');
        return MaterialApp(
          title: 'Social Network 2',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            fontFamily: "regular",
            primaryColor: appColor,
          ),
          initialRoute: Welcome.id,
          onGenerateRoute: (settings) {
            switch (settings.name) {
              case Welcome.id:
                return _buildPageRoute(const Welcome());
              case AddAd.id:
                return _buildPageRoute(const AddAd());
              case ViewAd.id:
                final args = settings.arguments as Map<String, dynamic>;
                return _buildPageRoute(ViewAd(
                  title: args['title'],
                  description: args['description'],
                  price: args['price'],
                  imagePath: args['imagePath'],
                  phoneNumber: args['phoneNumber'],
                  email: args['email'],
                ));
              case EditAd.id:
                final args = settings.arguments as Map<String, dynamic>;
                return _buildPageRoute(EditAd(
                  title: args['title'],
                  description: args['description'],
                  price: args['price'],
                  imagePath: args['imagePath'],
                  phoneNumber: args['phoneNumber'],
                  email: args['email'],
                ));
              case AdsList.id:
                return _buildPageRoute(const AdsList());
              case DeleteAd.id:
                final args = settings.arguments as Map<String, dynamic>;
                return _buildPageRoute(DeleteAd(
                  title: args['title'],
                  description: args['description'],
                  price: args['price'],
                ));
              case SearchAds.id:
                return _buildPageRoute(const SearchAds());
              case Profile.id:
                return _buildPageRoute(const Profile());
              case ChangePassword.id:
                return _buildPageRoute(const ChangePassword());
              default:
                return _buildPageRoute(const Welcome());
            }
          },
        );
      },
    );
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