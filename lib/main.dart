import 'dart:async';
import 'package:flutter/material.dart';
import 'Community.dart';
import 'Home.dart';
import 'MainLogin.dart';
import 'Market.dart';
import 'MyPage.dart';
import 'Todo.dart';

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
class Main extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> {
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
            icon: Icon(Icons.checklist),
            label: 'To Do',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Community',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Market',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
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