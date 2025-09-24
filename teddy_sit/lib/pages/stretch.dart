import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/home.dart';
import '../widgets/stretch_wid.dart';

double scale = 2340/2400;

class StretchPage extends StatefulWidget {
  final String selectedSet;
  const StretchPage({super.key, required this.selectedSet});

  @override
  State<StretchPage> createState() => _StretchPageState();
}

class _StretchPageState extends State<StretchPage> {
  late String selectedSet = widget.selectedSet;
  
  List<String> videoOptions = ['1', '2', '3'];

  final Map<String, String> videoUrls = {
    '1': 'assets/e1.gif',
    '2': 'assets/e2.gif',
    '3': 'assets/e3.gif',
  };

  final Map<String, String> videoTitles = {
    '1': 'Upper trap stretch',
    '2': 'Shoulder, or pectoralis stretch',
    '3': 'Upper body and arm stretch',
  };

  final Map<String, String> videoTips = {
    '2': '1. Clasp hands behind your back.\n2. Push the chest outward, and raise the chin.\n3. Hold the pose for 10 to 30 seconds.',
    '3': '1. Clasp hands together above the head with palms facing outward.\n2. Push your arms up, stretching upward.\n3. Hold the pose for 10 to 30 seconds.',
    '1': '1. Gently pull your head toward each shoulder until a light stretch is felt.\n2. Hold the pose for 10 to 15 seconds.\n3. Alternate once on each side.',
  };

  final Map<String, String> videoNotes = {
    '1': 'Note: We noticed your head tends to lean forward while sitting. A gentle neck stretch helps release tightness in your shoulders and neck, easing pressure and making you feel lighter.',
    '2': 'Note: Your body leans forward more than it should during sitting. This chest-opening stretch relaxes tight shoulder and chest muscles, helping you sit taller, breathe easier, and stay more comfortable.',
    '3': 'Note: Great job keeping a healthy posture! To keep your muscles loose, we suggest a quick arm stretch overhead. It refreshes your body, improves circulation, and prevents stiffness from sitting long.'
  };

  @override
  void initState() {
    super.initState();
    selectedSet = widget.selectedSet;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 100*scale,
        title: Padding(
          padding: EdgeInsets.only(top: 11*scale, left: 12*scale),
          child: Teddysit(),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(top: 28*scale), 
            child: InkWell(
              onTap: () {
                Navigator.popUntil(context, ModalRoute.withName('/home'));
              },
              child: Image(image: AssetImage('assets/Home.png'), width: 35*scale, height: 35*scale),
            ),
          ),
          SizedBox(width: 18*scale),
          Padding(
            padding: EdgeInsets.only(top: 28*scale),
            child: InkWell(
              onTap: () {},
              child: Image(image: AssetImage('assets/Account.png'), width: 45*scale, height: 45*scale),
            )
          ),
          SizedBox(width: 18*scale),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 20),
        child: Column(
          
          children: [
            SizedBox(height: 28*scale),
            
            Stack(
              children: [
                // 影片背景
                SizedBox(
                  width: 355,
                  height: 740*scale*0.9,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Container(color: const Color(0xFF3A3F55)),
                  ),
                ),
                // 影片播放器
                Padding(
                  padding: EdgeInsets.only(top: 45*scale*0.9, left: 18*scale*0.9),
                  child: GifCard(gifPath: videoUrls[selectedSet]??'2'),
                ),
        
                // 影片標題
                Padding(
                  
                  padding: EdgeInsets.only(top: 430*scale*0.9, left: 25*scale*0.9),
                  child: Row(

                    children: [
                      Icon(Icons.accessibility_new, color: const Color.fromARGB(255, 142, 128, 192),size: 32,),
                      Text(
                    videoTitles[selectedSet] ?? '',
                    style: GoogleFonts.inknutAntiqua(color: Color(0xFFCDCCD3), fontSize: 17*scale),
                    ),
                    ],
                  ),
                ),
                //步驟
                Padding(
                  padding: EdgeInsets.only(top: 468*scale*0.9, left: 25*scale*0.9),
                  child: Column(
                  children: [
                      SizedBox(
                          width: 320,
                          child: Text(
                          videoTips[selectedSet] ?? '',
                          style: GoogleFonts.inknutAntiqua(color: Color(0xFFCDCCD3), fontSize: 14*scale, height: 27/14),
                        )),
                        SizedBox(height: 10,),
                       SizedBox(
                          width: 320,
                          child: Text(
                          videoNotes[selectedSet] ?? '',
                          style: GoogleFonts.inknutAntiqua(color: Color(0xFFE8DEF8), fontSize: 12*scale, height: 23/14),
                        )),

                      
                  ],
                ),
                )
                
                
                
              ],
            ),
          ],
        ),
      ),
    );
  }
}
