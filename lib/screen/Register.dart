import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'Login.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/097c11d95d23b930fac5cfa6c9bb7d50.jpg'),
              fit: BoxFit.cover,
            ),
          ),

          child: Padding(
            padding: EdgeInsets.all(50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Register',
                  style: GoogleFonts.cedarvilleCursive(
                    fontSize: 60,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF000000),
                  ),

                ),
                SizedBox(height: 20,),
                TextField(
                  decoration: InputDecoration(
                      labelText: 'Username',
                      hintStyle: TextStyle(color: Colors.white),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      )
                  ),
                  controller: usernameController ,
                ),
                SizedBox(height: 20,),
                TextField(
                  decoration: InputDecoration(
                      labelText: 'Email',
                      hintStyle: TextStyle(color: Colors.white),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      )
                  ),
                  controller: emailController ,
                ),
                SizedBox(height: 20,),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Password',
                    hintStyle: TextStyle(color: Colors.white),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  controller: passwordController ,
                ),

                SizedBox(height: 40,),
                GestureDetector(
                  onTap: (){
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Register() ));
                  },
                  child:  Row(
                    children: [
                      Spacer(),
                      CircleAvatar(
                        radius: 30.0,
                        backgroundColor: Color(0xFF95d5b2),
                        child: Icon(Icons.arrow_forward, size: 40, color: Colors.white, ),
                      ),
                      SizedBox(width: 10,),

                    ],
                  ),
                ),
                SizedBox(height: 40,width: 56,),
                Row(
                  children: [
                    SizedBox(width: 15,),
                    Text("Have an account?",style: TextStyle(
                      fontSize: 18,
                      color: Color(0xFF000000),
                      fontWeight: FontWeight.w400,
                    ),),
                    GestureDetector(
                      onTap: (){
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Login() ));
                      },
                      child: Text("Login",style: TextStyle(
                        fontSize: 18,
                        color: Color(0xFF324A59),
                        fontWeight: FontWeight.w500,
                      ),),
                    )

                  ],
                )
              ],
            ),
          )
      ),
    );
  }
}
