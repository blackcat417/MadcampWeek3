import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:planit/Setting/UserAuth.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

import 'AddMyPlant_ImageCheck.dart';

class AddMyPlantScreen extends StatefulWidget {
  const AddMyPlantScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AddMyPlantScreenState createState() => _AddMyPlantScreenState();
}

class _AddMyPlantScreenState extends State<AddMyPlantScreen> {
  DateTime selectedDate = DateTime.now();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController plantTypeController = TextEditingController();
  final TextEditingController nicknameController = TextEditingController();
  final TextEditingController memoController = TextEditingController();

  void checkPlantTypeToast() {
    Fluttertoast.showToast(
      msg: '식물의 종을 입력해주세요',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.white70,
      textColor: Color(0xFF4CACA8),
      fontSize: 16.0,
    );
  }

  void checkNicknameToast() {
    Fluttertoast.showToast(
      msg: '반려식물의 애칭을 입력해주세요',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.white70,
      textColor: Color(0xFF4CACA8),
      fontSize: 16.0,
    );
  }

  void checkDateToast() {
    Fluttertoast.showToast(
      msg: '함께하기 시작한 날을 입력해주세요',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.white70,
      textColor: Color(0xFF4CACA8),
      fontSize: 16.0,
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        dateController.text = "${picked.toLocal()}".split(' ')[0];
      });
    }
  }

  Future<void> addPlant() async {
    try {
      print(
          '${await UserAuthManager.getUserId().toString()},${await UserAuthManager.getUserId().toString().runtimeType}');
      print(
          '${plantTypeController.text},${plantTypeController.text.runtimeType}');
      print(
          '${nicknameController.text},${nicknameController.text.runtimeType}');
      print('${dateController.text},${dateController.text.runtimeType}');
      print('${memoController.text},${memoController.text.runtimeType}');

      final response = await http.post(
        Uri.parse('http://143.248.192.141:3000/addPlant'), // 서버의 주소로 변경
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(<String, dynamic>{
          'UserId': await UserAuthManager.getUserId(),
          'imageUrl': 'imageUrl',
          'plantType': plantTypeController.text,
          'nickname': nicknameController.text,
          'date': dateController.text,
          'memo': memoController.text,
        }),
      );
      print(response.body);
      print(response.statusCode);

      if (response.statusCode == 200) {
        print('Plant registered successfully!');
      } else if (response.statusCode == 401) {
        print('');
      } else {
        print('Failed to register plant. Error: ${response.statusCode}');
      }
    } catch (error) {
      print('Error adding plant: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus(); // 다른 곳을 터치하면 포커스 해제
        },
        child: SingleChildScrollView(
          child: Stack(
            children: [
              // 배경화면
              Image.asset(
                'assets/planit_scrollbackground_size.png',
                fit: BoxFit.cover,
              ),

              Positioned(
                right: (screenWidth - 300) / 2,
                top: 130.0,
                child: Container(
                  width: 300.0,
                  height: 150.0,
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
                ),
              ),

              Positioned(
                  right: 40,
                  top: 230.0,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return SelectImageDialog();
                            },
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Color(0xFF025248),
                          fixedSize: Size(30, 40),
                        ),
                        child: Container(), // 빈 컨테이너로 버튼 영역 확보
                      ),
                      Positioned(
                        child: GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return SelectImageDialog();
                              },
                            );
                          },
                          child: Icon(Icons.photo_camera, color: Colors.white),
                        ),
                      ),
                    ],
                  )),

              Positioned(
                right: (screenWidth - 300) / 2,
                top: 290.0,
                child: SizedBox(
                  width: 300,
                  child: TextField(
                    controller: plantTypeController,
                    decoration: InputDecoration(
                      labelText: '식물 종',
                      labelStyle: TextStyle(color: Colors.black38),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        borderSide:
                            BorderSide(width: 1, color: Color(0xFF4CACA8)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        borderSide:
                            BorderSide(width: 1, color: Color(0xFF4CACA8)),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      ),
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                ),
              ),

              Positioned(
                right: (screenWidth - 300) / 2,
                top: 370.0,
                child: SizedBox(
                  width: 300,
                  child: TextField(
                    controller: nicknameController,
                    decoration: InputDecoration(
                      labelText: '반려식물 애칭',
                      labelStyle: TextStyle(color: Colors.black38),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        borderSide:
                            BorderSide(width: 1, color: Color(0xFF4CACA8)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        borderSide:
                            BorderSide(width: 1, color: Color(0xFF4CACA8)),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      ),
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                ),
              ),

              Positioned(
                right: (screenWidth - 300) / 2,
                top: 450.0,
                child: SizedBox(
                  width: 300,
                  child: InkWell(
                    onTap: () {
                      _selectDate(context);
                    },
                    child: AbsorbPointer(
                      child: TextField(
                        controller: dateController,
                        decoration: InputDecoration(
                          labelText: '함께하기 시작한 날',
                          labelStyle: TextStyle(color: Colors.black38),
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0)),
                            borderSide:
                                BorderSide(width: 1, color: Color(0xFF4CACA8)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0)),
                            borderSide:
                                BorderSide(width: 1, color: Color(0xFF4CACA8)),
                          ),
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0)),
                          ),
                        ),
                        keyboardType: TextInputType.emailAddress,
                      ),
                    ),
                  ),
                ),
              ),

              Positioned(
                right: (screenWidth - 300) / 2,
                top: 530.0,
                child: SizedBox(
                  width: 300,
                  child: TextField(
                    controller: memoController,
                    decoration: InputDecoration(
                      labelText: '메모',
                      labelStyle: TextStyle(color: Colors.black38),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        borderSide:
                            BorderSide(width: 1, color: Color(0xFF4CACA8)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        borderSide:
                            BorderSide(width: 1, color: Color(0xFF4CACA8)),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      ),
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                ),
              ),

              Positioned(
                right: (screenWidth - 300) / 2,
                top: 610.0,
                width: 300,
                child: MaterialButton(
                  onPressed: () {
                    if (plantTypeController.text == '') {
                      checkPlantTypeToast();
                    } else if (nicknameController.text == '') {
                      checkNicknameToast();
                    } else if (dateController.text == '') {
                      checkDateToast();
                    } else {
                      addPlant();
                    }
                  },
                  color: const Color(0xff169384),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  height: 50.0,
                  child: const Text(
                    '등록 완료',
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SelectImageDialog extends StatelessWidget {
  Future<void> _getImageFromCamera(BuildContext context) async {
    final XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
    );

    if (pickedFile != null) {
      String imageUrl = pickedFile.path;
      print('Camera Image URL: $imageUrl');
      _navigateToDisplayImageScreen(context, imageUrl);

    }
  }

  Future<void> _getImageFromGallery(BuildContext context) async {
    final XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      String imageUrl = pickedFile.path;
      print('Gallery Image URL: $imageUrl');
      _navigateToDisplayImageScreen(context, imageUrl);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        '반려식물 사진 추가',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 22.0,
          color: Color(0xFF025248),
          fontWeight: FontWeight.bold,
        ),
      ),
      titlePadding: EdgeInsets.fromLTRB(8.0, 30.0, 8.0, 8.0),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () => _getImageFromCamera(context),
            icon: Icon(Icons.photo_camera),
            iconSize: 50,
            color: Color(0xFF4CACA8),
          ),
          SizedBox(width: 40),
          IconButton(
            onPressed: () => _getImageFromGallery(context),
            icon: Icon(Icons.wallpaper),
            iconSize: 50,
            color: Color(0xFF4CACA8),
          ),
        ],
      ),
    );
  }
}

void _navigateToDisplayImageScreen(BuildContext context, String imageUrl) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => ImageCheckScreen(imageUrl: imageUrl),
    ),
  );
}