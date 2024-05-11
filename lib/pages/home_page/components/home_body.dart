import 'package:carousel_slider/carousel_slider.dart';
import 'package:dothithongminh_user/constants/global.dart';
import 'package:dothithongminh_user/controller/profile_controller.dart';
import 'package:dothithongminh_user/model/user_model.dart';
import 'package:dothithongminh_user/pages/home_page/components/home_controller.dart';
import 'package:dothithongminh_user/pages/reflect_page/reflect_page.dart';
import 'package:dothithongminh_user/test/get_reflect.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({
    super.key,
    required this.controllerCarouselSlider,
  });

  final HomeController controllerCarouselSlider;

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  final controller = Get.put(ProfileController());
  final currentUser = FirebaseAuth.instance.currentUser!;
  final rd = FirebaseDatabase.instance;

  Future<void> _getUserId() async {
    late String? userId;
    String? id = await getId_Users();
    setState(() {
      userId = id;
    });
  }

  void initState() {
    super.initState();
    _getUserId();
  }

  final ref = FirebaseDatabase.instance.ref("Users");


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CarouselSlider(
          items: [
            // header image
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('images/bia1.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('images/bia2.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
          options: CarouselOptions(
              height: 200,
              enlargeCenterPage: false,
              autoPlay: true,
              aspectRatio: 16 / 9,
              autoPlayCurve: Curves.fastOutSlowIn,
              enableInfiniteScroll: true,
              //autoPlayAnimationDuration: Duration(milliseconds: 800),
              viewportFraction: 1,
              onPageChanged: (index, _) =>
                  widget.controllerCarouselSlider.updatePageIndicator(index)),
        ),
        SizedBox(height: 5),
        Obx(
          () => Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (int i = 0; i < 2; i++)
                Container(
                  width: 15,
                  height: 3,
                  margin: EdgeInsets.only(right: 5),
                  decoration: BoxDecoration(
                      color: widget.controllerCarouselSlider
                                  .carousalCurrentIndex.value ==
                              i
                          ? Colors.blue
                          : Colors.grey,
                      borderRadius: BorderRadius.circular(50)),
                )
            ],
          ),
        ),
        SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              margin: EdgeInsets.only(left: 10.0),
              child: Text(
                'Dịch vụ đô thị',
                style: GoogleFonts.notoSans(
                  textStyle: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ),
            ),
            FutureBuilder(
              future: controller.getUserDataRD(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    UserModel user = snapshot.data as UserModel;

                    if (user.fullname!.isEmpty) {
                      return Container(
                        margin: EdgeInsets.only(right: 10.0),
                        child: Text(
                          'Xin chào',
                          style: GoogleFonts.notoSans(
                            textStyle: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                      );
                    } else {
                      return Container(
                        margin: EdgeInsets.only(right: 10.0),
                        child: Text(
                          '${user.fullname}',
                          style: GoogleFonts.notoSans(
                            textStyle: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                      );
                    }

                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('Error ${snapshot.error}'),
                    );
                  }
                }
                return SizedBox();
              },
            ),
          ],
        ),


        const SizedBox(height: 30),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ReflectPage(),
                    ));
              },
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(60),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.grey[200],
                    ),
                    child: Icon(
                      FontAwesomeIcons.warning,
                      size: 80,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Phản ánh',
                    style: TextStyle(fontSize: 25),
                  )
                ],
              ),
            ),
            SizedBox(width: 10),
          ],
        ),
      ],
    );
  }
}
