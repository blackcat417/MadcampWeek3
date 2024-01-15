import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:planit/MainLogin.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'Signup.dart';
import 'main.dart';

//Signup 화면 관련 선언
class EmailLoginScreen extends StatefulWidget {
  const EmailLoginScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _EmailLoginScreenState createState() => _EmailLoginScreenState();
}

class _EmailLoginScreenState extends State<EmailLoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    void checkLoginToast() {
      Fluttertoast.showToast(
        msg: '잘못된 로그인 정보입니다',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.white70,
        textColor: Color(0xFF4CACA8),
        fontSize: 16.0,
      );
    }

    Future<void> login() async {
      final response = await http.post(
        Uri.parse('http://143.248.192.79:3000/login'), // 서버의 주소로 변경
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'Email': emailController.text,
          'password': passwordController.text,
        }),
      );

      print(emailController.text);
      print(passwordController.text);
      print(response.body);
      print(response.statusCode);

      if (response.statusCode == 200) {
        print('Login successful');
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Main()),
        );
      } else if (response.statusCode == 401) {
        print('잘못된 로그인');
        checkLoginToast();
      } else {
        print('Login failed');
      }
    }

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

              Positioned(
                left: 50.0,
                top: 250.0,
                right: 50.0,
                child: SizedBox(
                  width: 300,
                  child: TextField(
                    controller: emailController,
                    decoration: const InputDecoration(
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

              Positioned(
                left: 50.0,
                top: 330.0,
                right: 50.0,
                child: SizedBox(
                  width: 300,
                  child: TextField(
                    obscureText: true,
                    controller: passwordController,
                    decoration: const InputDecoration(
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
                    login();
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
