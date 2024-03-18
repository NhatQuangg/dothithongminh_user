import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class ImageSlider extends StatefulWidget {
  List<dynamic>? images;
  final int pageIndex;

  ImageSlider({
    Key? key,
    this.images,
    required this.pageIndex,
  }) : super(key: key);

  @override
  State<ImageSlider> createState() => _ImageSliderState();
}

class _ImageSliderState extends State<ImageSlider> {
  int? _currentIndex;
  PageController? _pageController;
  var list = [];

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.pageIndex;
    _pageController = PageController(initialPage: _currentIndex!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      body: Transform.translate(
        offset: Offset(0, -35),
        child: PageView.builder(
            physics: widget.images!.length == 1
                ? NeverScrollableScrollPhysics()
                : AlwaysScrollableScrollPhysics(),
            onPageChanged: (int index) {
              setState(() {
                _currentIndex = index;
              });
            },
            controller: _pageController,
            itemCount: widget.images!.length,
            itemBuilder: (context, index) {
              String file = widget.images![index].split('.').last;
              print("fileee: $file");
              return PhotoViewGallery(
                  loadingBuilder: (context, event) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                  pageOptions: <PhotoViewGalleryPageOptions>[
                    PhotoViewGalleryPageOptions(
                      onTapUp: (context, details, controllerValue) =>
                          Navigator.pop(context),
                      minScale: PhotoViewComputedScale.contained * 0.8,
                      maxScale: PhotoViewComputedScale.covered * 1.8,
                      imageProvider: NetworkImage(widget.images![index]),
                    ),
                  ]);
            }),
      ),
    );
  }
}
