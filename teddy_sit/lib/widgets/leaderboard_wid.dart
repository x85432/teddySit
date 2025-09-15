import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class Rank3 extends StatelessWidget {
  final int rank;
  final String playerName;
  final int score;
  final int type;
  final String? imagePath;

  const Rank3({
    super.key,
    required this.rank,
    required this.playerName,
    required this.score,
    required this.type,
    this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Opacity(
          opacity: 0.24,
          child: Container(
            width: type == 1 ? 124 : 123,
            height: type == 1 ? 272 : 213,
            decoration: ShapeDecoration(
              gradient: LinearGradient(
                begin: Alignment(0.00, -1.00),
                end: Alignment(0, 1),
                colors: type == 1
                    ? [Color(0xFFE7EAFF), Color(0xFF314AEF)]
                    : [Color(0xFFE7EAFF), Color(0xFF9785FF)],
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
            ),
          ),
        ),
       
        Column(
          mainAxisSize: MainAxisSize.min, 
          crossAxisAlignment: CrossAxisAlignment.center, 
          children: [
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  rank.toString(),
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inika(
                    fontSize: 64,
                    color: Colors.white,
                    height: 0.8,
                  ),
                ),
                Text(
                  rank == 1
                      ? 'st'
                      : rank == 2
                          ? 'nd'
                          : rank == 3
                              ? 'rd'
                              : 'th',
                  style: GoogleFonts.inika(
                    fontSize: 24,
                    color: Colors.white,
                  ),
                )
              ],
            ),
            
            SizedBox(height: rank == 3 ? 20 : 10),
            SizedBox(height: type == 1 ? 15 : 0),
            Text(
              score.toString(),
              textAlign: TextAlign.center,
              style: GoogleFonts.inknutAntiqua(
                fontSize: 14,
                color: Color(0xFFCDCCD3),
              ),
            ),
            SizedBox(height: type == 1 ? 25 : 8),
            SizedBox(height: rank == 3 ? 0 : 7),
            Image(
              image: imagePath != null
                  ? AssetImage(imagePath!)
                  : const AssetImage('assets/Account.png'),
              width: 57,
              height: 57,
            ),
            SizedBox(height: type == 1 ? 30 : 2),
            Text(
              playerName,
              textAlign: TextAlign.center,
              style: GoogleFonts.inknutAntiqua(
                fontSize: 14,
                color: Color(0xFFCDCCD3),
              ),
            ),
          ],
        )


      ],
    );
    
  }
}

class Rank extends StatelessWidget {
  final int rank;
  final String playerName;
  final int score;
  final String? imagePath;

  const Rank({
    super.key,
    required this.rank,
    required this.playerName,
    required this.score,
    this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 75.2, 
      width: 370,
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      padding: const EdgeInsets.fromLTRB(12, 0, 25, 0),  
      

      decoration: BoxDecoration(
        color: const Color.fromARGB(0, 28, 35, 64),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center, 
        children: [
          Column(
            children:[
              const SizedBox(height: 11),
              Text(
                '$rank',
                style: GoogleFonts.inika(
                  color: Colors.white,
                  fontSize: 36,
                ),
              ),
            ] 
          ),
          const SizedBox(width: 15),

          CircleAvatar(
            radius: 24,
            backgroundColor: const Color.fromARGB(0, 59, 74, 102),
            backgroundImage:
                imagePath != null ? AssetImage(imagePath!) : AssetImage('assets/Account.png'),
            
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                playerName,
                style: GoogleFonts.inika(
                  textStyle: const TextStyle(
                    fontSize: 18,
                    color: Color(0xFFE9E6EE),
                  ),
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),

          Align(
            alignment: Alignment.centerRight,
            child: Text(
              '$score pts',
              style: GoogleFonts.inika(
                textStyle: const TextStyle(
                  fontSize: 16,
                  color: Color(0xFFE9E6EE),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
