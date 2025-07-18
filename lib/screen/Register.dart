import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

import 'Homepage.dart';
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
  bool learner = false;
  bool mentor = false;
  bool isPassword = true;

  Future<void> register() async {

    final username = usernameController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (!learner && !mentor) {
      _showError('Veuillez sélectionner un rôle.');
      return;
    }

    if (username.isEmpty || email.isEmpty || password.isEmpty){
      _showError('Please enter a username and password');
      return;
    }

    final url = Uri.parse('http://10.0.2.2:3000/api/user/register');
    final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'username': usernameController.text,
          'email': emailController.text,
          'password': passwordController.text,
          'role': learner ? 'learner' : 'mentor'
        })
    );

    if (response.statusCode == 200 || response.statusCode == 201){
      final data = jsonDecode(response.body);
      print ('Registration successful: $data');

      Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Homepage())
      );
    }else{
      print('Registration failded: ${response.statusCode}');
      _showError('Registration failded: ${response.statusCode}');
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
                Text('Register',
                  style: GoogleFonts.cedarvilleCursive(
                    fontSize: 60,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF000000),
                  ),
                ),
                SizedBox(height: 20,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CheckboxListTile(
                      value: learner,
                      onChanged: (value) {
                        setState(() {
                          learner = value!;
                          if (value) mentor = false;
                        });
                      },
                      title: Text('Learner'),
                    ),
                    CheckboxListTile(
                      value: mentor,
                      onChanged: (value) {
                        setState(() {
                          mentor = value!;
                          if (value) learner = false;
                        });
                      },
                      title: Text('Mentor'),
                    )
                  ],
                ),
                TextField(
                  decoration: InputDecoration(
                      suffixIcon: Icon(Icons.person_outline_outlined),
                      labelText: 'Username',
                      hintStyle: TextStyle(color: Colors.white,),
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
                  onTap: register,
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
