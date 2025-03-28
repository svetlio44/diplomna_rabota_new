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
import 'package:diplomna_rabota_new/pages/tabs.dart';
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
        await prefs.remove('rememberMe');
        await prefs.remove('email');
        await prefs.remove('password');
      }
    }
  } catch (e) {
    print('Error initializing app: $e');
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const MaterialApp(
            home: Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        }

        final isAuthenticated = snapshot.hasData;
        routeArgsHandler(RouteSettings settings) {
          switch (settings.name) {
            case Welcome.id:
              return _buildPageRoute(const Welcome());
            case AddAd.id:
              return _buildPageRoute(const AddAd());
            case ViewAd.id:
              if (settings.arguments is! Map<String, dynamic>) {
                return _buildPageRoute(const Welcome());
              }
              final args = settings.arguments as Map<String, dynamic>;
              return _buildPageRoute(ViewAd(
                title: args['title'] ?? '',
                description: args['description'] ?? '',
                price: args['price'] ?? '',
                imagePath: args['imagePath'] ?? '',
                phoneNumber: args['phoneNumber'] ?? '',
                email: args['email'] ?? '',
              ));
            case EditAd.id:
              if (settings.arguments is! Map<String, dynamic>) {
                return _buildPageRoute(const Welcome());
              }
              final args = settings.arguments as Map<String, dynamic>;
              return _buildPageRoute(EditAd(
                title: args['title'] ?? '',
                description: args['description'] ?? '',
                price: args['price'] ?? '',
                imagePath: args['imagePath'] ?? '',
                phoneNumber: args['phoneNumber'] ?? '',
                email: args['email'] ?? '',
              ));
            case AdsList.id:
              return _buildPageRoute(const AdsList());
            case DeleteAd.id:
              if (settings.arguments is! Map<String, dynamic>) {
                return _buildPageRoute(const Welcome());
              }
              final args = settings.arguments as Map<String, dynamic>;
              return _buildPageRoute(DeleteAd(
                title: args['title'] ?? '',
                description: args['description'] ?? '',
                price: args['price'] ?? '',
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
        }

        return MaterialApp(
          title: 'Social Network 2',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            fontFamily: "regular",
            primaryColor: appColor,
          ),
          home: isAuthenticated ? TabsExample() : const Welcome(),
          onGenerateRoute: (settings) => routeArgsHandler(settings),
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