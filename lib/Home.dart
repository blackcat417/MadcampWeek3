import 'package:flutter/material.dart';
import 'package:planit/AddMyPlant.dart';
import 'package:http/http.dart' as http;

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
            top: 130.0,
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
                          fontSize: 21.0,
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

class MyPlant {
  final String nickname;
  final String date;
  final String imageUrl;

  MyPlant(this.nickname, this.date, this.imageUrl);
}

final List<MyPlant> MyPlants = [
  MyPlant('로자니아', '2024-01-16',
      'https://upload.wikimedia.org/wikipedia/commons/thumb/d/d3/Nelumno_nucifera_open_flower_-_botanic_garden_adelaide2.jpg/300px-Nelumno_nucifera_open_flower_-_botanic_garden_adelaide2.jpg'),
  MyPlant('스투키', '2024-01-30',
      'https://img1.daumcdn.net/thumb/R800x0/?scode=mtistory2&fname=https%3A%2F%2Fblog.kakaocdn.net%2Fdn%2FbSAyPb%2FbtqyGb2Mh4V%2F4YxjkNmePtvb788K1jYa40%2Fimg.jpg'),
];

class MyPlantsGrid extends StatelessWidget {
  const MyPlantsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      scrollDirection: Axis.horizontal,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        mainAxisSpacing: 15.0, //아이템 간 메인이 되는 축 간격 조절
        childAspectRatio: 5 / 3.8, //그리드뷰 안의 아이템 비율 조절
      ),
      itemCount: MyPlants.length,
      itemBuilder: (BuildContext context, int index) {
        return _buildItemCard(MyPlants[index]);
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
                child: Image.network(
                  myPlant.imageUrl,
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
                          fontSize: 13.0,
                          fontWeight: FontWeight.bold)),
                  Text(myPlant.nickname,
                      style: TextStyle(
                          color: Color(0xFF025248),
                          fontSize: 21.0,
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
