import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';

class UserModel {
  final String? id;
  final String? fullname;
  final String? email;
  final String? phone;
  final String? password;
  final String? level;

  const UserModel({
    this.id,
    required this.fullname,
    required this.email,
    required this.phone,
    required this.password,
    required this.level,
  });

  // chuyển đối tượng UserModel -> Json.
  // Dùng để lưu trữ data vào Cloud FireStore
  toJson() {
    return {
      "fullname": fullname,
      "email": email,
      "phone": phone,
      "password": password,
      "level": "2"
    };
  }

  factory UserModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return UserModel(
        id: document.id,
        fullname: data["fullname"],
        email: data["email"],
        phone: data["phone"],
        password: data["password"],
        level: data["level"]);
  }

  factory UserModel.fromRealtimeDatabase(DataSnapshot snapshot) {
    final data = snapshot.value as Map<dynamic, dynamic>;
    return UserModel(
      id: snapshot.key,
      fullname: data["fullname"],
      email: data["email"],
      phone: data["phone"],
      password: data["password"],
      level: data["level"],
    );
  }

}
