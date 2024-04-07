import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';

class TestModel {
  final String? id;
  final String? title;
  final String? content;
  final String? contentfeedback;

  const TestModel({
    this.id,
    required this.title,
    required this.content,
    required this.contentfeedback,
  });

  toJson() {
    return {
      "title": title,
      "content": content,
      "contentfeedback": contentfeedback
    };
  }

  factory TestModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return TestModel(
        id: document.id,
        title: data["Title"],
        content: data["Content"],
        contentfeedback: data["contentfeedback"]);
  }

  factory TestModel.fromRealtimeDatabase(DataSnapshot snapshot) {
    final daata = snapshot.value as Map<String, dynamic>;
    return TestModel(
      id: snapshot.key,
      title: daata['title'],
      content: daata['content'],
      contentfeedback: daata['contentfeedback'],
    );
  }
}