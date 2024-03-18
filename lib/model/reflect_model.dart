import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';

class ReflectModel {
  final String? id;
  final String? email;
  final String? title;
  final String? category;
  final String? content;
  final String? content_response;
  final String? address;
  final List<dynamic>? media;

  // final List<dynamic>? likes;

  final bool? accept;
  final int? handle;
  final DateTime? createdAt;
  // final Timestamp? createdAt;

  const ReflectModel({
    this.id,
    required this.email,
    // required this.likes,
    required this.title,
    required this.category,
    required this.content,
    required this.address,
    required this.media,
    required this.accept,
    required this.handle,
    required this.createdAt,
    required this.content_response,
  });

  toJson() {
    return {
      "email": email,
      "title": title,
      "category": category,
      "content": content,
      "address": address,
      "media": media,
      "accept": accept,
      "handle": handle,
      // "Likes": likes,
      // "createdAt": createdAt,
      "createdAt": createdAt?.millisecondsSinceEpoch,
      "contentfeedback": content_response
    };
  }

  factory ReflectModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return ReflectModel(
        id: document.id,
        email: data["email"],
        title: data["title"],
        category: data["category"],
        content: data["content"],
        address: data["address"],
        media: data["media"],
        accept: data["accept"],
        handle: data["handle"],
        createdAt: DateTime.fromMillisecondsSinceEpoch(data["createdAt"]),
        // createdAt: data["createdAt"],
        // likes: data["Likes"],
        content_response: data["contentresponse"]);
  }

  factory ReflectModel.fromRealtimeDatabase(MapEntry<String, dynamic> entry) {
    final data = entry.value as Map<String, dynamic>;
    return ReflectModel(
      id: entry.key,
      email: data["email"],
      title: data["title"],
      category: data["category"],
      content: data["content"],
      address: data["address"],
      media: List<dynamic>.from(data["media"] ?? []),
      accept: data["accept"],
      handle: data["handle"],
      createdAt: data['createdAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(data['createdAt'])
          : null,
      content_response: data['contentfeedback'],
    );
  }

  factory ReflectModel.fromRTDB(Map<String, dynamic> data) {
    return ReflectModel(
      email: data["email"],
      title: data["title"],
      category: data["category"],
      content: data["content"],
      address: data["address"],
      media: List<dynamic>.from(data["media"] ?? []),
      accept: data["accept"],
      handle: data["handle"],
      createdAt: (data['createdAt'] != null)
          ? DateTime.fromMicrosecondsSinceEpoch(data['createdAt'])
          : DateTime.now(),
      content_response: data['contentfeedback'],
    );
  }
}
