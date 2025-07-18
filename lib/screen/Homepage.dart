import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:girls_up/screen/Debut.dart';
import 'package:google_fonts/google_fonts.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {

  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 10), () {
      Navigator.push(
          context, 
          MaterialPageRoute(builder: (context) => Debut())
      );
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/d750304557680483809cd6c97fc34499.jpg'),
              fit: BoxFit.cover,
            ),
          ),

          child: Padding(
            padding: EdgeInsets.all(30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedTextKit(
                  animatedTexts: [
                    TypewriterAnimatedText(
                      'Connect. Learn. Grow. Together.',
                      textStyle: GoogleFonts.cedarvilleCursive(
                        fontSize: 30.0,
                        fontWeight: FontWeight.w600,
                      ),
                      speed: const Duration(milliseconds: 50),
                    ),
                  ],
                  totalRepeatCount: 4,
                  pause: const Duration(milliseconds: 1000),
                  displayFullTextOnTap: true,
                  stopPauseOnTap: true,
                ),
                SizedBox(height: 40,),
                Text('Welcome to Mentorship Platform.',
                  style: GoogleFonts.labrada(
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF000000),
                  ),
                ),
              ],
            ),
          )
      ),
    );
  }
}
