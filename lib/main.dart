import 'package:flutter/material.dart';
import 'package:diplomna_rabota_new/pages/welcome.dart';
import 'package:diplomna_rabota_new/pages/add_ad.dart';
import 'package:diplomna_rabota_new/pages/view_ad.dart';
import 'package:diplomna_rabota_new/pages/edit_ad.dart';
import 'package:diplomna_rabota_new/pages/ads_list.dart';
import 'package:diplomna_rabota_new/pages/delete_ad.dart';
import 'package:diplomna_rabota_new/pages/search_ads.dart';
import 'package:diplomna_rabota_new/pages/profile.dart';
import 'package:diplomna_rabota_new/pages/change_password.dart';
import '../components/styles.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            return PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) => const Welcome(),
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                const begin = Offset(1.0, 0.0);
                const end = Offset.zero;
                const curve = Curves.ease;
                var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                var offsetAnimation = animation.drive(tween);
                return SlideTransition(position: offsetAnimation, child: child);
              },
            );
          case AddAd.id:
            return PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) => const AddAd(),
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                const begin = Offset(1.0, 0.0);
                const end = Offset.zero;
                const curve = Curves.ease;
                var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                var offsetAnimation = animation.drive(tween);
                return SlideTransition(position: offsetAnimation, child: child);
              },
            );
          case ViewAd.id:
            return PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) => const ViewAd(title: '', description: '', price: '', imagePath: '', phoneNumber: '', email: ''),
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                const begin = Offset(1.0, 0.0);
                const end = Offset.zero;
                const curve = Curves.ease;
                var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                var offsetAnimation = animation.drive(tween);
                return SlideTransition(position: offsetAnimation, child: child);
              },
            );
          case EditAd.id:
            return PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) => const EditAd(title: '', description: '', price: '', imagePath: '', phoneNumber: '', email: ''),
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                const begin = Offset(1.0, 0.0);
                const end = Offset.zero;
                const curve = Curves.ease;
                var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                var offsetAnimation = animation.drive(tween);
                return SlideTransition(position: offsetAnimation, child: child);
              },
            );
          case AdsList.id:
            return PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) => const AdsList(),
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                const begin = Offset(1.0, 0.0);
                const end = Offset.zero;
                const curve = Curves.ease;
                var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                var offsetAnimation = animation.drive(tween);
                return SlideTransition(position: offsetAnimation, child: child);
              },
            );
          case DeleteAd.id:
            return PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) => const DeleteAd(title: '', description: '', price: ''),
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                const begin = Offset(1.0, 0.0);
                const end = Offset.zero;
                const curve = Curves.ease;
                var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                var offsetAnimation = animation.drive(tween);
                return SlideTransition(position: offsetAnimation, child: child);
              },
            );
          case SearchAds.id:
            return PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) => const SearchAds(),
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                const begin = Offset(1.0, 0.0);
                const end = Offset.zero;
                const curve = Curves.ease;
                var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                var offsetAnimation = animation.drive(tween);
                return SlideTransition(position: offsetAnimation, child: child);
              },
            );
          case Profile.id:
            return PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) => const Profile(),
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                const begin = Offset(1.0, 0.0);
                const end = Offset.zero;
                const curve = Curves.ease;
                var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                var offsetAnimation = animation.drive(tween);
                return SlideTransition(position: offsetAnimation, child: child);
              },
            );
          case ChangePassword.id:
            return PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) => const ChangePassword(),
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                const begin = Offset(1.0, 0.0);
                const end = Offset.zero;
                const curve = Curves.ease;
                var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                var offsetAnimation = animation.drive(tween);
                return SlideTransition(position: offsetAnimation, child: child);
              },
            );
        // case ResetPassword.id:
        //   return PageRouteBuilder(
        //     pageBuilder: (context, animation, secondaryAnimation) => const ResetPassword(),
        //     transitionsBuilder: (context, animation, secondaryAnimation, child) {
        //       const begin = Offset(1.0, 0.0);
        //       const end = Offset.zero;
        //       const curve = Curves.ease;
        //       var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        //       var offsetAnimation = animation.drive(tween);
        //       return SlideTransition(position: offsetAnimation, child: child);
        //     },
        //   );
        // default:
        //   return null;
        }
      },
    );
  }
}