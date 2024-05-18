import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dothithongminh_user/constants/constant.dart';
import 'package:dothithongminh_user/constants/global.dart';
import 'package:dothithongminh_user/constants/icon_text.dart';
import 'package:dothithongminh_user/constants/like_button.dart';
import 'package:dothithongminh_user/controller/category_controller.dart';
import 'package:dothithongminh_user/model/reflect_model.dart';
import 'package:dothithongminh_user/model/user_model.dart';
import 'package:dothithongminh_user/pages/reflect_page/image_reflect/image_slide.dart';
import 'package:dothithongminh_user/pages/reflect_page/image_reflect/list_image.dart';
import 'package:dothithongminh_user/pages/reflect_page/video_reflect/video_player.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;


class DetailReflectPage extends StatefulWidget {
  final ReflectModel reflect;

  const DetailReflectPage({super.key, required this.reflect});

  @override
  State<DetailReflectPage> createState() => _DetailReflectPageState();
}

class _DetailReflectPageState extends State<DetailReflectPage> {

  final ref = FirebaseDatabase.instance.ref("Reflects");
  final currentUserId = FirebaseAuth.instance.currentUser?.uid ?? '';
  late bool isLiked;
  String email = getEmail();
  final categoryController = Get.put(CategoryController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isLiked = widget.reflect.likes?.contains(currentUserId) ?? false;
  }

  Future<void> downloadFile(String url) async {
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
    var res = await http.get(Uri.parse(url));

    await file.writeAsBytes(res.bodyBytes);

    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("File downloaded successfully"),
    ));
  }

  @override
  Widget build(BuildContext context) {
    List<dynamic> contentFeedbackList = [];
    for (int i = 2; i < widget.reflect.contentfeedback!.length; i++) {
      contentFeedbackList.add(widget.reflect.contentfeedback![i]);
    }
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
            'CHI TIẾT PHẢN ẢNH',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: mainColor,
          centerTitle: true,
        ),
        body: ListView.builder(
          itemCount: 1,
          itemBuilder: (context, index) {
            final date = widget.reflect.createdAt;
            final formattedDateTime = "${date!.day}/${date!.month}/${date!.year}";
            final demo = widget.reflect.contentfeedback!;
            print("Ngày tháng năm: $formattedDateTime");
            print("title: ${widget.reflect.title}");

            return Padding(
              padding: EdgeInsets.only(left: 16, right: 16, top: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        FutureBuilder<String>(
                          future: categoryController.getCategoryNameById(widget.reflect.id_category!),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return CircularProgressIndicator();
                            }
                            if (snapshot.hasError) {
                              return Text('Error id_category: ${snapshot.error}');
                            }
                            return iconAndText(
                              textStyle: TextStyle(fontSize: 18, color: Colors.green),
                              size: 14,
                              title: "${snapshot.data}",
                              icon: Icons.bookmark,
                            );
                          },
                        ),
                        widget.reflect.handle == 1
                            ? Text(
                            "Đang xử lý",
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.red
                            )
                        )
                            : widget.reflect.handle == 0
                            ? Text(
                            "Đã xử lý",
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.blue
                            )
                        )
                            : Text(
                            "",
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.red
                            )
                        ),
                      ]
                  ),
                  SizedBox(height: 10,),
                  Text(
                    "${widget.reflect.title}",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 10,),
                  Row(
                    children: [
                      if (widget.reflect.address != '')
                        Icon(Icons.location_on_outlined),
                        SizedBox(width: 10),
                        Expanded(
                          child: widget.reflect.address == ''
                              ? SizedBox()
                              : Text(
                            '${widget.reflect.address}',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                            maxLines: 5,
                          ),
                        ),
                    ],
                  ),
                  SizedBox(height: 10,),
                  Row(
                    children: [
                      Icon(Icons.calendar_month,),
                      SizedBox(width: 10,),
                      Text(
                          formattedDateTime,
                          style: TextStyle(
                            fontSize: 16,
                          )
                      ),
                    ],
                  ),
                  SizedBox(height: 10,),
                  widget.reflect.media!.length == 0
                      ? SizedBox()
                      : ZoomImage(images: widget.reflect.media),
                  SizedBox(height: 10,),

                  Container(
                    child: Text(
                      "${widget.reflect.content}",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                  SizedBox(height: 10,),

                  // if (widget.reflect.contentfeedback!.isNotEmpty)
                  //   ...widget.reflect.contentfeedback!.map((reflect) {
                  //     return Text(reflect);
                  //   })

                  // if (widget.reflect.contentfeedback!.isNotEmpty)
                  //   Text(widget.reflect.contentfeedback![0]),
                  // if (widget.reflect.contentfeedback!.isNotEmpty)
                  //   Text(widget.reflect.contentfeedback![0]),

                  widget.reflect.contentfeedback!.isNotEmpty
                      ? Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Color(0xFFE9F3FF), // Chọn màu nền tùy thích
                    ),
                    child: DottedBorder(
                      dashPattern: [12, 7],
                      strokeWidth: 1.5,
                      color: Colors.blue,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Kết quả xử lý",
                                  style: TextStyle(
                                      fontSize: 17,
                                      color: Colors.blue,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              'Hạn xử lý: ${widget.reflect.contentfeedback![0]}',
                              style: TextStyle(fontSize: 16),
                              textAlign: TextAlign.justify,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              widget.reflect.contentfeedback![1],
                              style: TextStyle(fontSize: 16),
                              textAlign: TextAlign.justify,
                            ),
                          ),
                          widget.reflect.contentfeedback![2].isNotEmpty
                          ? Wrap(
                            alignment: WrapAlignment.start,
                            runSpacing: 5,
                            spacing: 5,
                            children: contentFeedbackList.map((e) {
                              if (e.toString().toLowerCase().contains('.jpg') || e.toString().toLowerCase().contains('.png') || e.toString().toLowerCase().contains('.jpeg')) {
                                debugPrint("hehe: ${e.toString().contains('jpg')}");
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.of(context,
                                        rootNavigator: true)
                                        .push(MaterialPageRoute(
                                        builder: (_) => ImageSlider(
                                          images: [e],
                                          pageIndex: 0,
                                        )));
                                  },
                                  child: Container(
                                    width: 150,
                                    height: 150,
                                    clipBehavior: Clip.hardEdge,
                                    decoration: BoxDecoration(
                                        border: Border.all(),
                                        borderRadius:
                                        BorderRadius.circular(10)),
                                    child: ClipRRect(
                                      borderRadius:
                                      BorderRadius.circular(5),
                                      child: CachedNetworkImage(
                                        fit: BoxFit.contain,
                                        imageUrl: e,
                                      ),
                                    ),
                                  ),
                                );
                              }
                              if (e.toString().contains('mp4') || e.toString().contains('mkv')) {
                                debugPrint("mp4: ${e.toString().contains('mp4')}");
                                return Container(
                                  width: 150,
                                  height: 150,
                                  clipBehavior: Clip.hardEdge,
                                  decoration: BoxDecoration(
                                      border: Border.all(),
                                      borderRadius:
                                      BorderRadius.circular(10)),
                                  child:
                                  VideoPlayerCustom(e, UniqueKey()),
                                );
                              }
                              return GestureDetector(
                                onTap: () {
                                  print('hah');
                                  downloadFile(e.toString());
                                },
                                child: Container(
                                  width: 100,
                                  height: 40,
                                  clipBehavior: Clip.hardEdge,
                                  decoration: BoxDecoration(
                                      border: Border.all(),
                                      borderRadius:
                                      BorderRadius.circular(10)),
                                  child: const Center(
                                      child: Text('File PDF')),
                                ),
                              );
                            }).toList(),
                          )
                              : SizedBox(),
                        ],
                      ),
                    ),
                  )
                      : SizedBox(),
                  SizedBox(height: 20,),
                  LikeButton(isLiked: isLiked, reflectModel: widget.reflect, likeCount: widget.reflect.likes!.length),
                  SizedBox(height: 20,),

                ],
              ),
            );
          },
        )
    );
  }
}