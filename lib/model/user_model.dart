import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';

class UserModel {
  final String? id;
  final String? fullName;
  final String? email;
  final String? phoneNo;
  final String? password;
  final String? level;

  const UserModel({
    this.id,
    required this.fullName,
    required this.email,
    required this.phoneNo,
    required this.password,
    required this.level,
  });

  // chuyển đối tượng UserModel -> Json.
  // Dùng để lưu trữ data vào Cloud FireStore
  toJson() {
    return {
      "fullName": fullName,
      "email": email,
      "phone": phoneNo,
      "password": password,
      "level": level
    };
  }

  factory UserModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return UserModel(
        id: document.id,
        fullName: data["fullName"],
        email: data["email"],
        phoneNo: data["phone"],
        password: data["password"],
        level: data["level"]);
  }

  factory UserModel.fromRealtimeDatabase(DataSnapshot snapshot) {
    final data = snapshot.value as Map<dynamic, dynamic>;
    return UserModel(
      id: snapshot.key,
      fullName: data["fullName"],
      email: data["email"],
      phoneNo: data["phone"],
      password: data["password"],
      level: data["level"],
    );
  }

}
