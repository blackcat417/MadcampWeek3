import 'package:flutter/material.dart';
import 'package:planit/Setting/UserAuth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'MainLogin.dart';

class MyPageScreen extends StatelessWidget {
  MyPageScreen({Key? key}) : super(key: key);

  void showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.grey,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: UserAuthManager.getUserId(), // 비동기로 userId를 가져오는 Future
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // 데이터가 아직 도착하지 않았을 때
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          // 에러가 발생했을 때
          return Text('Error: ${snapshot.error}');
        } else {
          // 데이터가 도착했을 때
          final String? userId = snapshot.data;

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
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 40.0), // 위쪽 여백 조절
                    child: Text(
                      'MY PAGE',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF4CACA8),
                        fontSize: 37.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),


                Align(
                  alignment: Alignment.center,
                  child: Container(
                    margin: EdgeInsets.only(bottom: 350.0),
                    width: 140,
                    height: 140,
                    decoration: BoxDecoration(
                      color: Colors.white, // 배경 색상
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xFF4CACA8).withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: ClipOval(
                      child: Image.asset(
                        'assets/free-icon-gardener-2832111.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),

                Align(
                  alignment: Alignment.center,
                  child: Container(
                    margin: EdgeInsets.only(bottom: 140.0),
                    child: Text(
                      '$userId',
                      style: TextStyle(
                        fontSize: 30,
                        color: Color(0xFF025248),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                Align(
                  alignment: Alignment.center,
                  child: Container(
                    margin: EdgeInsets.only(bottom: 50.0),
                    width: 330.0,
                    height: 1.0,
                    color: Color(0xFF4CACA8), // 선의 색상
                  ),
                ),

                Align(
                  alignment: Alignment.center,
                  child: Container(
                    margin: EdgeInsets.only(top: 40.0), // Align 위젯에 마진 추가
                    child: ElevatedButton(
                      onPressed: () {
                        showToast('미구현 기능입니다');
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xFFFFF3DC),
                        // 버튼 배경색
                        onPrimary: Color(0xFF4CACA8),
                        // 텍스트 색상
                        elevation: 5,
                        // 그림자 높이
                        fixedSize: Size(330, 50),
                        // 고정 크기 설정
                        shape: RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.circular(10.0), // 버튼 모서리 둥글기 설정
                        ),
                        shadowColor: Colors.black, // 그림자 색상
                      ),
                      child: Text(
                        'MY 반려식물 관리하기',
                        style: TextStyle(
                          fontSize: 20, // 텍스트 크기 조절
                          fontWeight: FontWeight.bold, // 텍스트 굵기 조절
                        ),
                      ),
                    ),
                  ),
                ),

                Align(
                  alignment: Alignment.center,
                  child: Container(
                    margin: EdgeInsets.only(top: 180.0), // Align 위젯에 마진 추가
                    child: ElevatedButton(
                      onPressed: () {
                        showToast('미구현 기능입니다');
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xFFFFF3DC),
                        // 버튼 배경색
                        onPrimary: Color(0xFF4CACA8),
                        // 텍스트 색상
                        elevation: 5,
                        // 그림자 높이
                        fixedSize: Size(330, 50),
                        // 고정 크기 설정
                        shape: RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.circular(10.0), // 버튼 모서리 둥글기 설정
                        ),
                        shadowColor: Colors.black, // 그림자 색상
                      ),
                      child: Text(
                        '찜한 식물 관리하기',
                        style: TextStyle(
                          fontSize: 20, // 텍스트 크기 조절
                          fontWeight: FontWeight.bold, // 텍스트 굵기 조절
                        ),
                      ),
                    ),
                  ),
                ),

                Align(
                  alignment: Alignment.center,
                  child: Container(
                    margin: EdgeInsets.only(top: 320.0), // Align 위젯에 마진 추가
                    child: ElevatedButton(
                      onPressed: () {
                        UserAuthManager.logout();
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MainLoginScreen()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xFFFFF3DC),
                        // 버튼 배경색
                        onPrimary: Color(0xFF4CACA8),
                        // 텍스트 색상
                        elevation: 5,
                        // 그림자 높이
                        fixedSize: Size(330, 50),
                        // 고정 크기 설정
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(10.0), // 버튼 모서리 둥글기 설정
                        ),
                        shadowColor: Colors.black, // 그림자 색상
                      ),
                      child: Text(
                        '로그아웃',
                        style: TextStyle(
                          fontSize: 20, // 텍스트 크기 조절
                          fontWeight: FontWeight.bold, // 텍스트 굵기 조절
                        ),
                      ),
                    ),
                  ),
                ),

                Align(
                  alignment: Alignment.center,
                  child: Container(
                    margin: EdgeInsets.only(top: 550.0),
                    width: 330.0,
                    height: 150.0, // 이미지의 높이 설정
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0), // 꼭짓점을 둥글게 하는 부분
                      color: Color(0xFF4CACA8), // 선의 색상
                    ),
                    child: Image.asset(
                      'assets/advertise.png', // 이미지 파일의 경로
                      fit: BoxFit.cover, // 이미지가 부모 컨테이너에 맞도록 설정
                    ),
                  ),
                ),

              ],
            ),
          );
        }
      },
    );
  }
}
