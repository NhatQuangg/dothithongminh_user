  import 'package:dothithongminh_user/constants/constant.dart';
  import 'package:dothithongminh_user/constants/global.dart';
  import 'package:dothithongminh_user/constants/icon_text.dart';
  import 'package:dothithongminh_user/constants/utils.dart';
  import 'package:dothithongminh_user/controller/category_controller.dart';
  import 'package:dothithongminh_user/controller/profile_controller.dart';
import 'package:dothithongminh_user/controller/reflect_controller.dart';
  import 'package:dothithongminh_user/model/category__model.dart';
  import 'package:dothithongminh_user/model/reflect_model.dart';
  import 'package:dothithongminh_user/pages/reflect_page/image_reflect/list_image.dart';
  import 'package:firebase_database/firebase_database.dart';
  import 'package:firebase_database/ui/firebase_animated_list.dart';
  import 'package:flutter/material.dart';
  import 'package:flutter_slidable/flutter_slidable.dart';
  import 'package:get/get.dart';

  class GetReflects2 extends StatefulWidget {
    const GetReflects2({super.key});

    @override
    State<GetReflects2> createState() => _GetReflects2State();
  }

  class _GetReflects2State extends State<GetReflects2> {
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

                    final id_category = snapshot.child("id_category").value.toString();
                    final title = snapshot.child("title").value.toString();


                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Slidable(
                        child: InkWell(
                          onTap: () {
                            print("Key: $key");
                          },
                          child: Container(
                            height: 125,
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
                              children: [
                                Column(
                                  children: [
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
                                  ],
                                ),
                                FutureBuilder<String>(
                                  future: categoryController.getCategoryNameById(id_category),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState == ConnectionState.waiting) {
                                      return CircularProgressIndicator(); // Hiển thị loading khi đang lấy dữ liệu
                                    }
                                    if (snapshot.hasError) {
                                      return Text('Error: ${snapshot.error}'); // Hiển thị lỗi nếu có
                                    }
                                    return Text(snapshot.data ?? 'Unknown'); // Hiển thị tên danh mục
                                  },
                                ),
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
