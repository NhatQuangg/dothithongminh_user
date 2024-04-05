import 'package:cached_network_image/cached_network_image.dart';
import 'package:dothithongminh_user/pages/reflect_page/video_reflect/video_player.dart';
import 'package:flutter/material.dart';


class ListVideo extends StatefulWidget {
  List<dynamic>? images;
  ListVideo({Key? key, this.images}) : super(key: key);

  @override
  State<ListVideo> createState() => _ListVideoState();
}

class _ListVideoState extends State<ListVideo> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(" IMFG ===${widget.images![0]}");
    return widget.images!.isEmpty
        ? SizedBox()
        : Container(
      width: MediaQuery.of(context).size.width,
      height: 250,
      child: ListView.separated(
          separatorBuilder: (context, index) => SizedBox(
            width: 20,
          ),
          itemCount: widget.images!.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, indext) {
            return Container(
              width: widget.images!.length == 1
                  ? MediaQuery.of(context).size.width - 60
                  : MediaQuery.of(context).size.width * 2 / 3,
              child: VideoPlayerCustom(
                  "${widget.images![indext]}", UniqueKey()),
            );
          }),
    );
  }
}