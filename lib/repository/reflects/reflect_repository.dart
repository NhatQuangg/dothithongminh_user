import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dothithongminh_user/model/reflect_model.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReflectRepository extends GetxController {
  static ReflectRepository get instance => Get.find();
  final _db = FirebaseFirestore.instance;
  final _rd = FirebaseDatabase.instance;
  final databaseReference = FirebaseDatabase.instance.ref();

  createReflect(ReflectModel reflect) async {
    await _db
        .collection("Reflects")
        .add(reflect.toJson())
        .whenComplete(() => Get.snackbar("Success", "Reflect has been created",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green.withOpacity(0.1),
        colorText: Colors.green))
        .catchError((error, StackTrace) {
      Get.snackbar("Error", "Something went wrong. Try again",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent.withOpacity(0.1),
          colorText: Colors.red);
      print(error.toString());
    });
  }

  createLikes(String email) async {
    await _db.collection("likes").doc(email);
  }

  Future<List<ReflectModel>> allReflect() async {
    final snapshot = await _db.collection("Reflects").get();
    final reflectData =
    snapshot.docs.map((e) => ReflectModel.fromSnapshot(e)).toList();
    return reflectData;
  }

  Future<List<ReflectModel>> getReflect(int handle) async {
    final snapshot = await _db
        .collection("Reflects")
        .where("handle", isEqualTo: handle)
        .get();
    final reflectData =
    snapshot.docs.map((e) => ReflectModel.fromSnapshot(e)).toList();
    return reflectData;
  }

  Future<List<ReflectModel>> allReflectAdmin(int handle) async {
    final snapshot = await _db
        .collection("Reflects")
        .where("handle", isEqualTo: handle)
        .get();
    final reflectData =
    snapshot.docs.map((e) => ReflectModel.fromSnapshot(e)).toList();
    return reflectData;
  }

  Future<List<ReflectModel>> allReflectUser(String email) async {
    final snapshot =
    await _db.collection("Reflects").where("email", isEqualTo: email).get();
    final reflectData =
    snapshot.docs.map((e) => ReflectModel.fromSnapshot(e)).toList();
    return reflectData;
  }

  Future<List<ReflectModel>> getReflectUser(String email, int handle) async {
    final snapshot = await _db
        .collection("Reflects")
        .where("email", isEqualTo: email)
        .where("handle", isEqualTo: handle)
        .get();
    final reflectData =
    snapshot.docs.map((e) => ReflectModel.fromSnapshot(e)).toList();
    return reflectData;
  }

  Future<List<ReflectModel>> allReflectActive(int handle) async {
    final snapshot = await _db
        .collection("Reflects")
        .where("handle", isEqualTo: handle)
        .get();
    final reflectData =
    snapshot.docs.map((e) => ReflectModel.fromSnapshot(e)).toList();
    return reflectData;
  }

  // -----------------------------------------------------------------------
  // -----------------------------------------------------------------------

  createReflectRD(ReflectModel reflect) async {
    await _rd
        .ref("Reflects")
        .push()
        .set(reflect.toJson())
        .then((_) => print("RD - Create reflect realtime successfully"))
        .catchError((e) => print("RD - Create failed: $e"));
  }

  Future<List<ReflectModel>> getAllReflectRD() async {
    final ref = FirebaseDatabase.instance.ref("Reflects");

    final snapshot = await ref.once();

    if (snapshot.snapshot.value == null) return [];

    final data = snapshot.snapshot.value as Map<String, dynamic>;

    final reflects = data.entries.map((entry) =>
        ReflectModel.fromRealtimeDatabase(entry.value)
    ).toList();


    return reflects;
  }

  final DatabaseReference _database = FirebaseDatabase.instance.ref();

  Future<List<ReflectModel>> getAllReflectRDD() async {
    final ref = FirebaseDatabase.instance.ref("Reflects");

    try {
      final snapshot = await ref.once();

      if (snapshot.snapshot.value == null) return [];

      final data = snapshot.snapshot.value as Map<String, dynamic>;

      final reflects = data.entries.map((entry) =>
          ReflectModel.fromRTDB(entry.value)
      ).toList();

      return reflects;
    } catch (e) {
      // Xử lý lỗi nếu có
      print("Error getting reflects from Realtime Database: $e");
      return []; // Trả về danh sách rỗng nếu có lỗi
    }
  }

  Future<void> addReflectModel(ReflectModel reflectModel) async {
    try {
      final reference = databaseReference.child('Reflects').push();
      await reference.set(reflectModel.toJson());
      print('ReflectModel added successfully with ID:');
    } catch (e) {
      print('Error adding ReflectModel: $e');
    }
  }

  Future<void> updateReflectModel(ReflectModel reflectModel) async {
    try {
      final reference = databaseReference.child('Reflects/${reflectModel.id}');
      await reference.update(reflectModel.toJson());
      print('ReflectModel updated successfully!');
    } catch (e) {
      print('Error updating ReflectModel: $e');
    }
  }

  Future<void> deleteReflectModel(String id) async {
    try {
      final reference = databaseReference.child('Reflects/$id');
      await reference.remove();
      print('ReflectModel deleted successfully!');
    } catch (e) {
      print('Error deleting ReflectModel: $e');
    }
  }
}