import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dothithongminh_user/model/category__model.dart';
import 'package:dothithongminh_user/model/user_model.dart';
import 'package:dothithongminh_user/repository/authentication/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryRepository extends GetxController {
  static CategoryRepository get instance => Get.find();

  // final _rd = FirebaseDatabase.instance;

  // Future<CategoryModel?> getAllCategory() async {
  //   CategoryModel? categoryModel;
  //
  //   try {
  //     final databaseEvent = await FirebaseDatabase.instance.ref().child('Category').once();
  //     final snapshot = databaseEvent.snapshot;
  //
  //     if (snapshot.value != null) {
  //       categoryModel = CategoryModel.fromSnapshot(snapshot);
  //       print("Categories retrieved successfully:");
  //       print("Category Name: ${categoryModel.category_name}");
  //     } else {
  //       print("No category data found");
  //     }
  //   } catch (e) {
  //     print("Error getting categories: $e");
  //   }
  //
  //   return categoryModel; // R
  // }
}
