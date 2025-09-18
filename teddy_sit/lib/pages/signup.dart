import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/home.dart';

class SignUpPage extends StatelessWidget{
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 100,
        title: Padding(
          padding: const EdgeInsets.only(top: 11, left: 12),
          child: const Teddysit(),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(top: 28), 
            child: InkWell(
              onTap: () {
                Navigator.pop(context);
                // Navigate to settings page
              },
              child: Image(image: AssetImage('assets/Home.png'), width: 35, height: 35),
            ),
          ),
          const SizedBox(width: 18),
          Padding(
            padding: const EdgeInsets.only(top: 28),
            child: InkWell(
              onTap: () {
                
              },
              child: Image(image: AssetImage('assets/Account.png'), width: 45, height: 45),
            )
          ),
          const SizedBox(width: 18),
        ],
      ),
      body: Center(
        child: SizedBox(
          height: 810,
          width: 412,
          child: Column(
            children: [
              

              SizedBox(height: 41),
              Stack(
                children: [
                  Opacity(
                    opacity: 0.65,
                    child: Container(
                      width: 412,
                      height: 749,
                      decoration: ShapeDecoration(
                        gradient: LinearGradient(
                          begin: Alignment(0.00, -1.00),
                          end: Alignment(0, 1),
                          colors: [Color(0xFFE7EAFF), Color(0xFF9785FF)],
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(25),
                            topRight: Radius.circular(25),
                            bottomLeft: Radius.circular(0),
                            bottomRight: Radius.circular(0),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 45,
                    left: 47,
                    child: SizedBox(
                      height: 75,
                      width: 323,
                      child: Text(
                        'Get Started',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.inknutAntiqua(
                          fontSize: 32,
                          height: 50/32,
                          color: Color(0xFF070C24)
                        ),
                      ),
                    ),
                  ),
                  
                  Positioned(
                    top: 80,
                    left: 30,
                    child: Column(
                      children: [
                        SizedBox(height: 35),
                        SizedBox(
                          width: 320,   
                          height: 53,  
                          child: TextField(
                            style: GoogleFonts.inknutAntiqua(
                              fontSize: 14,        
                              color: Color(0xFF070C24), 
                            ),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 12),
                              hintText: 'Enter Full Name',
                              hintStyle: GoogleFonts.inknutAntiqua(
                                fontSize: 14,          
                                color: Color.fromARGB(125, 245, 245, 245),   
                              ),
                              labelText: 'Full Name',
                              labelStyle: GoogleFonts.inknutAntiqua(
                                fontSize: 14,          
                                color: Color.fromARGB(124, 0, 0, 0), 
                              ),
                              floatingLabelBehavior: FloatingLabelBehavior.always,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(18),
                                borderSide: BorderSide(color: Color.fromARGB(126, 245, 245, 245), width: 3),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(color: Color.fromARGB(126, 245, 245, 245), width: 3),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(color: const Color.fromARGB(173, 79, 74, 119), width: 3),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 35),
                        SizedBox(
                          width: 320,   
                          height: 53,  
                          child: TextField(
                            style: GoogleFonts.inknutAntiqua(
                              fontSize: 14,        
                              color: Color(0xFF070C24), 
                            ),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 12),
                              hintText: 'Enter Email',
                              hintStyle: GoogleFonts.inknutAntiqua(
                                fontSize: 14,          
                                color: Color.fromARGB(125, 245, 245, 245),   
                              ),
                              labelText: 'Email',
                              labelStyle: GoogleFonts.inknutAntiqua(
                                fontSize: 14,          
                                color: Color.fromARGB(124, 0, 0, 0), 
                              ),
                              floatingLabelBehavior: FloatingLabelBehavior.always,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(18),
                                borderSide: BorderSide(color: Color.fromARGB(126, 245, 245, 245), width: 3),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(color: Color.fromARGB(126, 245, 245, 245), width: 3),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(color: const Color.fromARGB(173, 79, 74, 119), width: 3),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 35),
                        SizedBox(
                          width: 320,   
                          height: 53,  
                          child: TextField(
                            style: GoogleFonts.inknutAntiqua(
                              fontSize: 14,        
                              color: Color(0xFF070C24), 
                            ),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 12),
                              hintText: 'Enter Password',
                              hintStyle: GoogleFonts.inknutAntiqua(
                                fontSize: 14,          
                                color: Color.fromARGB(125, 245, 245, 245),   
                              ),
                              labelText: 'Password',
                              labelStyle: GoogleFonts.inknutAntiqua(
                                fontSize: 14,          
                                color: Color.fromARGB(124, 0, 0, 0), 
                              ),
                              floatingLabelBehavior: FloatingLabelBehavior.always,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(18),
                                borderSide: BorderSide(color: Color.fromARGB(126, 245, 245, 245), width: 3),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(color: Color.fromARGB(126, 245, 245, 245), width: 3),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(color: const Color.fromARGB(173, 79, 74, 119), width: 3),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 35),
                        SizedBox(
                          width: 320,   
                          height: 53,  
                          child: TextField(
                            style: GoogleFonts.inknutAntiqua(
                              fontSize: 14,        
                              color: Color(0xFF070C24), 
                            ),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 12),
                              hintText: 'Enter Password Again',
                              hintStyle: GoogleFonts.inknutAntiqua(
                                fontSize: 14,          
                                color: Color.fromARGB(125, 245, 245, 245),   
                              ),
                              labelText: 'Confirm Password',
                              labelStyle: GoogleFonts.inknutAntiqua(
                                fontSize: 14,          
                                color: Color.fromARGB(124, 0, 0, 0), 
                              ),
                              floatingLabelBehavior: FloatingLabelBehavior.always,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(18),
                                borderSide: BorderSide(color: Color.fromARGB(126, 245, 245, 245), width: 3),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(color: Color.fromARGB(126, 245, 245, 245), width: 3),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(color: const Color.fromARGB(173, 79, 74, 119), width: 3),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 30),
                        InkWell(
                          onTap: () {
                            debugPrint('Sign up!');
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(left: 35),
                            child: Column(
                              children: [
                                SizedBox(
                                  width: 319,
                                  height: 53,
                                  child: Stack(
                                    children: [
                                      Positioned(
                                        left: 0,
                                        top: 0,
                                        child: Container(
                                          width: 319,
                                          height: 53,
                                          decoration: ShapeDecoration(
                                            color: Color(0xFF070C24),
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(18),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        left: 65,
                                        top: 14,
                                        child: SizedBox(
                                          width: 174,
                                          height: 41,
                                          child: Text(
                                            'Sign Up',
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.inknutAntiqua(
                                              color: Colors.white,
                                              fontSize: 20,
                                              height: 1,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            )
                          ),
                        )
                        
                        

                      ],
                    )
                  )
                ],
              ),
              
              
              
              
            ],
          ),
        )
      ),
      
      
    );
  }
}