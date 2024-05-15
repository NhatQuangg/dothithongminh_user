import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dothithongminh_user/constants/my_button.dart';
import 'package:dothithongminh_user/constants/my_textfield.dart';
import 'package:dothithongminh_user/constants/square_tile.dart';
import 'package:dothithongminh_user/controller/register_controller.dart';
import 'package:dothithongminh_user/model/user_model.dart';
import 'package:dothithongminh_user/pages/login_page/login_page.dart';
import 'package:dothithongminh_user/repository/authentication/exceptions/signup_email_password_failure.dart';
import 'package:dothithongminh_user/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';

class RegisterPage extends StatefulWidget {
  // final Function()? onTap;
  // const RegisterPage({Key? key, required this.onTap});

  const RegisterPage({Key? key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final controller = Get.put(RegisterController());
  String levelUser = '1';
  bool _passwordVisible = false;
  final databaseReference = FirebaseDatabase.instance.ref("Users");
  DatabaseReference dtbref = FirebaseDatabase.instance.ref('StoreData');

  final _formKey = GlobalKey<FormState>();

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

  void signUserUp() async {
    try {
      if (controller.phoneNo.text.trim().contains(RegExp(r'[a-zA-Z]'))) {
        AnimatedSnackBar.material(
          'Không được chứa kí tự khác ngoài kí tự số',
          type: AnimatedSnackBarType.error,
          mobileSnackBarPosition: MobileSnackBarPosition.bottom,
        ).show(context);
      }
      if (controller.email.text.trim() == null ||
          controller.email.text.trim() == "") {
        AnimatedSnackBar.material(
          'Vui lòng nhập email!',
          type: AnimatedSnackBarType.error,
          mobileSnackBarPosition: MobileSnackBarPosition.bottom,
        ).show(context);
        print("Chưa nhập email");
      } else if (controller.password.text.trim() == null ||
          controller.password.text.trim() == "") {
        AnimatedSnackBar.material(
          'Vui lòng nhập mật khẩu!',
          type: AnimatedSnackBarType.error,
          mobileSnackBarPosition: MobileSnackBarPosition.bottom,
        ).show(context);
        print("Chưa nhập mk");
      } else if (controller.repass.text != controller.password.text.trim() ||
          controller.repass.text == "") {
        AnimatedSnackBar.material(
          'Nhập lại mật khẩu không chính xác!',
          type: AnimatedSnackBarType.error,
          mobileSnackBarPosition: MobileSnackBarPosition.bottom,
        ).show(context);
        print("Chưa nhập lai mk");
      } else {
        isLoading();

        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: controller.email.text.trim(),
                password: controller.password.text.trim());

        final user = UserModel(
          fullname: controller.fullName.text.trim(),
          email: controller.email.text.trim(),
          phone: controller.phoneNo.text.trim(),
          password: controller.password.text.trim(),
          level: levelUser,
        );

        RegisterController.instance.createUserRD(user);

        AnimatedSnackBar.material(
          'Đăng ký thành công',
          type: AnimatedSnackBarType.success,
          mobileSnackBarPosition: MobileSnackBarPosition.bottom,
        ).show(context);
        controller.fullName.text = "";
        controller.email.text = "";
        controller.phoneNo.text = "";
        controller.password.text = "";
        controller.repass.text = "";

        Navigator.of(context).pop();

        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => LoginPage()),
        );

        print("Đăng ký thành công....");
      }
    } on FirebaseAuthException catch (e) {
      print("day la loi:  ${e.message}");
      final ex = SignUpWithEmailAndPasswordFailure.code(e.code);
      print('FIREBASE AUTH EXCEPTION - ${ex.message}');
      AnimatedSnackBar.material(
        "${ex.message}",
        type: AnimatedSnackBarType.error,
        mobileSnackBarPosition: MobileSnackBarPosition.bottom,
      ).show(context);
      throw ex;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 30),

                  Text(
                    'ĐĂNG KÝ',
                    style: GoogleFonts.roboto(
                        color: Color(0xFF109ea2),
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 25),

                  // fullname textfield
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: MyTextField(
                      controller: controller.fullName,
                      hintText: 'Họ và tên',
                      obscureText: false,
                    ),
                  ),
                  const SizedBox(height: 10),

                  // username textfield
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: MyTextField(
                      controller: controller.email,
                      hintText: 'Tên đăng nhập',
                      obscureText: false,
                    ),
                  ),
                  const SizedBox(height: 10),

                  // phone textfield
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: MyTextField(
                      controller: controller.phoneNo,
                      hintText: 'Số điện thoại',
                      obscureText: false,
                      keyboardType: TextInputType.number,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: MyTextField(
                        controller: controller.password,
                        hintText: 'Mật khẩu',
                        obscureText: true),
                  ),

                  const SizedBox(height: 10),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: MyTextField(
                        controller: controller.repass,
                        hintText: 'Xác nhận mật khẩu',
                        obscureText: true),
                  ),

                  const SizedBox(height: 10),

                  const SizedBox(height: 25),

                  // sign in button
                  MyButton(
                    text: 'Đăng ký',
                    onTap: signUserUp,
                  ),

                  const SizedBox(height: 30),

                  // not a member? register now
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Bạn đã có sẵn tài khoản?',
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                      const SizedBox(width: 4),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushReplacement(
                            PageTransition(
                              type: PageTransitionType
                                  .rightToLeft, // Animation direction
                              child: LoginPage(), // Your next page widget
                            ),
                          );
                        },
                        child: const Text(
                          'Đăng nhập ngay',
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
