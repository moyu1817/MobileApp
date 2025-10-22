import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class NetwworkDemo extends StatefulWidget {
  const NetwworkDemo({super.key});

  @override
  State<NetwworkDemo> createState() => _NetwworkDemoState();
}

class _NetwworkDemoState extends State<NetwworkDemo> {
 final Uri _uri =Uri.parse('https://jsonplaceholder.typicode.com/users/1');
  void getUser() async{
    http.Response response = await http.get(_uri);
 debugPrint('Response status: ${response.statusCode}');
    debugPrint('Response body: ${response.body}');
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.only(top: 20),
          alignment: Alignment.topCenter,
          child: Column(
            children: [
              const Text('Click to connect to server'),
              const SizedBox(
                height: 10,
              ),
              FilledButton(
                onPressed: getUser,
                child: const Text('Connect'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
