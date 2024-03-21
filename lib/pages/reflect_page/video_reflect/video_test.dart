// import 'package:flutter/material.dart';
// import 'package:video_player/video_player.dart';
//
// class FullScreen extends StatefulWidget {
//   const FullScreen({super.key});
//
//   @override
//   State<FullScreen> createState() => _FullScreenState();
// }
//
//
// class _FullScreenState extends State<FullScreen> {
//   late VideoPlayerController controller;
//
//   Future<void> loadVideoPlayer() async {
//     controller = VideoPlayerController.network("dataSource");
//
//     await controller.initialize();
//     setState(() {});
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     loadVideoPlayer();
//   }
//
//   @override
//   void disapose() {
//    super.dispose();
//    controller.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.blue,
//       appBar: AppBar(
//         title: Text("HEHE"),
//       ),
//       body: Column(
//         children: <Widget> [
//           Expanded(
//             child: Center(
//               child: videoPlayerControl,
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
