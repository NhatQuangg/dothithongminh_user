import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';

class DownFile extends StatefulWidget {
  const DownFile({super.key});

  @override
  State<DownFile> createState() => _DownFileState();
}

class _DownFileState extends State<DownFile> {

  // Future<void> requestPermissions() async {
  //   await Permission.storage.request();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            downloadFile();
          },
          child: Text("Down"),
        ),
      ),
    );
  }


  Future<void> downloadFile() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            padding: EdgeInsets.all(20.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(),
                SizedBox(width: 20),
                Text("Downloading..."),
              ],
            ),
          ),
        );
      },
    );

    var status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
      status = await Permission.storage.status;
      if (!status.isGranted) {
        Navigator.pop(context);
        return;
      }
    }

    var time = DateTime.now().microsecondsSinceEpoch;
    var path = "/storage/emulated/0/Download/document-$time.pdf";
    var file = File(path);
    var res = await http.get(Uri.parse("https://www.ibm.com/downloads/cas/GJ5QVQ7X"));

    await file.writeAsBytes(res.bodyBytes);

    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("File downloaded successfully"),
    ));
  }
}
