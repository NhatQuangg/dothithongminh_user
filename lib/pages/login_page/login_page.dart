import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:dothithongminh_user/constants/my_button.dart';
import 'package:dothithongminh_user/constants/my_textfield.dart';
import 'package:dothithongminh_user/constants/square_tile.dart';
import 'package:dothithongminh_user/pages/login_page/auth_page.dart';
import 'package:dothithongminh_user/pages/register_page/register_page.dart';
import 'package:dothithongminh_user/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';

class LoginPage extends StatefulWidget {
  // final Function()? onTap;
  // const LoginPage({Key? key, required this.onTap});

  const LoginPage({Key? key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // text editing controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  // bool _passwordVisible = false;
  bool flag = true;
  bool isButtonDisabled = false;

  Future isLoading() async {
    setState(() {
      isButtonDisabled = true;
    });

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    setState(() {
      isButtonDisabled = false;
    });
  }


  // sign user in method
  void signUserIn() async {
    try {
      if (emailController.text == null || emailController.text == "") {
        AnimatedSnackBar.material("Vui lòng nhập đầy đủ",
                type: AnimatedSnackBarType.error,
                mobileSnackBarPosition: MobileSnackBarPosition.bottom)
            .show(context);
        print("hel");
      } else if (passwordController.text == null || passwordController.text == "") {
        AnimatedSnackBar.material('Vui lòng nhập đầy đủ',
                type: AnimatedSnackBarType.error,
                mobileSnackBarPosition: MobileSnackBarPosition.bottom)
            .show(context);
        print("heagel");

      } else {
        isLoading();

        await FirebaseAuth.instance.signInWithEmailAndPassword(email: emailController.text, password: passwordController.text);

        Navigator.of(context).pop();

        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => AuthPage()),
        );

        // Future.delayed(const Duration(seconds: 5), () {
        //   Navigator.of(context).pushReplacement(
        //     MaterialPageRoute(builder: (context) => AuthPage()),
        //   );
        // });
        print('Đăng nhập thành công 2');
      }
    } on FirebaseAuthException catch (e) {
      print(e.code);
      Navigator.of(context).pop();

      if (e.code == 'invalid-email') {
        AnimatedSnackBar.material('Tài khoản hoặc mật khẩu không đúng !',
            type: AnimatedSnackBarType.error,
            mobileSnackBarPosition: MobileSnackBarPosition.bottom)
            .show(context);
        print('mk sai');
      } else
        if (e.code == 'invalid-credential') {
          AnimatedSnackBar.material('Tài khoản hoặc mật khẩu không đúng !',
              type: AnimatedSnackBarType.error,
              mobileSnackBarPosition: MobileSnackBarPosition.bottom)
              .show(context);
        }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'ĐĂNG NHẬP',
                  style: GoogleFonts.roboto(
                      color: Color(0xFF109ea2),
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 25),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: MyTextField(
                    controller: emailController,
                    hintText: 'Tên đăng nhập',
                    obscureText: false,
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: MyTextField(
                    controller: passwordController,
                    hintText: 'Mật khẩu',
                    obscureText: true,
                  ),
                ),

                const SizedBox(height: 10),

                const SizedBox(height: 25),
                // sign in button
                MyButton(
                  text: 'Đăng nhập',
                  onTap: signUserIn,
                ),
                const SizedBox(height: 50),
                // not a member? register now
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Bạn chưa có tài khoản?',
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => RegisterPage()));
                      },
                      child: const Text(
                        'Đăng ký ngay',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

