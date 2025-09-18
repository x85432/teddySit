import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/home.dart';
import 'editprofile.dart';

class ProfilePage extends StatelessWidget{
  const ProfilePage({super.key});

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
              SizedBox(height: 20),
              SizedBox(
                height: 75,
                width: 323,
                child: Text(
                  'My Profile',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inknutAntiqua(
                    fontSize: 32,
                    height: 50/32,
                    color: Color(0xFFE9E6EE)
                  ),
                ),
              ),
              Image(
                image: AssetImage('assets/Account.png'),
                width: 100,
              ),
              SizedBox(height: 20),
              Stack(
                children: [
                  Opacity(
                    opacity: 0.65,
                    child: Container(
                      width: 412,
                      height: 575,
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
                    child: Column(
                      children: [
                        SizedBox(height: 35),
                        SizedBox(
                          height: 82,
                          width: 228,
                          child: Column(
                            children: [
                              SizedBox(
                                height: 41,
                                width: 228,
                                child: Text(
                                  textAlign:TextAlign.left, 
                                  'Your Name',
                                  style: GoogleFonts.inknutAntiqua(
                                    fontSize: 14,
                                    color: Color.fromARGB(123, 0, 0, 0),
                                    height: 20/14
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 41,
                                width: 228,
                                child: Text(
                                  textAlign:TextAlign.left, 
                                  'Bibo',
                                  style: GoogleFonts.inknutAntiqua(
                                    fontSize: 20,
                                    color: Color(0xFF070C24),
                                    height: 1
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: 7),
                        SizedBox(
                          height: 82,
                          width: 228,
                          child: Column(
                            children: [
                              SizedBox(
                                height: 41,
                                width: 228,
                                child: Text(
                                  textAlign:TextAlign.left, 
                                  'Email',
                                  style: GoogleFonts.inknutAntiqua(
                                    fontSize: 14,
                                    color: Color.fromARGB(123, 0, 0, 0),
                                    height: 20/14
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 41,
                                width: 228,
                                child: Text(
                                  textAlign:TextAlign.left, 
                                  'xxxx@gmail.com',
                                  style: GoogleFonts.inknutAntiqua(
                                    fontSize: 20,
                                    color: Color(0xFF070C24),
                                    height: 1
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: 7),
                        SizedBox(
                          height: 82,
                          width: 228,
                          child: Column(
                            children: [
                              SizedBox(
                                height: 41,
                                width: 228,
                                child: Text(
                                  textAlign:TextAlign.left, 
                                  'Date of Birth',
                                  style: GoogleFonts.inknutAntiqua(
                                    fontSize: 14,
                                    color: Color.fromARGB(123, 0, 0, 0),
                                    height: 20/14
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 41,
                                width: 228,
                                child: Text(
                                  textAlign:TextAlign.left, 
                                  '2004/08/15',
                                  style: GoogleFonts.inknutAntiqua(
                                    fontSize: 20,
                                    color: Color(0xFF070C24),
                                    height: 1
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: 7),
                        SizedBox(
                          height: 82,
                          width: 228,
                          child: Column(
                            children: [
                              SizedBox(
                                height: 41,
                                width: 228,
                                child: Text(
                                  textAlign:TextAlign.left, 
                                  'Height',
                                  style: GoogleFonts.inknutAntiqua(
                                    fontSize: 14,
                                    color: Color.fromARGB(123, 0, 0, 0),
                                    height: 20/14
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 41,
                                width: 228,
                                child: Text(
                                  textAlign:TextAlign.left, 
                                  '150cm',
                                  style: GoogleFonts.inknutAntiqua(
                                    fontSize: 20,
                                    color: Color(0xFF070C24),
                                    height: 1
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: 7),
                        SizedBox(
                            height: 82,
                            width: 228,
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 41,
                                  width: 228,
                                  child: Text(
                                    textAlign:TextAlign.left, 
                                    'Weight',
                                    style: GoogleFonts.inknutAntiqua(
                                      fontSize: 14,
                                      color: Color.fromARGB(123, 0, 0, 0),
                                      height: 20/14
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 41,
                                  width: 228,
                                  child: Text(
                                    textAlign:TextAlign.left, 
                                    '64kg',
                                    style: GoogleFonts.inknutAntiqua(
                                      fontSize: 20,
                                      color: Color(0xFF070C24),
                                      height: 1
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        SizedBox(height: 5),
                        InkWell(
                          onTap: () {
                            debugPrint('Edit Profile!');
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const EditProfilePage()),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(left: 64),
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
                                        left: 73,
                                        top: 17,
                                        child: SizedBox(
                                          width: 174,
                                          height: 41,
                                          child: Text(
                                            'Edit Profile',
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