import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:planit/EmailLogin.dart';
import 'package:planit/camera_ex.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

class ImageCheckScreen extends StatelessWidget {
  final String imageUrl;

  ImageCheckScreen({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    final File _imageFile = File(imageUrl);

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
            top: 140.0,
            child: Container(
              width: 300.0,
              height: 250.0,
              decoration: BoxDecoration(
                image: _imageFile != null
                    ? DecorationImage(
                        image: FileImage(_imageFile!), // File에서 Image를 생성
                        fit: BoxFit.cover,
                      )
                    : const DecorationImage(
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
            right: (screenWidth - 300) / 2,
            left: (screenWidth - 300) / 2,
            top: 500.0,
            child: Text(
              '반려식물은 땡땡땡 해당 결과가 정확한가요?',
              textAlign: TextAlign.center,
            ),
          ),

          Positioned(
            left: (screenWidth - 300) / 2,
            top: 550.0,
            width: 140,
            child: MaterialButton(
              onPressed: () async {
                Navigator.pop(
                  context,
                  {
                    'imageUrl': imageUrl,
                    'guessPlantType': 'Yes from Screen 2',
                  },
                );
              },
              color: const Color(0xff4dafac),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              height: 50.0,
              child: const Text(
                '예',
                style: TextStyle(
                  fontSize: 17.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),

          Positioned(
            right: (screenWidth - 300) / 2,
            top: 550.0,
            width: 140,
            child: MaterialButton(
              onPressed: () async {
                Navigator.pop(
                  context,
                  {
                    'imageUrl': imageUrl,
                    'guessPlantType': 'No from Screen 2',
                  },
                );
              },
              color: const Color(0xffebd9c1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              height: 50.0,
              child: Text(
                '아니오\n(직접 입력)',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Color(0xff4dafac),
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
