import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
            children: [
              Expanded(
                flex: 1,
                  child: Container(

                  )
              ),
              Divider(),
              Expanded(
                flex: 3,
                  child: Column(

                  )
              ),
            ],
          )
      ),
    );
  }
}
