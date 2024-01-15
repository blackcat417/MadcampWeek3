import 'package:flutter/material.dart';
import 'package:planit/Setting/UserAuth.dart';

import 'MainLogin.dart';

class MyPageScreen extends StatelessWidget {
  const MyPageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFEBF3F5),
        title: Center(
          child: Text(
            'MY PAGE',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFF4CACA8),
              fontSize: 27.0,
            ),
          ),
        ),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background image
          Image.asset(
            'assets/planit_nologo_background.png',
            fit: BoxFit.cover,
          ),

          // Overlayed button
          Positioned(
            bottom: 50.0,
            child: ElevatedButton(
              onPressed: () {
                UserAuthManager.logout();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const MainLoginScreen()),
                );
              },
              child: Text('Logout'),
            ),
          ),
        ],
      ),
    );
  }
}
