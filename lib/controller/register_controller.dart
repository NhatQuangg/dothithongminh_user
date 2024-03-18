import 'package:dothithongminh_user/model/user_model.dart';
import 'package:dothithongminh_user/repository/authentication/auth_repository.dart';
import 'package:dothithongminh_user/repository/users/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  static RegisterController get instance => Get.find();

  final email = TextEditingController();
  final password = TextEditingController();
  final fullName = TextEditingController();
  final phoneNo = TextEditingController();
  final repass = TextEditingController();

  final userRepo = Get.put(UserRepository());

  void registerUser(String email, String password) {
    AuthRepository.instance.createUserWithEmailAndPassword(email, password);
    print("Dang o registerUser của register_controller");
  }

  Future<void> createUser(UserModel user) async {
    await userRepo.createUser(user);
  }

  Future<void> createUserDetail(UserModel user) async {
    await userRepo.createUserDetail(user);
    // phoneAuthentication(user.phoneNo!);
  }

  // ---------------------------------------------------
  // ---------------------------------------------------

  Future<void> createUserRD(UserModel user) async {
    await userRepo.createUserRD(user);
  }
}
