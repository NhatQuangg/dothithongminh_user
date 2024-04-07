import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dothithongminh_user/constants/global.dart';
import 'package:dothithongminh_user/model/reflect_model.dart';
import 'package:dothithongminh_user/repository/authentication/auth_repository.dart';
import 'package:dothithongminh_user/repository/reflects/reflect_repository.dart';
import 'package:dothithongminh_user/repository/users/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smartrefresh/smartrefresh.dart';

class ReflectController extends GetxController {
  static ReflectController get instance => Get.find();
  final idUser = TextEditingController();
  final email = TextEditingController();

  final title = TextEditingController();
  final EmailAuthProvider = TextEditingController();

  final category = TextEditingController();
  final content = TextEditingController();
  final address = TextEditingController();
  final media = TextEditingController();
  final createdAt = TextEditingController();
  final RefreshController refreshController = RefreshController();
  final _authRepo = Get.put(AuthRepository());
  final _userRepo = Get.put(UserRepository());


  ReflectModel? reflect;

  List<ReflectModel> refl = [];

  final _reflectRepo = Get.put(ReflectRepository());

  @override

  static Future likesPost(String id) async {
    final idemail = getEmail();
    print("IDEMAILLL == $idemail");

    final reflectCollection = FirebaseFirestore.instance.collection("Reflect");

    final docRef = reflectCollection.doc(id);

    try {
      await docRef.update({
        'Likes': FieldValue.arrayUnion([idemail])
      });
    } catch (e) {
      print("some error $e");
    }
  }

  static Future disLikesPost(String id) async {
    final idemail = getEmail();
    print("IDEMAILLL == $idemail");

    final reflectCollection = FirebaseFirestore.instance.collection("Reflect");

    final docRef = reflectCollection.doc(id);

    try {
      await docRef.update({
        'Likes': FieldValue.arrayRemove([idemail])
      });
    } catch (e) {
      print("some error $e");
    }
  }

  // -----------------------------------------------------------------------
  // -----------------------------------------------------------------------

  Future<void> createReflectRD(ReflectModel reflect) async {
    await _reflectRepo.createReflectRD(reflect);
  }

  Future<List<ReflectModel>> getAllReflectRD() async {
    return await _reflectRepo.getAllReflectRD();
  }

  Future<void> addReflectModel(ReflectModel reflect) async {
    return await _reflectRepo.addReflectModel(reflect);
  }
  Future<void> updateReflectModel(ReflectModel reflect) async {
    return await _reflectRepo.updateReflectModel(reflect);
  }
  Future<void> deleteReflectModel(String id) async {
    return await _reflectRepo.deleteReflectModel(id);
  }
}