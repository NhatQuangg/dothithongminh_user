import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dothithongminh_user/model/user_model.dart';
import 'package:dothithongminh_user/repository/authentication/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  final _rd = FirebaseDatabase.instance;

  late final Rx<User?> firebaseUser;

  final _authRepo = Get.put(AuthRepository());

  createUser(UserModel user) async {
    final email = _authRepo.firebaseUser.value!.email;
    print("day la email: $email");
    if (email != null) {
      await _db.collection("Users").add(user.toJson()).catchError((error) {
        print("Error: " + error.toString());
      });
    } else {
      print("Can't create user in firestore");
    }
  }

  createUserDetail(UserModel user) async {
    await _db.collection("Users").doc(user.email).set({
      "fullname": user.fullname,
      "email": user.email,
      "phone": user.phone,
      "password": user.password,
      "level": user.level
    });
  }

  // ---------------------------------------------------------------
  // ---------------------------------------------------------------

  createUserRD(UserModel user) async {
    await _rd
        .ref("Users")
        .push()
        .set(user.toJson())
        .then((_) => print("Create user realtime successfully"))
        .catchError((e) => print("Create failed: $e"));
  }


  Future<UserModel?> getUserDetailRD(String email) async {
    try {
      print("Day la email: $email");

      final query = await _rd.ref("Users").orderByChild("email").equalTo(email).once();

      final snapshot = query.snapshot.children.first;
      return UserModel.fromRealtimeDatabase(snapshot);
    } catch (e) {
      print("Error getting user by email: $e");
      return null;
    }
  }
}
