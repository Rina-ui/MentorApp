import 'package:flutter/material.dart';
import 'package:girls_up/screen/Homepage.dart';
import 'package:google_fonts/google_fonts.dart';

import 'Register.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isLoading = false;
  bool isPassword = true;

  void togglePassword(){
    setState(() {
      isPassword= !isPassword;
    });
  }

  Future<void> login() async {
    final username = usernameController.text;
    final email = emailController.text;
    final password = passwordController.text;

    if (username.isEmpty || email.isEmpty || password.isEmpty){
      _showError('Please fill in all fields');
      return;
    }
  }
  
  void _showError (String message) {
    showDialog(
        context: context, 
        builder: (_) => AlertDialog(
          title: Text('Error'),
          content: Text(message),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(context), 
                child: Text('OK')
            )
          ],
        )
    );
  }


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
              Text('Login',
                style: GoogleFonts.cedarvilleCursive(
                  fontSize: 60,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF000000),
                ),

              ),
              SizedBox(height: 20,),
              TextField(
                decoration: InputDecoration(
                    suffixIcon: Icon(Icons.person_outline_outlined),
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
                    suffixIcon: Icon(Icons.email_sharp),
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
                  suffixIcon: Icon(Icons.remove_red_eye_outlined),
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
                      MaterialPageRoute(builder: (context) => Homepage() ));
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
                  Text("New member?",style: TextStyle(
                    fontSize: 18,
                    color: Color(0xFF000000),
                    fontWeight: FontWeight.w400,
                  ),),
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Register() ));
                    },
                    child: Text("Register",style: TextStyle(
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
