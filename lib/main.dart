import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp()); //앱 실행 명령어, 앱의 메인페이지를 적어주면 됨
}

class MyApp extends StatelessWidget { //앱의 메인페이지 만드는 법
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context){

    return const MaterialApp(
      home: SplashScreen(),
    );

  }
}

// 메인 화면 관련 선언
// ignore: use_key_in_widget_constructors
class MyHomePage extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  // 화면 리스트
  final List<Widget> _screens = [
    const HomeScreen(),
    const TodoScreen(),
    const CommunityScreen(),
    const MarketScreen(),
    const MyPageScreen(),
  ];

  // 탭 선택 시 호출될 함수
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'To Do',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'Community',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'Market',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'My',
          ),
        ],
        currentIndex: _selectedIndex,
        unselectedItemColor: const Color(0xFFEBD9C1),
        selectedItemColor: const Color(0xFF4CACA8),
        onTap: _onItemTapped,
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Home Screen'),
    );
  }
}

class TodoScreen extends StatelessWidget {
  const TodoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Todo Screen'),
    );
  }
}

class CommunityScreen extends StatelessWidget {
  const CommunityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Community Screen'),
    );
  }
}

class MarketScreen extends StatelessWidget {
  const MarketScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Market Screen'),
    );
  }
}

class MyPageScreen extends StatelessWidget {
  const MyPageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('My Page Screen'),
    );
  }
}


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
    // 3초 후에 홈 화면으로 전환
    Timer(
      const Duration(seconds: 3),
          () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MainLoginScreen()),
      ),
    );
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

//MainLogin 화면 전환

class MainLoginScreen extends StatefulWidget {
  const MainLoginScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MainLoginState createState() => _MainLoginState();
}

class _MainLoginState extends State<MainLoginScreen> {
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Stack(
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
            bottom: 115.0,  // 아래 여백 조절
            left: 50.0,   // 왼쪽 여백 조절
            child: MaterialButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignupScreen()),
                );
              },
              child: Image.asset('assets/kakao_login_large_wide.png'),
            ),
          ),

          // 버튼 배치
          Positioned(
            right: 50.0,
            bottom: 50.0,  // 아래 여백 조절
            left: 50.0,   // 왼쪽 여백 조절
            child: TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignupScreen()),
                );
              },
              style: TextButton.styleFrom(
                primary: Colors.white,
                textStyle: const TextStyle(
                  fontSize: 18.0,
                ),
                backgroundColor: Colors.transparent, // 배경색을 투명으로 설정
              ),
              child: Text('이메일로 로그인/회원가입'),
            ),
          ),
        ],
      ),
    );
  }
}


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
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/planit_basicbackground.png'),
            // 스플래시 화면에 사용할 이미지
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}