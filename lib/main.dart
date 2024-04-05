import 'package:dothithongminh_user/firebase_options.dart';
import 'package:dothithongminh_user/pages/login_page/auth_page.dart';
import 'package:dothithongminh_user/test/get_reflect.dart';
import 'package:dothithongminh_user/test/tab1.dart';
import 'package:dothithongminh_user/test/tab2.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Đô thị thông minh',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.robotoTextTheme(Theme.of(context).textTheme),
      ),
      home: AuthPage(),
    );
  }
}


