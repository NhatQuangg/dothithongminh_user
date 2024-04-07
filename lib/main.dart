import 'package:dothithongminh_user/firebase_options.dart';
import 'package:dothithongminh_user/pages/login_page/auth_page.dart';
import 'package:dothithongminh_user/test/get_reflect.dart';
import 'package:dothithongminh_user/test/showtest.dart';
import 'package:dothithongminh_user/test/tab1.dart';
import 'package:dothithongminh_user/test/testcontroller.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_player/video_player.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Đô thị thông minh',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.robotoTextTheme(Theme.of(context).textTheme),
      ),
      home: AuthPage()
    );
  }
}

// class PlayerWidget extends StatefulWidget {
//   @override
//   _PlayerWidgetState createState() => _PlayerWidgetState();
// }
// class _PlayerWidgetState extends State<PlayerWidget> {
//   late VideoPlayerController videoPlayerController;
//   late ChewieController chewieController;
//   bool isVideoInitialized = false;
//   @override
//   void initState() {
//     super.initState();
//     videoPlayerController = VideoPlayerController.networkUrl(Uri.parse("https://firebasestorage.googleapis.com/v0/b/dothithongminhkl.appspot.com/o/ListingImages%2Fjjwfqlfna%2Fdata%2Fuser%2F0%2Fn.quang.dothithongminh_user%2Fcache%2Ffile_picker%2Fpexels-moose-photos-1037992.mp4?alt=media&token=d0cf56fe-73ff-49bb-9309-af9e93fe8a60"));
//     chewieController = ChewieController(
//       videoPlayerController: videoPlayerController,
//       autoPlay: true,
//       looping: true,
//     );
//     videoPlayerController.initialize().then((_) {
//       setState(() {
//         isVideoInitialized = true;
//       });
//     });
//   }
//   @override
//   void dispose() {
//     videoPlayerController.dispose();
//     chewieController.dispose();
//     super.dispose();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return LayoutBuilder(
//       builder: (context, constraints) {
//         if (isVideoInitialized) {
//           return AspectRatio(
//             aspectRatio: videoPlayerController.value.aspectRatio,
//             child: Chewie(
//               controller: chewieController,
//             ),
//           );
//         } else {
//           return const CircularProgressIndicator();
//         }
//       },
//     );
//   }
// }
//
// class VideoPlayerScreen extends StatelessWidget {
//   const VideoPlayerScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Video"),
//       ),
//       body: ListView(
//         padding: EdgeInsets.all(20),
//         children: [
//           VideoPlayerView(
//             url: 'https://videos.pexels.com/video-files/3578881/3578881-uhd_3840_2160_30fps.mp4',
//             dataSourceType: DataSourceType.network
//           )
//         ],
//       ),
//     );
//   }
// }
//
// class VideoPlayerView extends StatefulWidget {
//   const VideoPlayerView({super.key, required this.url, required this.dataSourceType});
//   final String url;
//   final DataSourceType dataSourceType;
//
//   @override
//   State<VideoPlayerView> createState() => _VideoPlayerViewState();
// }
//
// class _VideoPlayerViewState extends State<VideoPlayerView> {
//   late VideoPlayerController _videoPlayerController;
//
//   late ChewieController _chewieController;
//
//   @override
//   void initState() {
//     super.initState();
//
//     switch (widget.dataSourceType) {
//       case DataSourceType.asset:
//         _videoPlayerController = VideoPlayerController.asset(widget.url);
//         break;
//       case DataSourceType.network:
//         _videoPlayerController = VideoPlayerController.asset(widget.url);
//         break;
//       case DataSourceType.file:
//         _videoPlayerController = VideoPlayerController.asset(widget.url);
//         break;
//       case DataSourceType.contentUri:
//         _videoPlayerController = VideoPlayerController.asset(widget.url);
//         break;
//     }
//
//     _chewieController = ChewieController(
//       videoPlayerController: _videoPlayerController,
//       aspectRatio: 16 / 9,
//     );
//   }
//
//   @override
//   void dispose() {
//     _videoPlayerController.dispose();
//     _chewieController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           widget.dataSourceType.name.toUpperCase(),
//           style: const TextStyle(
//             fontSize: 24,
//             fontWeight: FontWeight.bold
//           ),
//         ),
//         const Divider(),
//         AspectRatio(
//           aspectRatio: 16/9,
//           child: Chewie(
//             controller: _chewieController,
//           ),
//         )
//       ]
//     );
//   }
// }
