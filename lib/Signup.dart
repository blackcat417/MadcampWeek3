import 'dart:async';

import 'package:flutter/material.dart';

//Signup 화면 관련 선언
class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 배경화면
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/planit_basicbackground_size.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),

          const Positioned(
            right: 50.0,
            top: 300.0,
            child: Text('E-mail')
          ),

          const Positioned(
              right: 50.0,
              bottom: 400.0,
              child: Text('비밀번호')
          ),

        ],
      ),
    );
  }
}