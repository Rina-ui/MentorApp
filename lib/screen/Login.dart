import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:girls_up/screen/Homepage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

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
  bool learner = false;
  bool mentor = false;

  void togglePassword(){
    setState(() {
      isPassword= !isPassword;
    });
  }

  Future<void> login() async{
    final username = usernameController.text.trim();
    final password = passwordController.text.trim();

    if (username.isEmpty || password.isEmpty){
      _showError('Please enter a username and password');
      return;
    }
    setState( () => isLoading = true);
    try {
      final url = Uri.parse('http://10.0.2.2:3000/api/user/loginUser');
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'username': username,
          'password': password,
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201){
        final data = jsonDecode(response.body);
        final token = data['token'] as String?;

        if (token == null){
          _showError('Login successful but not receive token');
        }else{
          //stocker le token
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('jwt_token', token);

          // Navigate to Home
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => Homepage()),
          );
        }
      }else if (response.statusCode == 401 || response.statusCode == 404) {
        _showLoginNotFoundDialog();
      } else {
        _showError('Erreur serveur (${response.statusCode})');
      }
    }catch (e, stack) {
      print('Login exception: $e');
      print(stack);
      _showError('Erreur : $e');
    } finally {
      setState(() => isLoading = false);
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

  void _showLoginNotFoundDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('User not found'),
        content: Text("Account don't correspond to any user."),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text('Cancel')),
          TextButton(
            onPressed: () {
              Navigator.pop(context); // ferme le dialog
              Navigator.push(context, MaterialPageRoute(builder: (_) => Login()));
            },
            child: Text('Register'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
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
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CheckboxListTile(
                      value: learner,
                      onChanged: (value) {
                        setState(() {
                          learner = value!;
                        });
                      },
                    title: Text('Learner'),
                  ),
                  CheckboxListTile(
                      value: mentor,
                      onChanged: (value) {
                        setState(() {
                          mentor = value!;
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
