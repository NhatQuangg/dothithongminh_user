import 'package:dothithongminh_user/model/user_model.dart';
import 'package:dothithongminh_user/repository/authentication/auth_repository.dart';
import 'package:dothithongminh_user/repository/users/user_repository.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  static ProfileController get instance => Get.find();

  final _authRepo = Get.put(AuthRepository());
  final _userRepo = Get.put(UserRepository());

  getUserDataRD() {
    final email = _authRepo.firebaseUser.value?.email;
    print("email: $email");
    if (email != null) {
      return _userRepo.getUserDetailRD(email);
    } else {
      Get.snackbar("Error", "Login to continue RD");
    }
  }
}
