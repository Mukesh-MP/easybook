import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(
              height: MediaQuery.of(context).size.height * .3,
              child: Text("Sign In")),
          TextField(
              decoration:
                  InputDecoration(hintText: "Please enter your usercode")),
          TextField(
              decoration:
                  InputDecoration(hintText: "Please enter your password")),
        ],
      ),
    );
  }
}
