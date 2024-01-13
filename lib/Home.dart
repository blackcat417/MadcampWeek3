import 'package:flutter/material.dart';
import 'package:http/http.dart';

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
                  image: const DecorationImage(
                    image: AssetImage('assets/addplant_image.jpg'),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(15.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
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
            left: screenWidth * 0.09,
            top: 330.0,
            child: const Text(
              '나의 반려식물들',
              style: TextStyle(
                color: Color(0xFF4CACA8),
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          Positioned(
            right: (screenWidth - 300) / 2,
            top: 370.0,
            child: Container( // Container로 감싸서 크기 제한
              width: 300,
              height: 300,
              child: YourGridView(),
            ),
          ),
        ],
      ),
    );
  }
}

final postList = [
  {
    "color": Colors.amber,
  },
  {
    "color": Colors.lightBlue,
  },
  {
    "color": Colors.redAccent,
  },
  {
    "color": Colors.indigo,
  },
  {
    "color": Colors.yellowAccent,
  },
  {
    "color": Colors.greenAccent,
  },
];

class YourGridView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      scrollDirection: Axis.horizontal,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        mainAxisSpacing: 1.0,
      ),
      itemCount: postList.length,
        itemBuilder: (BuildContext context, int index) {
          return postContainer(
            colorName: postList[index]["color"] as Color,
          );
        },
    );
  }

  Container postContainer(
      {Color colorName = Colors.black}) {
    return Container(
      width: 150,
      height: 200,
      child: Column(
        children: [
          Container(width: 150, height: 200, color: colorName),
        ],
      ),
    );
  }
}