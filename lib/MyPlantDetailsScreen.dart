import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'Home.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'Setting/UserAuth.dart';

class MyPlantDetailsScreen extends StatefulWidget {
  final MyPlant myPlant;

  const MyPlantDetailsScreen({Key? key, required this.myPlant})
      : super(key: key);

  @override
  _MyPlantDetailsScreenState createState() => _MyPlantDetailsScreenState();
}

class _MyPlantDetailsScreenState extends State<MyPlantDetailsScreen> {
  String? newImageUrl;
  List<String> galleryImages = [];

  @override
  void initState() {
    super.initState();
    fetchGalleryData();
  }

  Future<void> _takePicture() async {
    final XFile? picture = await ImagePicker().pickImage(
      source: ImageSource.camera,
    );

    if (picture != null) {
      // 여기서 사진을 업로드하거나 필요한 다른 동작을 수행할 수 있습니다.
      setState(() {
        newImageUrl = picture.path;
      });

      print('Image URL: $newImageUrl');
      uploadImage(newImageUrl!);
    }
  }

  Future<void> uploadImage(String imageUrl) async {
    try {
      final response = await http.post(
        Uri.parse('http://143.248.192.43:3000/plant-gallery/${widget.myPlant.nickname}'),
        headers: <String, String>{'Content-Type': 'application/json'},
        body: jsonEncode(<String, dynamic>{
          'UserId' : await UserAuthManager.getUserId(),
          'imageUrl': imageUrl,
          'nickname': widget.myPlant.nickname
        }),
      );

      if (response.statusCode == 200) {
        print('Image added to gallery successfully');
        fetchGalleryData(); // Refresh gallery after upload
      } else {
        // Handle error
        print('Failed to add image to gallery: ${response.statusCode}');
      }
    } catch (error) {
      // Handle error
      print('Error adding image to gallery: $error');
    }
  }

  Future<void> fetchGalleryData() async {
    try {
      // 닉네임에 해당하는 갤러리 데이터를 가져오기 위한 API 엔드포인트
      final response = await http.get(Uri.parse('http://143.248.192.43:3000/plant-gallery/${widget.myPlant.nickname}'));
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        // 갤러리 데이터에서 이미지 URL 리스트 추출
        final List<String> images = List<String>.from(data['gallery']);
        setState(() {
          galleryImages = images;
        });
      } else {
        // 실패한 경우 에러 처리
        print('Failed to load gallery data');
      }
    } catch (error) {
      // 예외 처리
      print('Error fetching gallery data: $error');
    }
  }


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
              margin: EdgeInsets.only(bottom: 280.0),
              width: 50,
              height: 50,
              child: IconButton(
                icon: Icon(Icons.photo_camera),
                onPressed: () {
                  _takePicture();
                },)
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
                child: MyPlantsDetailGrid(galleryImages: galleryImages),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MyPlantsDetailGrid extends StatelessWidget {
  final List<String> galleryImages;

  MyPlantsDetailGrid({required this.galleryImages});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      scrollDirection: Axis.vertical,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
      ),
      itemCount: galleryImages.length,
      itemBuilder: (BuildContext context, int index) {
        return postContainer(
          imageUrl: galleryImages[index],
        );
      },
    );
  }

  Container postContainer({required String imageUrl}) {
    return Container(
      width: 90,
      height: 90,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: FileImage(File(imageUrl)),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
