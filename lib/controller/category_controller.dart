import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dothithongminh_user/constants/global.dart';
import 'package:dothithongminh_user/model/category__model.dart';
import 'package:dothithongminh_user/model/reflect_model.dart';
import 'package:dothithongminh_user/repository/authentication/auth_repository.dart';
import 'package:dothithongminh_user/repository/category/category_respository.dart';
import 'package:dothithongminh_user/repository/reflects/reflect_repository.dart';
import 'package:dothithongminh_user/repository/users/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smartrefresh/smartrefresh.dart';

class CategoryController extends GetxController {
  static CategoryController get instance => Get.find();

  final RefreshController refreshController = RefreshController();
  final _cateRepo = Get.put(CategoryRepository());



  final _reflectRepo = Get.put(ReflectRepository());

  @override

  // Future<CategoryModel?> getAllCategory() async {
  //   final a = _cateRepo.getAllCategory();
  //   if (a != null) {
  //     print("haaaa");
  //   }
  //   return _cateRepo.getAllCategory();
  // }

  Future<void> createReflectRD(ReflectModel reflect) async {
    await _reflectRepo.createReflectRD(reflect);
  }

  Future<List<ReflectModel>> getAllReflectRD() async {
    return await _reflectRepo.getAllReflectRD();
  }
}