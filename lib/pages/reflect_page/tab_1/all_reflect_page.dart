import 'package:dothithongminh_user/constants/constant.dart';
import 'package:dothithongminh_user/constants/icon_text.dart';
import 'package:dothithongminh_user/constants/utils.dart';
import 'package:dothithongminh_user/controller/category_controller.dart';
import 'package:dothithongminh_user/controller/profile_controller.dart';
import 'package:dothithongminh_user/controller/reflect_controller.dart';
import 'package:dothithongminh_user/model/reflect_model.dart';
import 'package:dothithongminh_user/pages/reflect_page/detail_reflect_page/detail_reflect_page.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';

class AllReflectPage extends StatefulWidget {
  const AllReflectPage({super.key});

  @override
  State<AllReflectPage> createState() => _AllReflectPageState();
}

class _AllReflectPageState extends State<AllReflectPage> {
  final controller = Get.put(ReflectController());
  final controllerProfile = Get.put(ProfileController());
  final categoryController = Get.put(CategoryController());

  List<dynamic> dataList = [];
  final ref = FirebaseDatabase.instance.ref("Reflects");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: FirebaseAnimatedList(
                query: ref,
                itemBuilder: (context, snapshot, index, animation) {
                  final key = snapshot.key.toString();
                  final title = snapshot.child("title").value.toString();
                  final content = snapshot.child("content").value.toString();
                  final id_category = snapshot.child("id_category").value.toString();
                  final handle = snapshot.child("handle").value as int;
                  final accept = snapshot.child("accept").value as bool;
                  final address = snapshot.child("address").value.toString();
                  final id_user = snapshot.child("id_user").value.toString();
                  final contentfeedback = snapshot.child("contentfeedback").value as List<dynamic>?;
                  final timestamp = snapshot.child("createdAt").value as int;
                  final dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
                  final formattedDateTime = "${dateTime.day}/${dateTime.month}/${dateTime.year}";
                  final List<dynamic>? images = snapshot.child("media").value as List<dynamic>?;

                  print(images![0]);

                  print(images![0].split('.').last);
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Slidable(
                      child: InkWell(
                        onTap: () {
                          ReflectModel reflectModel = ReflectModel(
                            id: key,
                            id_user: id_user,
                            title: title,
                            id_category: id_category,
                            content: content,
                            contentfeedback: contentfeedback ?? [],
                            address: address,
                            media: images,
                            accept: accept,
                            handle: handle,
                            createdAt: dateTime,
                          );

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailReflectPage(reflect: reflectModel),
                            ),
                          ).then((value) {
                            setState(() {});
                          });
                        },
                        child: Container(
                          height: 140,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 6,
                                color: Color(0x34000000),
                                offset: Offset(0, 3),
                              )
                            ],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              // isImageFromPath(images![0].split('.').last)
                              //  ? Text("")
                              // : Text("ha"),

                              images != null
                                  ? Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Container(
                                  width: 115,
                                  height: 110,
                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: Image.network(
                                          images[0].toString(),
                                        ).image
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                              )
                                  : Center(
                                child: CircularProgressIndicator(),
                              ),

                              Column(
                                children: [

                                  // title
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(12, 8, 0, 0),
                                    child: SizedBox(
                                      width: MediaQuery.of(context).size.width / 1.7,
                                      child: Text(
                                        '${title}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14
                                        ),
                                        textAlign: TextAlign.start,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),

                                  // content
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(12, 5, 0, 0),
                                    child: SizedBox(
                                      width: MediaQuery.of(context).size.width / 1.7,
                                      height: 50,
                                      child: Text(
                                        '${content}',
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),

                                  // datetime
                                  Padding(
                                    // padding: EdgeInsets.all(0),
                                    padding: EdgeInsetsDirectional.fromSTEB(12, 0, 12, 0),
                                    child: SizedBox(
                                      width: MediaQuery.of(context).size.width / 1.7,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          iconAndText(
                                              textStyle: TextStyle(
                                                  fontSize: 12
                                              ),
                                              size: 12,
                                              title:  '${formattedDateTime}', // formatedDate,
                                              icon: Icons.calendar_month
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),

                                  SizedBox(height: 2),

                                  //
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(12, 0, 12, 0),
                                    child: SizedBox(
                                      width: MediaQuery.of(context).size.width / 1.7,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [

                                          // Category
                                          FutureBuilder<String>(
                                            future: categoryController.getCategoryNameById(id_category),
                                            builder: (context, snapshot) {
                                              if (snapshot.connectionState == ConnectionState.waiting) {
                                                return CircularProgressIndicator(); // Hiển thị loading khi đang lấy dữ liệu
                                              }
                                              if (snapshot.hasError) {
                                                return Text('Error id_category: ${snapshot.error}'); // Hiển thị lỗi nếu có
                                              }
                                              return iconAndText(
                                                  textStyle: TextStyle(fontSize: 12),
                                                  size: 12,
                                                  title: "${snapshot.data}",
                                                  icon: Icons.bookmark
                                              );
                                            },
                                          ),

                                          // Handle
                                          if (handle == 1)
                                            Text(
                                              'Đang xử lý',
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.red
                                              ),
                                            )
                                          else if (handle == 0)
                                            Text(
                                              'Đã xử lý',
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.blue
                                              ),
                                            )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),

    );
  }
}

String getFileName(String url) {
  RegExp regExp = new RegExp(r'.+(\/|%2F)(.+)\?.+');
  var matches = regExp.allMatches(url);

  var match = matches.elementAt(0);

  return Uri.decodeFull(match.group(2)!);
}