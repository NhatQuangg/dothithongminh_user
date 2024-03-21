import 'package:dothithongminh_user/constants/constant.dart';
import 'package:dothithongminh_user/constants/global.dart';
import 'package:dothithongminh_user/constants/icon_text.dart';
import 'package:dothithongminh_user/model/reflect_model.dart';
import 'package:dothithongminh_user/model/user_model.dart';
import 'package:dothithongminh_user/pages/reflect_page/image_reflect/list_image.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class DetailReflectPage extends StatefulWidget {
  final ReflectModel reflect;

  const DetailReflectPage({super.key, required this.reflect});

  @override
  State<DetailReflectPage> createState() => _DetailReflectPageState();
}

class _DetailReflectPageState extends State<DetailReflectPage> {

  final ref = FirebaseDatabase.instance.ref("Reflects");
  String email = getEmail();
  // ProfileController profileController = Get.find<ProfileController>();

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
                        iconAndText(
                          textStyle: TextStyle(
                              fontSize: 18, color: Colors.green
                          ),
                          title: widget.reflect.id_category!,
                          icon: Icons.menu,
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
                ],
              ),
            );
          },
        )
    );
  }
}
