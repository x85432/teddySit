import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Rank extends StatefulWidget {
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
  State<Rank> createState() => _RankState();
}

class _RankState extends State<Rank> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFF1C2340),
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: const Color(0xFF3B4A66),
          backgroundImage: widget.imagePath != null ? AssetImage(widget.imagePath!) : null,
          child: widget.imagePath == null
              ? Text(
                  widget.rank.toString(),
                  style: const TextStyle(color: Colors.white),
                )
              : null,
        ),
        title: Text(
          widget.playerName,
          style: GoogleFonts.inika(
            textStyle: const TextStyle(
              fontSize: 18,
              color: Color(0xFFE9E6EE),
            ),
          ),
        ),
        trailing: Text(
          '${widget.score} pts',
          style: GoogleFonts.inika(
            textStyle: const TextStyle(
              fontSize: 16,
              color: Color(0xFFE9E6EE),
            ),
          ),
        ),
      ),
    );
  }
}
