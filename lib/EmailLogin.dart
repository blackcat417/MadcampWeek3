import 'dart:async';

import 'package:flutter/material.dart';
import 'package:planit/MainLogin.dart';

import 'Signup.dart';
import 'http.dart';

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
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus(); // 다른 곳을 터치하면 포커스 해제
        },
        child: SingleChildScrollView(
          child: Stack(
            children: [
              // 배경화면
              Image.asset(
                'assets/planit_basicbackground_resize.png',
                fit: BoxFit.cover,
              ),

              const Positioned(
                left: 50.0,
                right: 50.0,
                top: 200.0,
                child: Text('테스트용'),
              ),

              const Positioned(
                left: 50.0,
                top: 250.0,
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
                top: 330.0,
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

              Positioned(
                right: 50.0,
                top: 410.0,
                left: 50.0,
                child: MaterialButton(
                  onPressed: () {
                    //!!!!!!!!!!클릭시 로그인 검증 기능 추가 필요
                  },
                  color: const Color(0xff169384),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  height: 50.0,
                  child: const Text(
                    '로그인',
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              Positioned(
                left: screenWidth*0.15,
                top: 475.0,
                child: TextButton(
                  onPressed: () {//버튼 클릭 시 Signup 화면으로 이동
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const SignupScreen()),
                    );
                  },
                  style: TextButton.styleFrom(
                    primary: Colors.black38,
                    textStyle: const TextStyle(
                      fontSize: 16.0,
                    ),
                    backgroundColor: Colors.transparent,
                  ),
                  child: Text('비밀번호 찾기'),
                ),
              ),

              // 세로 구분선
              Positioned(
                left: screenWidth * 0.5,
                top: 485.0,
                child: Container(
                  height: 30.0, // 세로 구분선의 높이
                  width: 1.0,   // 세로 구분선의 너비
                  color: Colors.black38, // 세로 구분선의 색상
                ),
              ),

              Positioned(
                right: screenWidth * 0.2,
                top: 475.0,
                child: TextButton(
                  onPressed: () {//버튼 클릭 시 Signup 화면으로 이동
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const SignupScreen()),
                    );
                  },
                  style: TextButton.styleFrom(
                    primary: Colors.black38,
                    textStyle: const TextStyle(
                      fontSize: 16.0,
                    ),
                    backgroundColor: Colors.transparent,
                  ),
                  child: Text('회원가입'),
                ),
              ),

              Positioned(
                right: 50.0,
                top: 540.0,
                left: 50.0,
                child: MaterialButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const MainLoginScreen()),
                    );
                  },
                  color: const Color(0xFF74B9B5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  height: 48.0,
                  child: const Text(
                    '메인으로 돌아가기',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
