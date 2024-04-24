import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';

class DownFile extends StatefulWidget {
  const DownFile({super.key});

  @override
  State<DownFile> createState() => _DownFileState();
}

class _DownFileState extends State<DownFile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            print("he");
            openFile (
              // url: 'https://storage.googleapis.com/dothithongminhkl.appspot.com/test/66267f316432d/Phone%20Number.pdf?GoogleAccessId=firebase-adminsdk-t9j4m%40dothithongminhkl.iam.gserviceaccount.com&Expires=1713823200&Signature=PUZ7h39TwMxmbr5nfnVCElfJGKdqoMvxChRx52uAvzY9va8VRRXHRQSSLjc6SXbyEyqkFAT2UKVvM1MaN2RzwGy6YTPynNO89k3oX%2BFLVxPNempEZOjeRoVlqru%2BYDfSTjxdqgQUBzTDCgtnkCQvLzZ6eA5ltSn%2BWJ40tJAwyihXYoqvYPGf0GB%2BSMOkiZh1p2ICcb1e%2Bj0vyZLG0a42jNWgiOwkiPFTNhAc2V1ILL7PjqF9u8DwM%2FXHL0dL4hxHfNRdRaiKafaXmXdxIzogDl9h5klMCpAmhSEuspvuz4sGI%2BluLAcXGVG20sogAkLWFGimJrxzdm1%2BlHgr89wmhA%3D%3D&generation=1713798964632569',
              url: 'https://storage.googleapis.com/dothithongminhkl.appspot.com/test/6626869e1f7d3/3127074-hd_1920_1080_24fps.mp4?GoogleAccessId=firebase-adminsdk-t9j4m%40dothithongminhkl.iam.gserviceaccount.com&Expires=1713823200&Signature=iprvoF4VTyO4AnxmqrjONkSWQpdkUO9CSzJh2eGDBPsMMBvykl6NoMdxMWRL8NwCLAzY86Qvk56lrdseyN5SOQWgsg%2FOFS%2BPCD2wXk1zKufhngUDYplqZmK1ouvA4Dm2AzaCTitXAbHox8yzBXQDj%2BUXOGv0JckgYWCqgEiw%2Bndu89I%2B%2FLrfU98ssY2qv1dIXJ%2FCSFE7tZJRLJefLSo%2FOdfTRq%2Bycsg7w5wBXj80UR47g9z8937IO1rDC5mu5kHM%2FdTHRzmvRMU6tZzTyGUqv4rLSXpLq%2FanXkAqmh1wgAVW7qitjIwzp5c9m7J8wFFDsXhdMrqS1e1bMiZfGXR%2Big%3D%3D&generation=1713800868678646',
              filename: 'video.mp4'
            );
          },
          child: Text("Down"),
        ),
      ),
    );
  }

  Future openFile ({required String url, String? filename}) async {
    // url : dduong dan
    // filename: 'video.mp4'
    final file = await downloadFile(url, filename!);
    if (file == null) return;
    print('Path: ${file.path}');
    OpenFile.open(file.path);
  }

  Future<File?> downloadFile (String url, String filename) async {
    final appStorage = await getApplicationDocumentsDirectory();

    final file = File('${appStorage.path}/$filename');

    final response = await Dio().get(
      url,
      options: Options(
        responseType: ResponseType.bytes,
        followRedirects: false,
        receiveTimeout: Duration(seconds: 0),
      )
    );

    final raf = file.openSync(mode: FileMode.write);
    raf.writeFromSync(response.data);
    await raf.close();

    return file;


  }

}
