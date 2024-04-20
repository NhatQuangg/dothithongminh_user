import 'package:dothithongminh_user/controller/reflect_controller.dart';
import 'package:dothithongminh_user/model/reflect_model.dart';
import 'package:flutter/material.dart';

class LikeButton extends StatefulWidget {
  final bool isLiked;
  final ReflectModel reflectModel;
  final int likeCount;
  LikeButton({super.key, this.isLiked = false, required this.reflectModel, required this.likeCount});

  @override
  State<LikeButton> createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButton> {
  bool isLike = false;
  int like = 0;

  @override
  void initState() {
    super.initState();
    isLike = widget.isLiked;
    like = widget.likeCount;
  }

  @override
  Widget build(BuildContext context) {
    void toggleLike() async {
      setState(() {
        isLike = !isLike;
        if (isLike) {
          like += 1;
        } else {
          like -= 1;
        }
      });

      ReflectController().likeReflectModel(widget.reflectModel, isLike);
    }

    print(widget.isLiked);
    return Column(
      children: [
        GestureDetector(
          onTap: toggleLike,
          child: Icon(
            isLike ? Icons.favorite : Icons.favorite_border,
            color: isLike ? Colors.red : Colors.grey,
            size: 35,
          ),
        ),
        Text(like.toString())
      ],
    );
  }
}