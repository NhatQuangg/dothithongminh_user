import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';

class ReflectModel {
  final String? id;
  final String? id_user;
  final String? title;
  final String? id_category;
  final String? content;
  final List<dynamic>? contentfeedback;
  final String? address;
  final List<dynamic>? media;

  // final List<dynamic>? likes;

  final bool? accept;
  final int? handle;
  final DateTime? createdAt;

  // final String? id_category;

  const ReflectModel({
    this.id,
    required this.id_user,
    // required this.likes,
    required this.title,
    required this.id_category,
    required this.content,
    required this.address,
    required this.media,
    required this.accept,
    required this.handle,
    required this.createdAt,
    required this.contentfeedback,
  });

  toJson() {
    return {
      "id_user": id_user,
      "title": title,
      "id_category": id_category,
      "content": content,
      "address": address,
      "media": media,
      "accept": accept,
      "handle": handle,
      // "Likes": likes,
      // "createdAt": createdAt,
      "createdAt": createdAt?.millisecondsSinceEpoch,
      "contentfeedback": contentfeedback
    };
  }

  factory ReflectModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return ReflectModel(
        id: document.id,
        id_user: data["id_user"],
        title: data["title"],
        id_category: data["id_category"],
        content: data["content"],
        address: data["address"],
        media: data["media"],
        accept: data["accept"],
        handle: data["handle"],
        createdAt: DateTime.fromMillisecondsSinceEpoch(data["createdAt"]),
        // createdAt: data["createdAt"],
        // likes: data["Likes"],
        contentfeedback: data["contentresponse"]);
  }

  factory ReflectModel.fromRealtimeDatabase(MapEntry<String, dynamic> entry) {
    final data = entry.value as Map<String, dynamic>;
    return ReflectModel(
      id: entry.key,
      id_user: data["id_user"],
      title: data["title"],
      id_category: data["id_category"],
      content: data["content"],
      address: data["address"],
      media: List<dynamic>.from(data["media"] ?? []),
      accept: data["accept"],
      handle: data["handle"],
      createdAt: data['createdAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(data['createdAt'])
          : null,
      contentfeedback: data['contentfeedback'],
    );
  }

  factory ReflectModel.fromRTDB(Map<String, dynamic> data) {
    return ReflectModel(
      id_user: data["id_user"],
      title: data["title"],
      id_category: data["id_category"],
      content: data["content"],
      address: data["address"],
      media: List<dynamic>.from(data["media"] ?? []),
      accept: data["accept"],
      handle: data["handle"],
      createdAt: (data['createdAt'] != null)
          ? DateTime.fromMicrosecondsSinceEpoch(data['createdAt'])
          : DateTime.now(),
      contentfeedback: data['contentfeedback'],
    );
  }
}