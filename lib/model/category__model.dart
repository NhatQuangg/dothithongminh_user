import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';

class CategoryModel {
  final String? id;
  final String? category_name;

  const CategoryModel({
    this.id,
    required this.category_name,
  });

  toJson() {
    return {
      "category_name": category_name,
    };
  }

  // factory CategoryModel.fromSnapshot(DataSnapshot snapshot) {
  //   Map<dynamic, dynamic> data = snapshot.value as Map<dynamic, dynamic>;
  //   return CategoryModel(
  //     id: snapshot.key,
  //     category_name: data['category_name'],
  //   );
  // }
}
