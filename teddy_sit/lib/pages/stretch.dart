import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/home.dart';
import '../widgets/stretch_wid.dart';

class StretchPage extends StatefulWidget {
  const StretchPage({super.key});

  @override
  State<StretchPage> createState() => _StretchPageState();
}

class _StretchPageState extends State<StretchPage> {
  String selectedSet = 'Set 1';
  String videoUrl = 'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4';
  bool isFavorite = false;

  List<String> videoOptions = ['Set 1', 'Set 2', 'Set 3'];

  final Map<String, String> videoUrls = {
    'Set 1': 'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
    'Set 2': 'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
    'Set 3': 'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
  };

  final Map<String, String> videoTitles = {
    'Set 1': 'Exercise 1',
    'Set 2': 'Exercise 2',
    'Set 3': 'Exercise 3',
  };

  @override
  Widget build(BuildContext context) {

    IconData icon;
    if (videoOptions.contains(videoTitles[selectedSet]) &&
        videoTitles[selectedSet] != 'Set 1' &&
        videoTitles[selectedSet] != 'Set 2' &&
        videoTitles[selectedSet] != 'Set 3') 
    {
      icon = Icons.favorite;
    }

    else
    {
      icon = Icons.favorite_border;
      
    }
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 100,
        title: const Padding(
          padding: EdgeInsets.only(top: 11, left: 12),
          child: Teddysit(),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(top: 28), 
            child: InkWell(
              onTap: () {
                Navigator.popUntil(context, ModalRoute.withName('/home'));
              },
              child: const Image(image: AssetImage('assets/Home.png'), width: 35, height: 35),
            ),
          ),
          const SizedBox(width: 18),
          Padding(
            padding: const EdgeInsets.only(top: 28),
            child: InkWell(
              onTap: () {},
              child: const Image(image: AssetImage('assets/Account.png'), width: 45, height: 45),
            )
          ),
          const SizedBox(width: 18),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(width: 248),
                DropdownButtonExample(
                  options: videoOptions,
                  onChanged: (value) {
                    setState(() {
                      selectedSet = value;
                      videoUrl = videoUrls[value]!;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 28),
            Stack(
              children: [
                // 影片背景
                SizedBox(
                  width: 356,
                  height: 639,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Container(color: const Color(0xFF3A3F55)),
                  ),
                ),
                // 影片播放器
                Padding(
                  padding: const EdgeInsets.only(top: 69, left: 19),
                  child: VideoCard(videoUrl: videoUrl),
                ),
                // 心形 icon
                InkWell(
                  onTap: () {
                    setState(() {
                      // 切換愛心狀態 
                      isFavorite = !isFavorite;

                      final title = videoTitles[selectedSet];

                        // 如果變成收藏，加入 videoOptions
                        if (isFavorite) {
                          if (title != null && !videoOptions.contains(title)) {
                            videoOptions.add(title);
                            videoUrls[title] = videoUrl;
                            videoTitles[title] = title;
                            debugPrint(title);
                          }
                          
                          // ✅ 印出目前 videoUrls 的所有 key-value
                          debugPrint('=== videoUrls ===');
                          videoUrls.forEach((key, value) {
                            debugPrint('$key : $value');
                          });
                          debugPrint('================');

                          // ✅ 印出目前 videoTitles 的所有 key-value
                          debugPrint('=== videoTitless ===');
                          videoTitles.forEach((key, value) {
                            debugPrint('$key : $value');
                          });
                          debugPrint('================');
                        }
                        else
                        {
                          
                        }
                      }
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(top: 16, left: 16),
                    child: Icon(icon),
                  ),
                ),
                
                // 影片標題
                Padding(
                  padding: const EdgeInsets.only(top: 593, left: 16),
                  child: Text(
                    videoTitles[selectedSet] ?? '',
                    style: GoogleFonts.inknutAntiqua(color: Color(0xFFCDCCD3), fontSize: 20),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
