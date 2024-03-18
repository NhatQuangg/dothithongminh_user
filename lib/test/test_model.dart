import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';

class TestModel {
  final String? id;
  final String? email;
  final List<dynamic>? media;
  final bool? accept;
  final int? handle;
  final DateTime? createdAt;

  const TestModel({
    this.id,
    required this.email,
    required this.media,
    required this.accept,
    required this.handle,
    required this.createdAt,
  });

  toJson() {
    return {
      "email": email,
      "media": media,
      "accept": accept,
      "handle": handle,
      "createdAt": createdAt?.millisecondsSinceEpoch,
    };
  }

  factory TestModel.fromJson(Map<String, dynamic> json) {
    return TestModel(
      id: json['id'],
      email: json['email'],
      media: List<String>.from(json['media']),
      accept: json['accept'],
      handle: json['handle'],
      createdAt: json['createdAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(json['createdAt'])
          : null,
    );
  }

  factory TestModel.fromRealtimeDatabase(DataSnapshot snapshot) {
    final data = snapshot.value as Map<dynamic, dynamic>;
    return TestModel(
      id: snapshot.key,
      email: data['email'],
      media: List<String>.from(data['media']),
      accept: data['accept'],
      handle: data['handle'],
      createdAt: data['createdAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(data['createdAt'])
          : null,
    );
  }

  // factory ReflectModel.fromSnapshot(
  //     DocumentSnapshot<Map<String, dynamic>> document) {
  //   final data = document.data()!;
  //   return ReflectModel(
  //       id: document.id,
  //       email: data["email"],
  //       media: data["media"],
  //       accept: data["accept"],
  //       handle: data["handle"],
  //       createdAt: DateTime.fromMillisecondsSinceEpoch(data["createdAt"]));
  // }
}
