import 'package:dothithongminh_user/pages/home_page/home_page.dart';
import 'package:dothithongminh_user/pages/login_page/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatelessWidget {
  AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot){
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }
          else if (snapshot.hasData) {
            final user = snapshot.data!;
            print(user);
            return HomePage();
          }
          else {
            return LoginPage();
          }
        },
      ),
    );
  }
}
