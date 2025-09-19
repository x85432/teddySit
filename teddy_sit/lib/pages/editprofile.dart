import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/home.dart';

class EditProfilePage extends StatelessWidget{
  const EditProfilePage({super.key});

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
                Navigator.popUntil(context, (route) => route.isFirst);
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
              SizedBox(height: 5),
              SizedBox(
                height: 75,
                width: 323,
                child: Text(
                  'Edit Profile',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inknutAntiqua(
                    fontSize: 28,
                    height: 50/28,
                    color: Color(0xFFE9E6EE)
                  ),
                ),
              ),
              Image(
                image: AssetImage('assets/Account.png'),
                width: 100,
              ),
              SizedBox(height: 10),
              Stack(
                children: [
                  Opacity(
                    opacity: 0.65,
                    child: Container(
                      width: 412,
                      height: 600,
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
                    left: 45,
                    child: Column(
                      
                      children: [
                        SizedBox(height: 50),
                        SizedBox(
                          width: 320,   
                          height: 53,  
                          child: TextField(
                            //controller: _fullNameController,
                            style: GoogleFonts.inknutAntiqua(
                              fontSize: 14,        
                              color: Color(0xFF070C24), 
                            ),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 12),
                              hintText: 'Bibo',
                              hintStyle: GoogleFonts.inknutAntiqua(
                                fontSize: 14,          
                                color: Color.fromARGB(125, 245, 245, 245),   
                              ),
                              labelText: 'Your Name',
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
                        
                        SizedBox(height: 40),
                        SizedBox(
                          width: 320,   
                          height: 53,  
                          child: TextField(
                            //controller: _passwordController,
                            //obscureText: true,
                            style: GoogleFonts.inknutAntiqua(
                              fontSize: 14,
                              color: Color(0xFF070C24),
                            ),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 12),
                              hintText: '2005/02/12',
                              hintStyle: GoogleFonts.inknutAntiqua(
                                fontSize: 14,          
                                color: Color.fromARGB(125, 245, 245, 245),   
                              ),
                              labelText: 'Date of Birth',
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
                        SizedBox(height: 40),
                        SizedBox(
                          width: 320,   
                          height: 53,  
                          child: TextField(
                            //controller: _passwordConfirmationController,
                            //obscureText: true,
                            style: GoogleFonts.inknutAntiqua(
                              fontSize: 14,        
                              color: Color(0xFF070C24), 
                            ),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 12),
                              hintText: '150',
                              hintStyle: GoogleFonts.inknutAntiqua(
                                fontSize: 14,          
                                color: Color.fromARGB(125, 245, 245, 245),   
                              ),
                              labelText: 'Height',
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
                        SizedBox(height: 40),
                        SizedBox(
                          width: 320,   
                          height: 53,  
                          child: TextField(
                            //controller: _passwordConfirmationController,
                            //obscureText: true,
                            style: GoogleFonts.inknutAntiqua(
                              fontSize: 14,        
                              color: Color(0xFF070C24), 
                            ),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 12),
                              hintText: '60',
                              hintStyle: GoogleFonts.inknutAntiqua(
                                fontSize: 14,          
                                color: Color.fromARGB(125, 245, 245, 245),   
                              ),
                              labelText: 'Weight',
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
                        SizedBox(height: 60),
                        InkWell(
                          onTap: () {
                            debugPrint('Save Profile!');
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(left: 0),
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
                                            'Save',
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