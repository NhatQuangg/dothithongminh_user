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

  Future<void> likeReflectModel(ReflectModel reflectModel, bool isLike) {
    return _reflectRepo.likeReflectModel(reflectModel, isLike);
  }
}