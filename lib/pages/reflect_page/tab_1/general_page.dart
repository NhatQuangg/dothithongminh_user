import 'package:dothithongminh_user/constants/constant.dart';
import 'package:dothithongminh_user/pages/reflect_page/search_reflect_page.dart';
import 'package:dothithongminh_user/pages/reflect_page/tab_1/all_reflect_page.dart';
import 'package:dothithongminh_user/pages/reflect_page/tab_1/processed_reflect_page.dart';
import 'package:dothithongminh_user/pages/reflect_page/tab_1/processing_reflect_page.dart';
import 'package:flutter/material.dart';

class GeneralPage extends StatefulWidget {
  const GeneralPage({super.key});

  @override
  State<GeneralPage> createState() => _GeneralPageState();
}

class _GeneralPageState extends State<GeneralPage> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Phản ánh hiện trường",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w600, fontSize: 19),
        ),
        centerTitle: true,
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
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SearchReflectPage(),
                ),
              );
            },
            icon: Icon(Icons.search, color: Colors.white, size: 25,)
          )
        ],
        backgroundColor: mainColor,
      ),
      body: DefaultTabController(
        length: 3,
        child: Column(
          children: [
            Material(
              child: Container(
                height: 50,
                color: Colors.white,
                child: TabBar(
                  physics: ClampingScrollPhysics(),
                  padding: EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 2),
                  unselectedLabelColor: kBorderColor,
                  labelColor: Colors.red,
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    // color: kPrimaryColor
                  ),
                  tabs: [
                    Tab(
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(color: kPrimaryColor, width: 1)
                        ),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text('Toàn bộ'),
                        ),
                      ),
                    ),
                    Tab(
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(color: kPrimaryColor, width: 1)
                        ),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text('Đã xử lý'),
                        ),
                      ),
                    ),
                    Tab(
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(color: kPrimaryColor, width: 1)
                        ),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text('Đang xử lý'),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  AllReflectPage(),
                  ProcessedReflectPage(),
                  ProcessingReflectPage()
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}



