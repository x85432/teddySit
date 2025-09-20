import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../widgets/home.dart';
import 'Userprofile.dart';
import '../services/auth_service.dart';

double scale = 2340/2400;

class LogInPage extends StatelessWidget{
  LogInPage({super.key});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 100*scale,
        title: Padding(
          padding: EdgeInsets.only(top: 11*scale, left: 12*scale),
          child: const Teddysit(),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(top: 28*scale), 
            child: InkWell(
              onTap: () {
                Navigator.popUntil(context, (route) => route.isFirst);
              },
              child: Image(image: AssetImage('assets/Home.png'), width: 35*scale, height: 35*scale),
            ),
          ),
          SizedBox(width: 18*scale),
          Padding(
            padding: EdgeInsets.only(top: 28*scale),
            child: InkWell(
              onTap: () {
                
              },
              child: Image(image: AssetImage('assets/Account.png'), width: 45*scale, height: 45*scale),
            )
          ),
          SizedBox(width: 18*scale),
        ],
      ),
      body: Center(
        child: SizedBox(
          height: 810*scale,
          width: 412*scale,
          child: Column(
            children: [
              SizedBox(height: 125*scale),
              InkWell(
                onTap: () {
                  Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const UserProfilePage()),
                );
                },
                child: Padding(
                  padding: EdgeInsets.only(left: 15*scale),
                  child: Row(
                    children: [
                      const Image(image: AssetImage('assets/Arrow.png')),
                      Text(
                        'Back',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.inknutAntiqua(
                          fontSize: 16*scale,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              
             
              SizedBox(height: 15*scale),
              Stack(
                children: [
                  Opacity(
                    opacity: 0.65,
                    child: Container(
                      width: 412*scale,
                      height: (MediaQuery.of(context).size.height - 300)*scale,
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
                    top: 60*scale,
                    left: 47*scale,
                    child: SizedBox(
                      height: 75*scale,
                      width: 323*scale,
                      child: Text(
                        'Welcome Back!',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.inknutAntiqua(
                          fontSize: 32*scale,
                          height: 50/32*scale,
                          color: Color(0xFF070C24)
                        ),
                      ),
                    ),
                  ),
                  
                  Positioned(
                    top: 120*scale,
                    left: 47*scale,
                    child: Column(
                      children: [
                        SizedBox(height: 35*scale),
                        SizedBox(
                          width: 320*scale,   
                          height: 53*scale,  
                          child: TextField(
                            controller: _emailController,
                            style: GoogleFonts.inknutAntiqua(
                              fontSize: 14*scale,
                              color: Color(0xFF070C24),
                            ),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(vertical: 15*scale, horizontal: 12*scale),
                              hintText: 'Enter Email',
                              hintStyle: GoogleFonts.inknutAntiqua(
                                fontSize: 14*scale,          
                                color: Color.fromARGB(125, 245, 245, 245),   
                              ),
                              labelText: 'Email',
                              labelStyle: GoogleFonts.inknutAntiqua(
                                fontSize: 14*scale,          
                                color: Color.fromARGB(124, 0, 0, 0), 
                              ),
                              floatingLabelBehavior: FloatingLabelBehavior.always,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(18),
                                borderSide: BorderSide(color: Color.fromARGB(126, 245, 245, 245), width: 3*scale),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(color: Color.fromARGB(126, 245, 245, 245), width: 3*scale),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(color: const Color.fromARGB(173, 79, 74, 119), width: 3*scale),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 45*scale),
                        SizedBox(
                          width: 320*scale,   
                          height: 53*scale,  
                          child: TextField(
                            controller: _passwordController,
                            obscureText: true,
                            style: GoogleFonts.inknutAntiqua(
                              fontSize: 14*scale,
                              color: Color(0xFF070C24),
                            ),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(vertical: 15*scale, horizontal: 12*scale),
                              hintText: 'Enter Password',
                              hintStyle: GoogleFonts.inknutAntiqua(
                                fontSize: 14*scale,          
                                color: Color.fromARGB(125, 245, 245, 245),   
                              ),
                              labelText: 'Password',
                              labelStyle: GoogleFonts.inknutAntiqua(
                                fontSize: 14*scale,          
                                color: Color.fromARGB(124, 0, 0, 0), 
                              ),
                              floatingLabelBehavior: FloatingLabelBehavior.always,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(18),
                                borderSide: BorderSide(color: Color.fromARGB(126, 245, 245, 245), width: 3*scale),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(color: Color.fromARGB(126, 245, 245, 245), width: 3*scale),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(color: const Color.fromARGB(173, 79, 74, 119), width: 3*scale),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 70*scale),
                        InkWell(
                          onTap: () async {
                            if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
                              Fluttertoast.showToast(
                                msg: "請填寫所有欄位",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0*scale
                              );
                              return;
                            }

                            debugPrint("Email: ${_emailController.text}");
                            debugPrint("Password: ${_passwordController.text}");
                            
                            // 呼叫 AuthService 進行登入
                            await AuthService().signin(
                              email: _emailController.text,
                              password: _passwordController.text,
                              context: context
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(left: 0),
                            child: Column(
                              children: [
                                SizedBox(
                                  width: 319*scale,
                                  height: 53*scale,
                                  child: Stack(
                                    children: [
                                      Positioned(
                                        left: 0,
                                        top: 0,
                                        child: Container(
                                          width: 319*scale,
                                          height: 53*scale,
                                          decoration: ShapeDecoration(
                                            color: Color(0xFF070C24),
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(18),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        left: 65*scale,
                                        top: 14*scale,
                                        child: SizedBox(
                                          width: 174*scale,
                                          height: 41*scale,
                                          child: Text(
                                            'Log In',
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.inknutAntiqua(
                                              color: Colors.white,
                                              fontSize: 20*scale,
                                              height: 1*scale,
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