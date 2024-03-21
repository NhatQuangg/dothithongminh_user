// import 'dart:html';
//
// import 'package:dothithongminh_user/controller/profile_controller.dart';
// import 'package:dothithongminh_user/pages/reflect_page/crud_reflect/crud_reflect.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// class Form_Reflect_Page2 extends StatefulWidget {
//   const Form_Reflect_Page2({super.key});
//
//   @override
//   State<Form_Reflect_Page2> createState() => _Form_Reflect_Page2State();
// }
//
// class _Form_Reflect_Page2State extends State<Form_Reflect_Page2> {
//   final controllerUer = Get.put(ProfileController());
//   List<File> listFile = [];
//
//   String? authorName, title, desc;
//   CrudReflect crudReflect = new CrudReflect();
//   QuerySnapshot? refSnapshot;
//   bool accept = false;
//   String? url;
//   File? image;
//   List<String> urls = [];
//   List<String> video_urls = [];
//   List<String> listCategory = ['Giáo dục', 'An ninh', 'Cơ sở vật chất'];
//   String? selectNameCategory;
//
//   bool _isloading = false;
//   String imageUrl = '';
//   XFile? file;
//   String? u;
//   String slectedFileName = "";
//   String defaultImageUrl =
//       'https://hanoispiritofplace.com/wp-content/uploads/2014/08/hinh-nen-cac-loai-chim-dep-nhat-1-1.jpg';
//   Query q = FirebaseDatabase.instance.ref().child("Category");
//
//
//   @override
//   Widget build(BuildContext context) {
//     return const Placeholder();
//   }
// }
