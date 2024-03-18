import 'package:dothithongminh_user/constants/constant.dart';
import 'package:dothithongminh_user/constants/icon_text.dart';
import 'package:dothithongminh_user/model/reflect_model.dart';
import 'package:dothithongminh_user/test/get_reflect_2.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class GetReflects extends StatefulWidget {
  const GetReflects({super.key});

  @override
  State<GetReflects> createState() => _GetReflectsState();
}

  final ref = FirebaseDatabase.instance.ref("Reflects");

class _GetReflectsState extends State<GetReflects> {
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
          'GET',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: mainColor,
        centerTitle: true,
      ),
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
                  final category = snapshot.child("category").value.toString();
                  final handle = snapshot.child("handle").value as int;
                  final accept = snapshot.child("accept").value as bool;
                  final address = snapshot.child("address").value.toString();
                  final email = snapshot.child("email").value.toString();
                  final contentfeedback = snapshot.child("contentfeedback").value.toString();
                  final timestamp = snapshot.child("createdAt").value as int;
                  final dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
                  // print(dateTime);
                  final formattedDateTime = "${dateTime.day}/${dateTime.month}/${dateTime.year}";
                  final List<dynamic>? images = snapshot.child("media").value as List<dynamic>?;

                  return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Slidable(
                        child: InkWell(
                          onTap: () {
                            ReflectModel reflectModel = ReflectModel(
                              id: key,
                              email: email,
                              title: title,
                              category: category,
                              content: content,
                              content_response: contentfeedback,
                              address: address,
                              media: images,
                              accept: accept,
                              handle: handle,
                              createdAt: dateTime,
                            );

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                // builder: (context) => GetReflects2(id: key.toString()),
                                builder: (context) => GetReflects2(reflect: reflectModel),

                              ),
                            ).then((value) {
                              setState(() {});
                            });
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
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                images != null
                                    ? Padding(
                                  padding: const EdgeInsets.only(left: 7),
                                  child: Container(
                                    width: 110,
                                    height: 106,
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

                                    Padding(
                                      //padding: EdgeInsets.all(0),
                                      padding: EdgeInsetsDirectional.fromSTEB(12, 0, 12, 0),
                                      child: SizedBox(
                                        width: MediaQuery.of(context).size.width / 1.7,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            iconAndText(
                                                textStyle: TextStyle(fontSize: 12),
                                                size: 12,
                                                title: '${category}',
                                                icon: Icons.bookmark
                                            ),
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
