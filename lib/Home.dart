import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:planit/AddMyPlant.dart';

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
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AddMyPlantScreen()),
                );
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
                      offset: const Offset(0, 2),
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
            top: 360.0,
            child: SizedBox(
              // 그리드뷰의 전체 크기 제한
              width: 305,
              height: 210,
              child: MyPlantsGrid(),
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

class MyPlantsGrid extends StatelessWidget {
  const MyPlantsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      scrollDirection: Axis.horizontal,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        mainAxisSpacing: 30.0, //아이템 간 메인이 되는 축 간격 조절
        childAspectRatio: 5 / 3.8, //그리드뷰 안의 아이템 비율 조절
      ),
      itemCount: postList.length,
      itemBuilder: (BuildContext context, int index) {
        return postContainer(
          colorName: postList[index]["color"] as Color,
        );
      },
    );
  }

  Padding postContainer({Color colorName = Colors.black}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0, top:8.0, right:5.0, left:5.0),
      child: Container(
        decoration: BoxDecoration(
          color: colorName,
          borderRadius: BorderRadius.circular(15.0), // 원하는 둥근 정도 설정
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
      ),
    );
  }
}
