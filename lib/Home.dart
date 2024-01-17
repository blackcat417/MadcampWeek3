import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:planit/AddMyPlant.dart';
import 'package:http/http.dart' as http;
import 'package:planit/Setting/UserAuth.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'MyPlantDetailsScreen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

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
            top: 200.0,
            child: GestureDetector(
              onTap: () {
                // 클릭될 때 수행할 동작
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AddMyPlantScreen()),
                );
              },
              child: Container(
                width: 300.0,
                height: 220.0,
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
                          fontSize: 24.0,
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
            left: screenWidth * 0.13,
            top: 440.0,
            child: const Text(
              '나의 반려식물들',
              style: TextStyle(
                color: Color(0xFF4CACA8),
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          Positioned(
            right: (screenWidth - 300) / 2,
            top: 480.0,
            child: SizedBox(
              width: 305,
              height: 230,
              child: FutureBuilder<List<MyPlant>>(
                future: getUserPlants(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    // 데이터가 아직 로드되지 않은 경우 로딩 화면을 보여줄 수 있습니다.
                    return SpinKitFadingCircle(
                      color: Color(0xff169384),
                      size: 50.0,
                    );
                  } else if (snapshot.hasError) {
                    // 에러가 발생한 경우 에러 메시지를 표시할 수 있습니다.
                    return Text('Error: ${snapshot.error}');
                  } else {
                    // 데이터가 성공적으로 로드된 경우 MyPlantsGrid를 반환합니다.
                    return MyPlantsGrid(myPlants: snapshot.data!);
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<List<MyPlant>> getUserPlants() async {
    String? userId = await UserAuthManager.getUserId();
    final response = await http.get(
      Uri.parse('http://143.248.192.43:3000/userPlants/$userId'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> plantData = json.decode(response.body)['userPlants'];
      return plantData
          .map((item) => MyPlant(
                item['nickname'],
                item['date'],
                item['imageUrl'],
                item['plantType'],
                item['memo'],
              ))
          .toList();
    } else {
      throw Exception('Failed to load user plants');
    }
  }
}

class MyPlant {
  final String nickname;
  final String date;
  final String imageUrl;
  final String plantType;
  final String memo;

  MyPlant(this.nickname, this.date, this.imageUrl, this.plantType, this.memo);
}

class MyPlantsGrid extends StatelessWidget {
  final List<MyPlant> myPlants;

  const MyPlantsGrid({Key? key, required this.myPlants}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      scrollDirection: Axis.horizontal,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        mainAxisSpacing: 15.0,
        childAspectRatio: 5 / 3.8,
      ),
      itemCount: myPlants.length,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
            // 세부 정보가 있는 새 화면으로 이동
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    MyPlantDetailsScreen(myPlant: myPlants[index]),
              ),
            );
          },
          child: _buildItemCard(myPlants[index]),
        );
      },
    );
  }

  Widget _buildItemCard(MyPlant myPlant) {
    return Padding(
      padding:
          const EdgeInsets.only(bottom: 8.0, top: 8.0, right: 5.0, left: 5.0),
      child: Container(
        decoration: BoxDecoration(
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
        child: Stack(
          fit: StackFit.expand,
          children: [
            ColorFiltered(
              colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.4),
                BlendMode.dstIn,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: Image.file(
                  File(myPlant.imageUrl as String),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              left: 8.0, // 왼쪽 여백 설정
              bottom: 8.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start, // 텍스트를 왼쪽 정렬
                children: [
                  Text(myPlant.date,
                      style: TextStyle(
                          color: Color(0xFF0D7064),
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold)),
                  Text(myPlant.nickname,
                      style: TextStyle(
                          color: Color(0xFF025248),
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
