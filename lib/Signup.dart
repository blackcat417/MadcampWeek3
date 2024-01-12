import 'dart:async';

import 'package:flutter/material.dart';
import 'package:planit/EmailLogin.dart';

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
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

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
                  labelStyle: TextStyle(color: Colors.black38),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    borderSide: BorderSide(width: 1, color: Color(0xFF4CACA8)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    borderSide: BorderSide(width: 1, color: Color(0xFF4CACA8)),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
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
                  labelStyle: TextStyle(color: Colors.black38),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    borderSide: BorderSide(width: 1, color: Color(0xFF4CACA8)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    borderSide: BorderSide(width: 1, color: Color(0xFF4CACA8)),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                  ),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
            ),
          ),

          const Positioned(
            left: 50.0,
            top: 410.0,
            right: 50.0,
            child: SizedBox(
              width: 300,
              child: TextField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: '비밀번호 확인',
                  labelStyle: TextStyle(color: Colors.black38),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    borderSide: BorderSide(width: 1, color: Color(0xFF4CACA8)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    borderSide: BorderSide(width: 1, color: Color(0xFF4CACA8)),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                  ),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
            ),
          ),

          Positioned(
            right: 50.0,
            top: 495.0,
            left: 50.0,
            child: MaterialButton(
              onPressed: () {
                // 클릭시 DB에 데이터 넘기고 현재 접속자 기억 후 메인화면으로 넘어가야함
              },
              color: const Color(0xff169384),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              height: 55.0,
              child: const Text(
                '회원가입',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),

          Positioned(
            right: 50.0,
            top: 565.0,
            left: 50.0,
            child: MaterialButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const EmailLoginScreen()),
                );
              },
              color: const Color(0xFF74B9B5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              height: 48.0,
              child: const Text(
                '로그인 화면으로 돌아가기',
                style: TextStyle(
                  fontSize: 16.0,
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