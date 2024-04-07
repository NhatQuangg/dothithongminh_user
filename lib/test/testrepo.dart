import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dothithongminh_user/test/testmodel.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';

class TestRepo extends GetxController {
  static TestRepo get instance => Get.find();
  final _rd = FirebaseDatabase.instance;
  final _db = FirebaseFirestore.instance;

  createTest(TestModel test) async {
    await _rd
        .ref("myapp")
        .push()
        .set(test.toJson())
        .then((_) => print("RD - Create reflect realtime successfully"))
        .catchError((e) => print("RD - Create failed: $e"));
  }

  Future<List<TestModel>> allReflect() async {
    final snapshot = await _db.collection("Reflect").get();
    final reflectData =
    snapshot.docs.map((e) => TestModel.fromSnapshot(e)).toList();
    return reflectData;
  }

  Future<List<TestModel>> getData() async {
    final snapshot = await _rd.ref("myapp").get();

    final data = snapshot.value as List<dynamic>; // Assuming data is a list
    final testModels = data.map((e) => TestModel.fromRealtimeDatabase(e)).toList();
    return testModels;
  }
}
