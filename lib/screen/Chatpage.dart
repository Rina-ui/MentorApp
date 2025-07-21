import 'dart:io' as IO;

import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../utils/user.dart';

class Chatpage extends StatefulWidget {
  final User user;
  Chatpage({required this.user});

  @override
  State<Chatpage> createState() => _ChatpageState();
}

class _ChatpageState extends State<Chatpage> {
  final TextEditingController _mesaageController = TextEditingController();
  final List<String> messages = [];

  late IO.Socket socket;

  @override
  void initState() {
    super.initState();
    connectToServer();
  }

  void connectToServer() {
    socket = IO.io('http://10.0.2.2:3000', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': true,
    });
    
    socket.onConnect((_) {
      print('Connect to the server');
    });
    
    socket.on('receiveMessage', (data){
      setState(() {
        messages.add(data);
      });
    });
    
    socket.onDisconnect((_) => print('Disconnect to the server'));
  }

  void sendMessage() {
    if (_mesaageController.text.isNotEmpty) {
      setState(() {
        messages.add(_mesaageController.text);
        _mesaageController.clear();
      });
    }
  }

  @override
  void dispose() {
    socket.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chat avec ${widget.user.username}"),
      ),
      body: Column(
        children: [
          Expanded(
              child: ListView.builder(
                itemCount: messages.length,
                  itemBuilder: (_, index) => ListTile(
                    title: Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        padding: EdgeInsets.all(8),
                        color: Colors.green[100],
                        child: Text(messages[index]),
                      ),
                    ),
                  )
              )
          ),
          Divider(),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                Expanded(
                    child: TextField(
                      controller: _mesaageController,
                      decoration: InputDecoration(
                        hintText: 'Messages'
                      ),
                    ),
                ),
                IconButton(
                    onPressed: sendMessage,
                    icon: Icon(Icons.send),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
