import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../utils/user.dart';

class Debut extends StatefulWidget {
  const Debut({super.key});

  @override
  State<Debut> createState() => _DebutState();
}

class _DebutState extends State<Debut> {
  List<User> users = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchUsers();
  }
  
  Future<void> fetchUsers() async {
    final url = Uri.parse('http://10.0.2.2:3000/api/user/getAllUser');

    try{
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        setState(() {
          users = data.map((json) => User.fromJson(json)).toList();
          isLoading = false;
        });
      }else{
        print('Error: ${response.statusCode}');
        setState(() => isLoading = false);
      }
    }catch (e) {
      print('Connection error: $e');
      setState(() {
        isLoading = false;
      });
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Users'),
        centerTitle: true,
      ),
      body: isLoading
        ?Center(child: CircularProgressIndicator())
        :ListView.builder(
          itemCount: users.length,
          itemBuilder: (context, index) {
            final user = users[index];
            return ListTile(
              title: Text(user.username),
              subtitle: Text(user.role),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => Chatpage(user: user)),
                );
              },
            );
          }
      )
    );
  }
}
