import 'package:cached_network_image/cached_network_image.dart';
import 'package:dothithongminh_user/constants/utils.dart';
import 'package:dothithongminh_user/pages/reflect_page/image_reflect/image_slide.dart';
import 'package:dothithongminh_user/pages/reflect_page/video_reflect/video_player.dart';
import 'package:flutter/material.dart';

class ZoomImage extends StatefulWidget {
  List<dynamic>? images;
  ZoomImage({Key? key, this.images}) : super(key: key);

  @override
  State<ZoomImage> createState() => _ZoomImageState();
}

class _ZoomImageState extends State<ZoomImage> {
  var list = [];

  String getFileName(String url) {
    RegExp regExp = new RegExp(r'.+(\/|%2F)(.+)\?.+');
    var matches = regExp.allMatches(url);

    var match = matches.elementAt(0);
    print(" LINKIMG == ${Uri.decodeFull(match.group(2)!)}");
    return Uri.decodeFull(match.group(2)!);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(" IMFG === ${widget.images![0]}");
    return widget.images!.isEmpty
        ? SizedBox()
        : Container(
            width: MediaQuery.of(context).size.width,
            height: 250,
            child: ListView.separated(
                separatorBuilder: (context, index) => SizedBox(width: 20,),
                itemCount: widget.images!.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {

                  String file = getFileName(widget.images![index]);
                  print("Image: $file");
                  String filesplit = file.split('.').last;
                  print("filesplit: $filesplit");

                  if (isImageFromPath(filesplit)) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context, rootNavigator: true).push(
                            MaterialPageRoute(
                                builder: (_) => ImageSlider(
                                      images: widget.images!,
                                      pageIndex: index,
                                    )
                        )
                        );
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: CachedNetworkImage(
                          width: widget.images!.length == 1
                              ? MediaQuery.of(context).size.width - 20
                              : MediaQuery.of(context).size.width * 2 / 3,
                          fit: BoxFit.cover,
                          imageUrl: '${widget.images![index]}',
                        ),
                      ),
                    );
                  } else {
                    print("VIDEO == ${widget.images![index]}");
                    return Container(
                      width: widget.images!.length == 1
                          ? MediaQuery.of(context).size.width - 60
                          : MediaQuery.of(context).size.width * 2 / 3,
                      child: VideoPlayerCustom("${widget.images![index]}", UniqueKey()),
                    );
                  }
                }),
          );
  }
}
