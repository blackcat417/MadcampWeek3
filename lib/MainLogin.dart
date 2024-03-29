import 'dart:async';
import 'package:flutter/material.dart';
import 'package:planit/Setting/Userauth.dart';
import 'EmailLogin.dart';
import 'main.dart';

//Splash 화면 관련 선언
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 3), // 3초 후에 MainLogin 화면으로 전환
      () => checkAndNavigate(),
    );
  }

  Future<void> checkAndNavigate() async {
    if (await UserAuthManager.getUserId()!=null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Main()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MainLoginScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/planit_splash.png'), // 스플래시 화면에 사용할 이미지
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

//MainLogin 화면
class MainLoginScreen extends StatefulWidget {
  const MainLoginScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MainLoginState createState() => _MainLoginState();
}

class _MainLoginState extends State<MainLoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // 배경화면
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/planit_splash.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),

          Positioned(
            right: 50.0,
            bottom: 180.0,
            left: 50.0,
            child: MaterialButton(
              onPressed: () {
                //!!!!!!!!!!!!클릭시 카카오 로그인을 하는 기능 추가 필요!!!!!!!!!!!!!
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Main()),
                );
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Image.asset('assets/kakao_login_resize.png'),
            ),
          ),

          Positioned(
            right: 50.0,
            bottom: 130.0,
            left: 50.0,
            child: TextButton(
              onPressed: () {
                //버튼 클릭 시 EmailLogin 화면으로 이동
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const EmailLoginScreen()),
                );
              },
              style: TextButton.styleFrom(
                primary: Colors.white,
                textStyle: const TextStyle(
                  fontSize: 25.0,
                ),
                backgroundColor: Colors.transparent,
              ),
              child: Text('이메일로 로그인 / 회원가입'),
            ),
          ),
        ],
      ),
    );
  }
}

