import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dothithongminh_user/model/reflect_model.dart';
import 'package:dothithongminh_user/test/test_model.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TestRes extends GetxController {
  static TestRes get instance => Get.find();
  final _rd = FirebaseDatabase.instance;


  createTest(TestModel test) async {
    await _rd
        .ref("StoreData")
        .push()
        .set(test.toJson())
        .then((value) => print("Thanh cong"))
        .catchError((e) => print("loi"));
  }

  // Future<UserModel?> getUserDetailRD(String email) async {
  //   try {
  //     print("Day la email: $email");
  //     // final ref = _rd.reference().child("Users");
  //     // final query = await ref.orderByChild("email").equalTo(email).once();
  //
  //     final query = await _rd.ref("Users").orderByChild("email").equalTo(email).once();
  //
  //
  //     final snapshot = query.snapshot.children.first;
  //     return UserModel.fromRealtimeDatabase(snapshot);
  //   } catch (e) {
  //     print("Error getting user by email: $e");
  //     return null;
  //   }
  // }
}
