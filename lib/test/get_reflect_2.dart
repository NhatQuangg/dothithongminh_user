import 'package:dothithongminh_user/constants/constant.dart';
import 'package:dothithongminh_user/constants/global.dart';
import 'package:dothithongminh_user/constants/icon_text.dart';
import 'package:dothithongminh_user/constants/utils.dart';
import 'package:dothithongminh_user/controller/profile_controller.dart';
import 'package:dothithongminh_user/model/reflect_model.dart';
import 'package:dothithongminh_user/pages/reflect_page/image_reflect/list_image.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';

class GetReflects2 extends StatefulWidget {
  // final String id;
  final ReflectModel reflect;

  const GetReflects2({super.key, required this.reflect});

  @override
  State<GetReflects2> createState() => _GetReflects2State();
}

class _GetReflects2State extends State<GetReflects2> {
  final ref = FirebaseDatabase.instance.ref("Reflects");
  String a = getEmail();
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
          'GETT ${a}',
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
                        title: widget.reflect.category!,
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

    // return Scaffold(
    //   appBar: AppBar(
    //     leading: IconButton(
    //       icon: Icon(Icons.arrow_back),
    //       onPressed: () {
    //         Navigator.of(context).pop();
    //       },
    //       iconSize: 25,
    //     ),
    //     iconTheme: IconThemeData(color: Colors.white),
    //     title: Text(
    //       'GET ${a}',
    //       style: TextStyle(color: Colors.white),
    //     ),
    //     backgroundColor: mainColor,
    //     centerTitle: true,
    //   ),
    //   body: Padding(
    //     padding: const EdgeInsets.all(8.0),
    //     child: Column(
    //       children: [
    //         Expanded(
    //           child: FirebaseAnimatedList(
    //             query: ref,
    //             itemBuilder: (context, snapshot, index, animation) {
    //               final id = snapshot.key.toString();
    //
    //               print(widget.reflect.category);
    //
    //               final title = snapshot.child("title").value.toString();
    //               // final content = snapshot.child("content").value.toString();
    //               // final category = snapshot.child("category").value.toString();
    //               // final handle = snapshot.child("handle").value as int;
    //               // final accept = snapshot.child("accept").value.toString();
    //               // final address = snapshot.child("address").value.toString();
    //               // final email = snapshot.child("email").value.toString();
    //
    //               // final timestamp = snapshot.child("createdAt").value as int;
    //               // final dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
    //               // final formattedDateTime = "${dateTime.day}/${dateTime.month}/${dateTime.year}";
    //               // final List<dynamic>? images = snapshot.child("media").value as List<dynamic>?;
    //
    //               return SingleChildScrollView(
    //                   child: Padding(
    //                     padding: EdgeInsets.only(left: 16, right: 16, top: 10),
    //                     child: Column(
    //                         mainAxisAlignment: MainAxisAlignment.start,
    //                         crossAxisAlignment: CrossAxisAlignment.start,
    //                         children: [
    //                           Row(
    //                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                               children: [
    //                                 iconAndText(
    //                                   textStyle: TextStyle(
    //                                       fontSize: 18, color: Colors.green),
    //                                   title: widget.reflect.category!,
    //                                   icon: Icons.menu,
    //                                 ),
    //                                 widget.reflect.handle == 1
    //                                     ? Text("Đang xử lý",
    //                                     style: TextStyle(
    //                                         fontSize: 18, color: Colors.red))
    //                                     : widget.reflect.handle == 0
    //                                     ? Text("Đã xử lý",
    //                                     style: TextStyle(
    //                                         fontSize: 18,
    //                                         color: Colors.green))
    //                                     : Text("",
    //                                     style: TextStyle(
    //                                         fontSize: 18,
    //                                         color: Colors.red)),
    //                               ]),
    //                         ]),
    //                   ));
    //
    //               // if(email == a) {
    //               //   return Padding(
    //               //     padding: const EdgeInsets.only(bottom: 12),
    //               //     child: Slidable(
    //               //       child: InkWell(
    //               //         child: Container(
    //               //           height: 125,
    //               //           decoration: BoxDecoration(
    //               //             color: Colors.white,
    //               //             boxShadow: [
    //               //               BoxShadow(
    //               //                 blurRadius: 6,
    //               //                 color: Color(0x34000000),
    //               //                 offset: Offset(0, 3),
    //               //               )
    //               //             ],
    //               //             borderRadius: BorderRadius.circular(8),
    //               //           ),
    //               //           child: Row(
    //               //             mainAxisSize: MainAxisSize.max,
    //               //             mainAxisAlignment: MainAxisAlignment.start,
    //               //             children: [
    //               //               images != null
    //               //                   ? Padding(
    //               //                 padding: const EdgeInsets.only(left: 7),
    //               //                 child: Container(
    //               //                   width: 110,
    //               //                   height: 106,
    //               //                   decoration: BoxDecoration(
    //               //                     color: Colors.black,
    //               //                     image: DecorationImage(
    //               //                         fit: BoxFit.cover,
    //               //                         image: Image.network(
    //               //                           images[0].toString(),
    //               //                         ).image
    //               //                     ),
    //               //                     borderRadius: BorderRadius.circular(8),
    //               //                   ),
    //               //                 ),
    //               //               )
    //               //                   : Center(
    //               //                 child: CircularProgressIndicator(),
    //               //               ),
    //               //
    //               //               Column(
    //               //                 children: [
    //               //                   Padding(
    //               //                     padding: EdgeInsetsDirectional.fromSTEB(12, 8, 0, 0),
    //               //                     child: SizedBox(
    //               //                       width: MediaQuery.of(context).size.width / 1.7,
    //               //                       child: Text(
    //               //                         '${title}',
    //               //                         style: TextStyle(
    //               //                             fontWeight: FontWeight.bold,
    //               //                             fontSize: 14
    //               //                         ),
    //               //                         textAlign: TextAlign.start,
    //               //                         maxLines: 1,
    //               //                         overflow: TextOverflow.ellipsis,
    //               //                       ),
    //               //                     ),
    //               //                   ),
    //               //
    //               //                   Padding(
    //               //                     padding: EdgeInsetsDirectional.fromSTEB(12, 5, 0, 0),
    //               //                     child: SizedBox(
    //               //                       width: MediaQuery.of(context).size.width / 1.7,
    //               //                       height: 50,
    //               //                       child: Text(
    //               //                         '${content}',
    //               //                         maxLines: 2,
    //               //                         overflow: TextOverflow.ellipsis,
    //               //                       ),
    //               //                     ),
    //               //                   ),
    //               //                   Padding(
    //               //                     // padding: EdgeInsets.all(0),
    //               //                     padding: EdgeInsetsDirectional.fromSTEB(12, 0, 12, 0),
    //               //                     child: SizedBox(
    //               //                       width: MediaQuery.of(context).size.width / 1.7,
    //               //                       child: Row(
    //               //                         mainAxisAlignment: MainAxisAlignment.start,
    //               //                         children: [
    //               //                           iconAndText(
    //               //                               textStyle: TextStyle(
    //               //                                   fontSize: 12
    //               //                               ),
    //               //                               size: 12,
    //               //                               title:  '${formattedDateTime}', // formatedDate,
    //               //                               icon: Icons.calendar_month
    //               //                           ),
    //               //                         ],
    //               //                       ),
    //               //                     ),
    //               //                   ),
    //               //
    //               //                   SizedBox(height: 2),
    //               //
    //               //                   Padding(
    //               //                     //padding: EdgeInsets.all(0),
    //               //                     padding: EdgeInsetsDirectional.fromSTEB(12, 0, 12, 0),
    //               //                     child: SizedBox(
    //               //                       width: MediaQuery.of(context).size.width / 1.7,
    //               //                       child: Row(
    //               //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //               //                         children: [
    //               //                           iconAndText(
    //               //                               textStyle: TextStyle(fontSize: 12),
    //               //                               size: 12,
    //               //                               title: '${category}',
    //               //                               icon: Icons.bookmark
    //               //                           ),
    //               //                           if (handle == 1)
    //               //                             Text(
    //               //                               'Đang xử lý',
    //               //                               style: TextStyle(
    //               //                                   fontSize: 12,
    //               //                                   color: Colors.red
    //               //                               ),
    //               //                             )
    //               //                           else if (handle == 0)
    //               //                             Text(
    //               //                               'Đã xử lý',
    //               //                               style: TextStyle(
    //               //                                   fontSize: 12,
    //               //                                   color: Colors.blue
    //               //                               ),
    //               //                             )
    //               //                         ],
    //               //                       ),
    //               //                     ),
    //               //                   ),
    //               //                 ],
    //               //               )
    //               //             ],
    //               //           ),
    //               //         ),
    //               //       ),
    //               //     ),
    //               //   );
    //               // }
    //               // else {
    //               //   return SizedBox.shrink();
    //               // }
    //             },
    //           ),
    //         )
    //       ],
    //     ),
    //   ),
    // );
  }
}
