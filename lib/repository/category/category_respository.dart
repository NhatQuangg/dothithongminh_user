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
  final DatabaseReference _database = FirebaseDatabase.instance.ref();

  Future<String> getCategoryNameById(String idCategory) async {
    String categoryName = "Unknown";
    try {
      DataSnapshot snapshot = await _database.child("Category").child(idCategory).get();
      if (snapshot.value != null) {
        Map<dynamic, dynamic>? categoryData = snapshot.value as Map<dynamic, dynamic>?; // Xác định kiểu dữ liệu của categoryData
        if (categoryData != null) {
          categoryName = categoryData["category_name"] ?? "Unknown"; // Sử dụng toán tử null-aware để tránh lỗi null
        }
      }
    } catch (error) {
      print("Error: $error");
    }

    return categoryName;
  }

}
