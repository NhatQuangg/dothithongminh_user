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
                              return CircularProgressIndicator(); // Hiển thị loading khi đang lấy dữ liệu
                            }
                            if (snapshot.hasError) {
                              return Text('Error id_category: ${snapshot.error}'); // Hiển thị lỗi nếu có
                            }
                            return iconAndText(
                              textStyle: TextStyle(fontSize: 18, color: Colors.green),
                              size: 12,
                              title: "${snapshot.data}",
                              icon: Icons.menu,
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
                                color: Colors.green
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
                      Icon(Icons.map),
                      SizedBox(width: 10),
                      Expanded(
                        child: widget.reflect.address == ''
                            ? Text(
                          'B301',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                          maxLines: 2,
                        )
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Phường Phú Bài HN",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                          Container(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              widget.reflect.contentfeedback![0],
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
                          Wrap(
                            alignment: WrapAlignment.start,
                            runSpacing: 5,
                            spacing: 5,
                            children: contentFeedbackList.map((e) {
                              if (e.toString().contains('jpg')) {
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
                                    width: 200,
                                    height: 200,
                                    clipBehavior: Clip.hardEdge,
                                    decoration: BoxDecoration(
                                        border: Border.all(),
                                        borderRadius:
                                        BorderRadius.circular(10)),
                                    child: ClipRRect(
                                      borderRadius:
                                      BorderRadius.circular(5),
                                      child: CachedNetworkImage(
                                        fit: BoxFit.cover,
                                        imageUrl: e,
                                      ),
                                    ),
                                  ),
                                );
                              }
                              if (e.toString().contains('mp4')) {
                                debugPrint("mp4: ${e.toString().contains('mp4')}");
                                return Container(
                                  width: 200,
                                  height: 200,
                                  clipBehavior: Clip.hardEdge,
                                  decoration: BoxDecoration(
                                      border: Border.all(),
                                      borderRadius:
                                      BorderRadius.circular(10)),
                                  child:
                                  VideoPlayerCustom(e, UniqueKey()),
                                );
                              }
                              return Container(
                                width: 150,
                                height: 150,
                                clipBehavior: Clip.hardEdge,
                                decoration: BoxDecoration(
                                    border: Border.all(),
                                    borderRadius:
                                    BorderRadius.circular(10)),
                                child: const Center(
                                    child: Text('PDF file or some file')),
                              );
                            }).toList(),
                          ),
                          // for (int i = 2; i < widget.reflect.contentfeedback!.length; i++)
                          //   Container(
                          //     padding: EdgeInsets.all(10),
                          //     child: Text(
                          //       widget.reflect.contentfeedback![i],
                          //       style: TextStyle(fontSize: 16),
                          //       textAlign: TextAlign.justify,
                          //     ),
                          //   ),
                          // for (int i = 2; i < widget.reflect.contentfeedback!.length; i++)
                          //   GestureDetector(
                          //     onTap: () {
                          //       _launchURL(widget.reflect.contentfeedback![i]);
                          //     },
                          //     child: Container(
                          //       padding: EdgeInsets.all(10),
                          //       child: Text(
                          //         widget.reflect.contentfeedback![i],
                          //         style: TextStyle(
                          //           fontSize: 16,
                          //           color: Colors.blue, // Màu của liên kết
                          //           decoration: TextDecoration.underline, // Gạch chân liên kết
                          //         ),
                          //         textAlign: TextAlign.justify,
                          //       ),
                          //     ),
                          //   ),
                        ],
                      ),
                    ),
                  )
                      : SizedBox(),
                  SizedBox(height: 20,),
                  LikeButton(isLiked: isLiked, reflectModel: widget.reflect, likeCount: widget.reflect.likes!.length),
                  // Text(widget.reflect.likes!.length.toString()),
                  SizedBox(height: 20,),

                ],
              ),
            );
          },
        )
    );
  }
}