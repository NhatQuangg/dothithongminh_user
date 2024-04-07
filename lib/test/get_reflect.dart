import 'package:flutter/material.dart';

class TextURL extends StatefulWidget {
  const TextURL({super.key});

  @override
  State<TextURL> createState() => _TextURLState();
}

class _TextURLState extends State<TextURL> {

  String url = 'https://firebasestorage.googleapis.com/v0/b/dothithongminhkl.appspot.com/o/ListingImages%2Fjjwfqlfna%2Fdata%2Fuser%2F0%2Fn.quang.dothithongminh_user%2Fcache%2Ffile_picker%2Fpexels-moose-photos-1037992.mp4?alt=media&token=d0cf56fe-73ff-49bb-9309-af9e93fe8a60';

  bool isJpgExtension(String url) {
    List<String> parts = url.split('?');
    print(parts);
    String lastPart = parts.firstWhere((part) => part.isNotEmpty, orElse: () => '');
    List<String> extensionParts = lastPart.split('.');
    print(extensionParts);
    String extension = extensionParts.last.toLowerCase();
    print(extension);

    return isImageOrVideoFromUrl(extension);
  }

  bool isImageOrVideoFromUrl(String url) {
    if (url == 'jpg' || url == 'png' || url == 'jpeg') {
      return true; // Hình ảnh
    } else if (url == 'mp4') {
      return false; // Video
    } else {
      return false; // Trường hợp khác
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isImage = isJpgExtension(url);
    return Scaffold(
      appBar: AppBar(
        title: Text('Kiểm tra URL'),
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              isImage ? 'URL là một hình ảnh' : 'URL là một video',
              style: TextStyle(fontSize: 20),
            ),
            Center(
              child: Container(
                height: 200,
                width:
                MediaQuery.of(context)
                    .size
                    .width,
                decoration: BoxDecoration(
                    color:
                    Colors.grey[200]),
                child: Center(
                  child: Image.asset(
                    "assets/video.png",
                    height: 50,
                    width: 50,
                  ),
                ),
              ),
            ),
          ],
        )

      ),
    );
  }
}
