import 'dart:io';
import 'package:flutter/material.dart';
import 'Home.dart';

class MyPlantDetailsScreen extends StatefulWidget {
  final MyPlant myPlant;

  const MyPlantDetailsScreen({Key? key, required this.myPlant})
      : super(key: key);

  @override
  _MyPlantDetailsScreenState createState() => _MyPlantDetailsScreenState();
}

class _MyPlantDetailsScreenState extends State<MyPlantDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background image
          Image.asset(
            'assets/planit_nologo_background.png',
            fit: BoxFit.cover,
          ),

          Align(
            alignment: Alignment.center,
            child: Container(
              margin: EdgeInsets.only(bottom: 280.0),
              width: 160,
              height: 160,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5), // 그림자 색상과 투명도
                    spreadRadius: 2, // 그림자 확장 정도
                    blurRadius: 5, // 그림자 흐림 정도
                    offset: Offset(0, 2), // 그림자 위치 (수평, 수직)
                  ),
                ],
              ),
              child: ClipOval(
                child: Image.file(
                  File(widget.myPlant.imageUrl as String),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),

          Align(
            alignment: Alignment.center,
            child: Container(
              margin: EdgeInsets.only(bottom: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center, // 수평 정렬을 중앙으로 설정
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic, // 기준선을 아랫선으로 설정
                children: [
                  Text(
                    '${widget.myPlant.nickname}',
                    style: TextStyle(
                      color: Color(0xFF4CACA8),
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(width: 10), // 아랫선을 맞추기 위한 간격 조절
                  Text(
                    '${widget.myPlant.plantType}',
                    style: TextStyle(
                      color: Color(0xFF74B9B5),
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),


          Align(
            alignment: Alignment.center,
            child: Container(
              margin: EdgeInsets.only(top: 60.0), // 위로 조절하는 부분
              child: Text(
                '함께하기 시작한 날 ${widget.myPlant.date}',
                style: TextStyle(
                  color: Color(0xFF74B9B5),
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),

          Align(
            alignment: Alignment.center,
            child: Container(
              margin: EdgeInsets.only(top: 300.0), // 위로 조절하는 부분
              child: SizedBox(
                width: 305,
                height: 210,
                child: MyPlantsDetailGrid(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

final myPlantsDetail = [
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

class MyPlantsDetailGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      scrollDirection: Axis.vertical,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 1.0,
      ),
      itemCount: myPlantsDetail.length,
      itemBuilder: (BuildContext context, int index) {
        return postContainer(
          colorName: myPlantsDetail[index]["color"] as Color,
        );
      },
    );
  }

  Container postContainer(
      {Color colorName = Colors.black}) {
    return Container(
      width: 90,
      height: 90,
      child: Column(
        children: [
          Container(width: 90, height: 90, color: colorName),
        ],
      ),
    );
  }
}