import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background image
          Image.asset(
            'assets/planit_basicbackground_size.png',
            fit: BoxFit.cover,
          ),

          // Overlayed button
          Positioned(
            right: (screenWidth - 300) / 2,
            top: 130.0,
            child: GestureDetector(
              onTap: () {
                // 클릭될 때 수행할 동작
                print("이미지 버튼 클릭됐어용");
              },
              child: Container(
                width: 300.0,
                height: 180.0,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/addplant_image.jpg'),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(15.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: const Stack(
                  children: [
                    Positioned(
                      bottom: 10.0,
                      left: 16.0,
                      child: Text(
                        '반려식물 등록하기',
                        style: TextStyle(
                          color: Color(0xFF025248),
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          Positioned(
            left: screenWidth * 0.15,
            top: 345.0,
            child: const Text(
              '나의 반려식물들',
              style: TextStyle(
                color: Color(0xFF4CACA8),
                fontSize: 18.0,
              ),
            ),
          ),

          Positioned(
            right: (screenWidth - 300) / 2,
            top: 380.0,
            child: GestureDetector(
              onTap: () {
                // 클릭될 때 수행할 동작
                print("이미지 버튼 클릭됐어용");
              },
              child: Container(
                width: 300.0,
                height: 180.0,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/addplant_image.jpg'),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(15.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
