import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dothithongminh_user/constants/constant.dart';
import 'package:dothithongminh_user/constants/global.dart';
import 'package:dothithongminh_user/constants/text_box.dart';
import 'package:dothithongminh_user/constants/text_box_pass.dart';
import 'package:dothithongminh_user/controller/profile_controller.dart';
import 'package:dothithongminh_user/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final controller = Get.put(ProfileController());
  // final idemail = getEmail();

  final auth = FirebaseAuth.instance;
  // -------------------------------------------------------------
  // user
  final currentUser = FirebaseAuth.instance.currentUser!;
  var current = FirebaseAuth.instance.currentUser;

  // all users
  final usersCollection = FirebaseFirestore.instance.collection("Users");
  final currentPassword = FirebaseAuth.instance.currentUser!.email;

  final rd = FirebaseDatabase.instance;

  String oldPass = "";
  String currentPasswordd = "";

  // edit field
  Future<void> editField(String field, String idUser) async {
    String newValue = "";
    await showDialog(
        context: context,
        builder: (context) => AlertDialog(
              backgroundColor: Colors.white,
              title: Text(
                'Edit ' + field,
                style: TextStyle(color: Colors.grey[900]),
              ),
              content: TextField(
                autofocus: true,
                style: TextStyle(
                  color: Colors.grey[900],
                ),
                decoration: InputDecoration(
                    hintText: "Enter new $field",
                    hintStyle: TextStyle(color: Colors.grey)),
                onChanged: (value) {
                  newValue = value;
                  print('gia tri thay vo: $newValue');
                },
              ),
              actions: [
                // cancel button
                TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      'Cancel',
                      style: TextStyle(color: Colors.grey[900]),
                    )),

                // save button
                TextButton(
                    onPressed: () async {
                      print("field moi: ${newValue}");
                      print("id: ${currentUser.uid}");
                      print("id RD: ${idUser}");

                      // update in firestore
                      if (newValue.trim().length > 0) {

                        await rd
                            .ref("Users")
                            .child(idUser)
                            .update({field: newValue});

                        print('Đã cập nhật profile');
                        showSuccessSnackBar("Cập nhật thành công!");
                        Navigator.of(context).pop(newValue);
                        setState(() {});
                      } else {
                        showErrorSnackBar("Không được để trống");
                      }
                    },
                    child: Text(
                      'Save',
                      style: TextStyle(color: Colors.grey[900]),
                    ))
              ],
            ));
  }

  Future<void> updatePasswordd(
      String field, String currentPass, String idUser) async {
    String newPass = "";
    await showDialog(
        context: context,
        builder: (context) => AlertDialog(
              backgroundColor: Colors.white,
              title: Text(
                'Edit ' + field,
                style: TextStyle(color: Colors.grey[900]),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextField(
                    autofocus: true,
                    style: TextStyle(
                      color: Colors.grey[900],
                    ),
                    decoration: InputDecoration(
                        hintText: "Enter new old pass",
                        hintStyle: TextStyle(color: Colors.grey)),
                    onChanged: (value1) {
                      oldPass = value1;
                    },
                  ),
                  TextField(
                    // autofocus: true,
                    style: TextStyle(
                      color: Colors.grey[900],
                    ),
                    decoration: InputDecoration(
                        hintText: "Enter new new pass",
                        hintStyle: TextStyle(color: Colors.grey)),
                    onChanged: (value) {
                      newPass = value;
                    },
                  ),
                ],
              ),
              actions: [
                // cancel button
                TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      'Cancel',
                      style: TextStyle(color: Colors.grey[900]),
                    )),

                // save button
                TextButton(
                    // onPressed: () => Navigator.of(context).pop(newPass),
                    onPressed: () async {
                      print(currentPass + "  " + oldPass);
                      if (currentPass == oldPass) {
                        User? user = FirebaseAuth.instance.currentUser;

                        if (newPass.trim().length >= 6) {
                          print("1: " + user!.email! + "  " + currentPass);

                          var credential = EmailAuthProvider.credential(
                            email: user!.email!,
                            password: currentPass,
                          );

                          print("2");

                          await currentUser
                              .reauthenticateWithCredential(credential)
                              .then((value) {
                            currentUser.updatePassword(newPass);
                          }).catchError((e) {
                            print("Loi: $e");
                          });

                          await rd
                              .ref("Users")
                              .child(idUser)
                              .update({field: newPass});

                          showSuccessSnackBar("Cập nhật mật khẩu thành công!");

                          print('Đã đổi mật khẩu thành công!');

                          setState(() {
                            currentPasswordd = newPass;
                          });
                        } else {
                          showErrorSnackBar("Mật khẩu quá yếu (>=6 kí tự)");
                          print('Lỗi khi đổi mật khẩu');
                        }
                      } else {
                        print('Mật khẩu hiện tại không đúng!');
                        showErrorSnackBar("Mật khẩu hiện tại không đúng!");
                      }

                      Navigator.pop(context, newPass);
                    },
                    child: Text(
                      'Save',
                      style: TextStyle(color: Colors.grey[900]),
                    ))
              ],
            ));
  }

  void showSuccessSnackBar(String message) {
    AnimatedSnackBar.material(message,
            type: AnimatedSnackBarType.success,
            mobileSnackBarPosition: MobileSnackBarPosition.bottom)
        .show(context);
  }

  void showErrorSnackBar(String message) {
    AnimatedSnackBar.material(message,
            type: AnimatedSnackBarType.error,
            mobileSnackBarPosition: MobileSnackBarPosition.bottom)
        .show(context);
  }

  Future<void> _getUserId() async {
    late String? userId;
    String? id = await getId_Users();
    setState(() {
      userId = id;
    });
  }

  void initState() {
    super.initState();
    _getUserId();
  }
  
  @override
  Widget build(BuildContext context) {
    print("hahahaha");
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
          iconSize: 25,
        ),
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'THÔNG TIN CÁ NHÂN',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: mainColor,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: FutureBuilder(
            future: controller.getUserDataRD(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                // get user data
                if (snapshot.hasData) {
                  UserModel user = snapshot.data as UserModel;
                  currentPasswordd = user.password ?? "";

                  print("email: ${user.email} , ${user.fullname}, ${user.id}");
                  return Column(
                    children: [
                      const SizedBox(height: 40,),

                      // profile pic
                      const Icon(
                        Icons.person,
                        size: 90,
                      ),

                      const SizedBox(height: 10,),

                      // user email
                      Text(
                        currentUser.email!,
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.grey[800]),
                      ),

                      const SizedBox(
                        height: 20,
                      ),

                      // user detail
                      Padding(
                        padding: EdgeInsets.only(left: 25.0),
                        child: Text(
                          'Thông tin chi tiết',
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                      ),

                      // fullname
                      MyTextBox(
                        text: user.fullname ?? "",
                        sectionName: 'fullname',
                        onPressed: () =>
                            editField('fullName', user.id.toString()),
                        obscureText: false,
                      ),

                      // phone
                      MyTextBox(
                        text: user.phone ?? "",
                        sectionName: 'phone',
                        onPressed: () => editField('phone', user.id.toString()),
                        obscureText: false,
                      ),

                      // pass
                      MyTextBox(
                        text: user.password ?? "",
                        sectionName: 'password',
                        onPressed: () => updatePasswordd(
                            'password', currentPasswordd, user.id.toString()),
                        obscureText: true,
                      ),
                    ],
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Error ${snapshot.error}'),
                  );
                }
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ),
      ),
      // bottomNavigationBar: HomeBottomNavbar(),
    );
  }
}
