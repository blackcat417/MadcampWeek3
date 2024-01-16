import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:planit/EmailLogin.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'Setting/Userauth.dart';
import 'main.dart';


//Signup 화면 관련 선언
class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController UserIdController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController checkPasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {

    void checkUserIdToast() {
      Fluttertoast.showToast(
        msg: '이미 존재하는 ID입니다',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.white70,
        textColor: Color(0xFF4CACA8),
        fontSize: 16.0,
      );
    }

    void checkPWToast() {
      Fluttertoast.showToast(
        msg: '비밀번호가 일치하지 않습니다',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.white70,
        textColor: Color(0xFF4CACA8),
        fontSize: 16.0,
      );
    }

    void signupToast() {
      Fluttertoast.showToast(
        msg: '회원가입 완료',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.white70,
        textColor: Color(0xFF4CACA8),
        fontSize: 16.0,
      );
    }

    Future<void> signup() async {
      final response = await http.post(
        Uri.parse('http://10.199.228.144:3000/signup'), // 서버의 주소로 변경
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'UserId': UserIdController.text,
          'password': passwordController.text,
          'checkPassword': checkPasswordController.text,
        }),
      );

      if (response.statusCode == 200) {
        print('Signup successful');
        await UserAuthManager.saveUserId(UserIdController.text);
        print('User ${await UserAuthManager.getUserId()} logged in.');
        signupToast();
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Main()),
        );
      } else if (response.statusCode == 400) {
        print('유저 이미 존재');
        checkUserIdToast();
      } else {
        print('Signup failed ${response.statusCode}');
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
                    controller: UserIdController,
                    decoration: InputDecoration(
                      labelText: 'ID',
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
                    controller: passwordController,
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
                left: 50.0,
                top: 410.0,
                right: 50.0,
                child: SizedBox(
                  width: 300,
                  child: TextField(
                    controller: checkPasswordController,
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
                top: 482.0,
                left: 50.0,
                child: MaterialButton(
                  onPressed: () {
                    if(checkPasswordController.text!=passwordController.text){ //패스워드 검사랑 패스워드가 일치하지 않을 때
                      checkPWToast();
                    } else {
                      signup(); //DB에 데이터 넣기
                    }
                  },
                  color: const Color(0xff169384),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  height: 50.0,
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
                top: 540.0,
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
                    '이전 화면으로 돌아가기',
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