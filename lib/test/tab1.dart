import 'dart:io';

import 'package:dothithongminh_user/model/reflect_model.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class tab1 extends StatefulWidget {
  const tab1({super.key});

  @override
  State<tab1> createState() => _tab1State();
}

class _tab1State extends State<tab1> {


  List<ReflectModel> reflects = [];

  @override
  void initState() {
    super.initState();
    fetchReflectsFromFirebase();
  }

  void fetchReflectsFromFirebase() {
    DatabaseReference reflectsRef = FirebaseDatabase.instance.ref().child('reflects');
    reflectsRef.onValue.listen((event) {
      dynamic data = event.snapshot.value;
      if (data != null && data is Map<dynamic, dynamic>) {
        List<ReflectModel> newReflects = [];
        data.forEach((key, value) {
          newReflects.add(ReflectModel.fromRTDB(value));
        });
        setState(() {
          reflects = newReflects;
        });
      }
    });
  }

  // @override
  Widget build(BuildContext context) {
    final _rd = FirebaseDatabase.instance.ref();
    fetchReflectsFromFirebase();
    return Scaffold(
      appBar: AppBar(
        title: Text("test"),
      ),
      body: ListView.builder(
        itemCount: reflects.length,
        itemBuilder: (context, index) {
          print("Day la: ${reflects[0].title}");
          return ListTile(
            title: Text(reflects[index].title ?? ''),
            subtitle: Text(reflects[index].content ?? ''),
            // Add more fields as needed
          );
        },
      ),
    );
  }
}
