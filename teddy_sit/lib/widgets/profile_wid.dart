import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Signupwid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 319,
          height: 53,
          decoration: ShapeDecoration(
            color: Color(0xFF7780BA),
            shape: RoundedRectangleBorder(
              side: BorderSide(width: 1),
              borderRadius: BorderRadius.circular(18),
            ),
          ),
          child: Center(
            child: Text(
              'Sign Up',
              style: GoogleFonts.inknutAntiqua(
                color: Colors.white,
                fontSize: 20,
                height: 1.0,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class Loginwid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 319,
          height: 53,
          decoration: ShapeDecoration(
            color: Color(0xFFE9E6EE),
            shape: RoundedRectangleBorder(
              side: BorderSide(width: 1),
              borderRadius: BorderRadius.circular(18),
            ),
          ),
          child: Center(
            child: Text(
              'Log In',
              style: GoogleFonts.inknutAntiqua(
                color: Color(0xFF070C24),
                fontSize: 20,
                height: 1.0,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class Titlewid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 298,
          height: 132,
          child: Stack(
            children: [
              Positioned(
                left: 4,
                top: 80,
                child: SizedBox(
                  width: 294,
                  child: Text(
                    'Help You Maintain a Correct\n Sitting Posture',
                    style: GoogleFonts.inknutAntiqua(
                    color: Colors.white,
                    fontSize: 16,
                    height: 1.2,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 0,
                top: 0,
                child: SizedBox(
                  width: 245,
                  height: 75,
                  child: Text(
                    'Welcome to\nTeddy Sit',
                    style: GoogleFonts.inknutAntiqua(
                    color: Colors.white,
                    fontSize: 36,
                    height: 1.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}