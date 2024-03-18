import 'package:dothithongminh_user/constants/constant.dart';
import 'package:dothithongminh_user/constants/global.dart';
import 'package:dothithongminh_user/test/test_controller.dart';
import 'package:dothithongminh_user/test/test_model.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TestRealTime extends StatelessWidget {
  TestRealTime({super.key});

  DatabaseReference ref = FirebaseDatabase.instance.ref('myapp');

  final nameController = TextEditingController();

  final dtbref = FirebaseDatabase.instance.ref('StoreData');

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  List<String> urls = ["url ne", "lai la url ne ne"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
          iconSize: 25,
        ),
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'THÔNG TIN CÁ NHÂN',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: mainColor,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextFormField(
              controller: nameController,
              decoration: InputDecoration(
                  hintText: "Name",
                  filled: true,
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: Colors.green, width: 2)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: Colors.black, width: 2))),
            ),
          ),
          ElevatedButton(
              onPressed: () async {
                final test = TestModel(
                  email: 'nhatquang',
                  media: urls,
                  accept: false,
                  handle: 1,
                  createdAt: DateTime.now(),
                );


                await dtbref
                    .push()
                    .set(test.toJson())
                    .then((value) => print("Thanh cong"))
                    .catchError((e) => print("loi"));

                // dtbref
                //     .child("b")
                //     .set({
                //   'id': 1,
                //   'name': nameController.text.toString(),
                //   'date': ServerValue.timestamp,
                //     })
                //     .then((_) => print('Special of the day has been written'))
                //     .catchError((e) => print("This error realtime: $e"));

                // firestore
                //     .collection('users')
                //     .add({
                //       'name': 'John Doe',
                //       'age': 30,
                //       'email': 'john@example.com',
                //     })
                //     .then((value) => print("User Added"))
                //     .catchError((error) => print("Failed to add user: $error"));
              },
              child: Text('Add')),
          Expanded(
            child: FirebaseAnimatedList(
              query: dtbref,
              itemBuilder: (context, snapshot, animation, index) {
                final Map<dynamic, dynamic>? data = snapshot.value as Map<dynamic, dynamic>?;

                if (data == null) {
                  return ListTile(
                    title: Text('No data available'),
                  );
                }

                final String email = data['email'] ?? '';
                final List<dynamic> media = data['media'] ?? [];
                final bool accept = data['accept'] ?? false;
                final int handle = data['handle'] ?? 0;
                final int? createdAtMilliseconds = data['createdAt'];
                final DateTime? createdAt = createdAtMilliseconds != null
                    ? DateTime.fromMillisecondsSinceEpoch(createdAtMilliseconds)
                    : null;

                print("đây là snapshot: ${snapshot.value}");
                return ListTile(
                  title: Text('Email: $email'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Media: ${media.join(', ')}'),
                      Text('Accept: $accept'),
                      Text('Handle: $handle'),
                      Text('Created At: ${createdAt ?? 'Unknown'}'),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
