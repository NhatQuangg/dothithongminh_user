import 'package:dothithongminh_user/model/reflect_model.dart';
import 'package:dothithongminh_user/repository/reflects/reflect_repository.dart';
import 'package:flutter/material.dart';

class tab2 extends StatefulWidget {
  const tab2({Key? key}) : super(key: key);

  @override
  State<tab2> createState() => _tab2State();
}

class _tab2State extends State<tab2> {
  // Khai báo danh sách các ReflectModel để lưu trữ dữ liệu
  List<ReflectModel> reflects = [];

  @override
  void initState() {
    super.initState();
    // Gọi hàm để lấy dữ liệu từ Realtime Database và cập nhật vào danh sách reflects
    getReflectData();
  }

  // Hàm để lấy dữ liệu từ Realtime Database và cập nhật vào danh sách reflects
  void getReflectData() async {
    // Gọi hàm từ ReflectRepository để lấy danh sách ReflectModel từ Realtime Database
    final List<ReflectModel> reflectData = await ReflectRepository.instance.getAllReflectRDD();
    // Cập nhật danh sách reflects với dữ liệu mới
    setState(() {
      reflects = reflectData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("haha"),
      ),
      body: ListView.builder(
        itemCount: reflects.length,
        itemBuilder: (context, index) {
          // Lấy ra một đối tượng ReflectModel từ danh sách reflects tại vị trí index
          final ReflectModel reflect = reflects[index];
          print("haha ${reflect.title} ");
          // Trả về một widget hiển thị thông tin của ReflectModel này
          return ListTile(
            title: Text(reflect.title ?? ''), // Hiển thị tiêu đề
            subtitle: Text(reflect.content ?? ''), // Hiển thị nội dung
            // Bạn có thể hiển thị các thông tin khác tùy ý tại đây
          );
        },
      ),
    );
  }
}
