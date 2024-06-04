import 'package:dothithongminh_user/constants/constant.dart';
import 'package:dothithongminh_user/constants/icon_text.dart';
import 'package:dothithongminh_user/controller/category_controller.dart';
import 'package:dothithongminh_user/controller/profile_controller.dart';
import 'package:dothithongminh_user/controller/reflect_controller.dart';
import 'package:dothithongminh_user/model/reflect_model.dart';
import 'package:dothithongminh_user/pages/reflect_page/detail_reflect_page/detail_reflect_page.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:diacritic/diacritic.dart';

class SearchReflectPage extends StatefulWidget {
  const SearchReflectPage({super.key});

  @override
  State<SearchReflectPage> createState() => _SearchReflectPageState();
}

class _SearchReflectPageState extends State<SearchReflectPage> {
  final controller = Get.put(ReflectController());
  final controllerProfile = Get.put(ProfileController());
  final categoryController = Get.put(CategoryController());

  List<dynamic> dataList = [];
  final ref = FirebaseDatabase.instance.ref("Reflects");

  final searchFilter = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: 25,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextFormField(
              controller: searchFilter,
              decoration: InputDecoration(
                  enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.all(Radius.circular(30.0))),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade400),
                      borderRadius: BorderRadius.all(Radius.circular(30.0))),
                  fillColor: Colors.grey.shade200,
                  filled: true,
                  hintText: 'Search',
                  hintStyle: TextStyle(
                    color: Colors.grey[500],
                    fontWeight: FontWeight.w100,
                    fontSize: 15,
                  ),
                  contentPadding: EdgeInsets.fromLTRB(20, 0, 0, 0)
              ),
              onChanged: (String value) {
                setState(() {});
              },
            ),
            SizedBox(height: 10,),
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
                  final likes = snapshot.child("likes").value as List<dynamic>?;

                  if (searchFilter.text.isEmpty) {
                    return SizedBox();
                  }
                  else if (removeDiacritics(title.toLowerCase()).contains(removeDiacritics(searchFilter.text.toLowerCase()))) {
                    print(title);
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
                                likes: likes ?? []);

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    DetailReflectPage(reflect: reflectModel),
                              ),
                            ).then((value) {
                              setState(() {});
                            });
                          },
                          child: Container(
                            height: 165,
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
                                images != null
                                    ? Flexible(
                                  flex: 2,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width / 3.2,
                                      height: MediaQuery.of(context).size.height / 6.5,
                                      decoration: BoxDecoration(
                                        color: Colors.black,
                                        image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: images[0].toString().toLowerCase().contains('.jpg') ||
                                                images[0].toString().toLowerCase().contains('.png') ||
                                                images[0].toString().toLowerCase().contains('.jpeg')
                                                ? Image.network(images[0].toString()).image
                                                : NetworkImage('https://t3.ftcdn.net/jpg/04/34/72/82/360_F_434728286_OWQQvAFoXZLdGHlObozsolNeuSxhpr84.jpg')
                                        ),
                                        borderRadius:
                                        BorderRadius.circular(8),
                                      ),
                                    ),
                                  ),
                                )
                                    : Center(
                                  child: CircularProgressIndicator(),
                                ),
                                Flexible(
                                  flex: 4,
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(12, 5, 12, 0),
                                        child: SizedBox(
                                          width: MediaQuery.of(context).size.width / 1.7,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: [
                                              // Handle
                                              if (handle == 1)
                                                Text(
                                                  'Đang xử lý',
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.red),
                                                )
                                              else if (handle == 0)
                                                Text(
                                                  'Đã xử lý',
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.blue),
                                                )
                                            ],
                                          ),
                                        ),
                                      ),

                                      // title
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(12, 8, 0, 2),
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

                                      SizedBox(height: 5),

                                      // content
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                                        child: SizedBox(
                                          width: MediaQuery.of(context).size.width / 1.7,
                                          height: 50,
                                          // height: MediaQuery.of(context).size.height / 14.0,
                                          child: Text(
                                            '${content}',
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ),

                                      SizedBox(height: 5),

                                      // datetime
                                      Padding(
                                        // padding: EdgeInsets.all(0),
                                        padding: EdgeInsetsDirectional.fromSTEB(12, 0, 12, 0),
                                        child: SizedBox(
                                          width: MediaQuery.of(context).size.width / 1.7,
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.start,
                                            children: [
                                              iconAndText(
                                                  textStyle: TextStyle(fontSize: 12),
                                                  size: 12,
                                                  title: '${formattedDateTime}',
                                                  icon: Icons.calendar_month),
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
                                                  return iconAndText(
                                                      textStyle:
                                                      TextStyle(fontSize: 12),
                                                      size: 12,
                                                      title: "${snapshot.data}",
                                                      icon: Icons.bookmark);
                                                },
                                              ),

                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  } else {
                    return SizedBox();
                  }
                },
              ),
            ),
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