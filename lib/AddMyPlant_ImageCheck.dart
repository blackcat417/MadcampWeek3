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
            right: 200,
            top: 130.0,
            child: Image.file(
              File(imageUrl),
            ),
          ),


        ],
      ),
    );
  }
}
