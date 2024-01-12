import 'dart:async';

import 'package:flutter/material.dart';

import 'Signup.dart';

//Signup 화면 관련 선언
class EmailLoginScreen extends StatefulWidget {
  const EmailLoginScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _EmailLoginScreenState createState() => _EmailLoginScreenState();
}

class _EmailLoginScreenState extends State<EmailLoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          // 배경화면
          Positioned.fill(
            child: GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus(); // 다른 곳을 터치하면 포커스 해제
              },
              child: Image.asset(
                'assets/planit_basicbackground_size.png',
                fit: BoxFit.cover,
              ),
            ),
          ),

          const Positioned(
            left: 50.0,
            top: 230.0,
            right: 50.0,

            child: SizedBox(
              width: 300,
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'E-mail',
                  labelStyle: TextStyle(color: Color(0xFF4CACA8)),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide(width: 1, color: Color(0xFF4CACA8)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide(width: 1, color: Color(0xFF4CACA8)),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
            ),
          ),

          const Positioned(
            left: 50.0,
            top: 320.0,
            right: 50.0,
            child: SizedBox(
              width: 300,
              child: TextField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: '비밀번호',
                  labelStyle: TextStyle(color: Color(0xFF4CACA8)),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide(width: 1, color: Color(0xFF4CACA8)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide(width: 1, color: Color(0xFF4CACA8)),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
            ),
          ),

          Positioned(
            right: 50.0,
            top: 410.0,
            left: 50.0,
            child: MaterialButton(
              onPressed: () {
                //!!!!!!!!!!클릭시 로그인 검증 기능 추가 필요!!!!!!!!!!!!!
              },
              color: const Color(0xFF04a22f),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              height: 55.0,
              child: const Text(
                '로그인',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
