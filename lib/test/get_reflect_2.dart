  import 'package:dothithongminh_user/constants/constant.dart';
  import 'package:dothithongminh_user/constants/global.dart';
  import 'package:dothithongminh_user/constants/icon_text.dart';
  import 'package:dothithongminh_user/constants/utils.dart';
  import 'package:dothithongminh_user/controller/category_controller.dart';
  import 'package:dothithongminh_user/controller/profile_controller.dart';
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
    // final ref = FirebaseDatabase.instance.ref("Reflects");
    String a = getEmail();
    final controller = Get.put(CategoryController());
    final reff = FirebaseDatabase.instance.ref().child("Category");
    List<String> listCategory = ['Giáo dục', 'An ninh', 'Cơ sở vật chất'];
    String? selectNameCategory;
    String? selectedCategory;
    List<String> categories = [];

    List<String> categoryKeys = [];
    String? selectedCategoryKey;

    // @override
    // void initState() {
    //   super.initState();
    //   reff.onValue.listen((event) {
    //     final snapshot = event.snapshot;
    //     final values = snapshot.value;
    //     final id = snapshot.key;
    //     if (values != null) {
    //       setState(() {
    //         categories = (values as Map<dynamic, dynamic>).values.map((e) => e['category_name'] as String).toList();
    //         if (categories.isNotEmpty) {
    //           selectedCategory = categories.first;
    //         }
    //       });
    //     }
    //   });
    // }

    @override
    void initState() {
      super.initState();
      reff.onValue.listen((event) {
        final snapshot = event.snapshot;
        final values = snapshot.value;
        if (values != null) {
          setState(() {
            categories = (values as Map<dynamic, dynamic>).values.map((e) => e['category_name'] as String).toList();
            categoryKeys = (values as Map<dynamic, dynamic>).keys.cast<String>().toList();
            if (categories.isNotEmpty) {
              selectedCategoryKey = categoryKeys.first;
            }
          });
        }
      });
    }

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
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              Container(
                margin: EdgeInsets.zero,
                padding: EdgeInsets.fromLTRB(25, 0, 10, 0),
                height: 55,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(width: 1, color: Colors.grey),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    isExpanded: true,
                    value: selectedCategoryKey,
                    onChanged: (String? value) {
                      setState(() {
                        selectedCategoryKey = value;
                        print(selectedCategoryKey);
                      });
                    },
                    items: categories.asMap().entries.map((entry) {
                      return DropdownMenuItem<String>(
                        value: categoryKeys[entry.key],
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(entry.value),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ],
          ),
        ),

        // body: Container(
        //   margin: EdgeInsets.symmetric(horizontal: 16),
        //   child: Column(
        //     mainAxisAlignment: MainAxisAlignment.start,
        //     crossAxisAlignment: CrossAxisAlignment.start,
        //     children: [
        //       SizedBox(height: 20,),
        //       Container(
        //         margin: EdgeInsets.zero,
        //         padding: EdgeInsets.fromLTRB(25, 0, 10, 0),
        //         height: 55,
        //         decoration: BoxDecoration(
        //             borderRadius: BorderRadius.circular(5),
        //             border: Border.all(width: 1, color: Colors.grey)
        //         ),
        //         child: DropdownButtonHideUnderline(
        //           child: Padding(
        //             padding: EdgeInsets.zero,
        //             child: DropdownButton(
        //               isExpanded: true,
        //               hint: Transform.translate(
        //                 offset: Offset(-10, 0),
        //                 child: Text(
        //                   selectNameCategory ?? listCategory[0],
        //                   style: const TextStyle(
        //                       fontSize: 14,
        //                       color: Colors.black),
        //                 ),
        //               ),
        //               items: listCategory.map((item) =>
        //                   DropdownMenuItem<String>(
        //                     value: item,
        //                     child: Transform.translate(
        //                       offset: const Offset(-10, 0),
        //                       child: Text(
        //                         item,
        //                         style: const TextStyle(
        //                           fontSize: 14,
        //                         ),
        //                       ),
        //                     ),
        //                   ))
        //                   .toList(),
        //               value: selectNameCategory,
        //               onChanged: (value) {
        //                 setState(() {
        //                   selectNameCategory = value as String?;
        //                   if (value == listCategory[0]) {
        //                     selectNameCategory =
        //                     listCategory[0];
        //                   }
        //                   if (value == listCategory[1]) {
        //                     selectNameCategory =
        //                     listCategory[1];
        //                   }
        //                   if (value == listCategory[2]) {
        //                     selectNameCategory =
        //                     listCategory[2];
        //                   }
        //                 });
        //               },
        //             ),
        //           ),
        //         ),
        //       ),
        //     ],
        //   ),
        // )

        // body: FirebaseAnimatedList(
        //   query: reff,
        //   itemBuilder: (context, snapshot, animation, index) {
        //     Map category = snapshot.value as Map;
        //     category['key'] = snapshot.key;

        //     // return Container(
        //     //   margin: EdgeInsets.all(10),
        //     //   padding: EdgeInsets.all(10),
        //     //   height: 110,
        //     //   color: Colors.blue,
        //     //   child: Column(
        //     //     mainAxisAlignment: MainAxisAlignment.center,
        //     //     crossAxisAlignment: CrossAxisAlignment.center,
        //     //     children: [
        //     //       Text('Index: $index'),
        //     //       Text(category['key']),
        //     //       Text(category['category_name'])
        //     //     ],
        //     //   ),
        //     // );
        //   },
        // )

      );

    }
  }
