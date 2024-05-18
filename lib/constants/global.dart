import 'dart:async';

import 'package:dothithongminh_user/controller/profile_controller.dart';
import 'package:dothithongminh_user/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';

final FirebaseAuth auth = FirebaseAuth.instance;
final controller = Get.put(ProfileController());

void inputEmail() {
  final User user = auth.currentUser!;
  final email = user.email;
  print("UID == $email");
}

getEmail() {
  final User user = auth.currentUser!;
  final email = user.email;
  // final id = user.uid;

  return email;
}

void inputUid() {
  final User user = auth.currentUser!;
  final uid = user.uid;
  print("UID == $uid");
  // here you write the codes to input the data into firestore
}

getId_Userss() {
  controller.getUserDataRD().then((userData) {
    if (userData != null) {
      UserModel user = userData!;
      return user.id.toString();
    } else {
      print("Get ID User fail");
    }
  });
}

Future<String?> getId_Users() async {
  final completer = Completer<String?>();

  final UserModel? userData = await controller.getUserDataRD();
  if (userData != null) {
    completer.complete(userData.id);
  } else {
    print("Get ID User fail");
    completer.complete(null);
  }
  return completer.future;
}