import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/home.dart';
import '../services/profile_service.dart';

double scale = 2340/2400;

class EditProfilePage extends StatefulWidget{
  const EditProfilePage({super.key});

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final ProfileService _profileService = ProfileService();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _dateOfBirthController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();

  String? _email;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _dateOfBirthController.dispose();
    _heightController.dispose();
    _weightController.dispose();
    super.dispose();
  }

  Future<void> _loadUserData() async {
    final userData = await _profileService.getUserProfile();
    if (userData != null) {
      setState(() {
        _nameController.text = userData['name'] ?? '';
        _email = userData['email'] ?? '';
        _dateOfBirthController.text = userData['dateOfBirth'] ?? '';
        _heightController.text = userData['height'] ?? '';
        _weightController.text = userData['weight'] ?? '';
        _isLoading = false;
      });
    } else {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _saveProfile() async {
    final success = await _profileService.updateUserProfile(
      name: _nameController.text.trim(),
      dateOfBirth: _dateOfBirthController.text.trim(),
      height: _heightController.text.trim(),
      weight: _weightController.text.trim(),
    );

    if (success) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
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
              SizedBox(height: 5*scale),
              SizedBox(
                height: 75*scale,
                width: 323*scale,
                child: Text(
                  'Edit Profile',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inknutAntiqua(
                    fontSize: 28*scale,
                    height: 50/28*scale,
                    color: Color(0xFFE9E6EE)
                  ),
                ),
              ),
              Image(
                image: AssetImage('assets/Account.png'),
                width: 100*scale,
              ),
              SizedBox(height: 10*scale),
              Stack(
                children: [
                  Opacity(
                    opacity: 0.65,
                    child: Container(
                      width: 412*scale,
                      height: 530*scale,
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
                    left: 45*scale,
                    child: Column(
                      
                      children: [
                        SizedBox(height: 50*scale),
                        SizedBox(
                          width: 320*scale,   
                          height: 53*scale,  
                          child: TextField(
                            controller: _nameController,
                            style: GoogleFonts.inknutAntiqua(
                              fontSize: 14*scale,        
                              color: Color(0xFF070C24), 
                            ),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(vertical: 15*scale, horizontal: 12*scale),
                              hintText: 'Bibo',
                              hintStyle: GoogleFonts.inknutAntiqua(
                                fontSize: 14*scale,          
                                color: Color.fromARGB(125, 245, 245, 245),   
                              ),
                              labelText: 'Your Name',
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
                        
                        SizedBox(height: 40*scale),
                        SizedBox(
                          width: 320*scale,   
                          height: 53*scale,  
                          child: TextField(
                            controller: _dateOfBirthController,
                            style: GoogleFonts.inknutAntiqua(
                              fontSize: 14*scale,
                              color: Color(0xFF070C24),
                            ),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(vertical: 15*scale, horizontal: 12*scale),
                              hintText: '2005/02/12',
                              hintStyle: GoogleFonts.inknutAntiqua(
                                fontSize: 14*scale,          
                                color: Color.fromARGB(125, 245, 245, 245),   
                              ),
                              labelText: 'Date of Birth',
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
                        SizedBox(height: 40*scale),
                        SizedBox(
                          width: 320*scale,
                          height: 53*scale,
                          child: TextField(
                            controller: _heightController,
                            style: GoogleFonts.inknutAntiqua(
                              fontSize: 14*scale,
                              color: Color(0xFF070C24),
                            ),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(vertical: 15*scale, horizontal: 12*scale),
                              hintText: '150',
                              hintStyle: GoogleFonts.inknutAntiqua(
                                fontSize: 14*scale,          
                                color: Color.fromARGB(125, 245, 245, 245),   
                              ),
                              labelText: 'Height',
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
                        SizedBox(height: 40*scale),
                        SizedBox(
                          width: 320*scale,
                          height: 53*scale,
                          child: TextField(
                            controller: _weightController,
                            style: GoogleFonts.inknutAntiqua(
                              fontSize: 14*scale,
                              color: Color(0xFF070C24),
                            ),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(vertical: 15*scale, horizontal: 12*scale),
                              hintText: '60',
                              hintStyle: GoogleFonts.inknutAntiqua(
                                fontSize: 14*scale,          
                                color: Color.fromARGB(125, 245, 245, 245),   
                              ),
                              labelText: 'Weight',
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
                        SizedBox(height: 40*scale),
                        InkWell(
                          onTap: _saveProfile,
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
                                            'Save',
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