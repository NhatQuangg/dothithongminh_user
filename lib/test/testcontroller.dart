import 'package:dothithongminh_user/test/testmodel.dart';
import 'package:dothithongminh_user/test/testrepo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TestController extends GetxController {
  static TestController get instance => Get.find();

  final content = TextEditingController();
  final title = TextEditingController();
  final contentfeedback = TextEditingController();
  final _testRepo = Get.put(TestRepo());

  Future<void> createTest(TestModel test) async {
    await _testRepo.createTest(test);
  }

  Future<List<TestModel>> getAll() async {
    print("controller");
    return await _testRepo.getData();
  }

}