import 'dart:io';
import 'package:flutter/material.dart';
import 'Home.dart';

class MyPlantDetailsScreen extends StatefulWidget {
  final MyPlant myPlant;

  const MyPlantDetailsScreen({Key? key, required this.myPlant}) : super(key: key);

  @override
  _MyPlantDetailsScreenState createState() => _MyPlantDetailsScreenState();
}

class _MyPlantDetailsScreenState extends State<MyPlantDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Plant Details'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.file(widget.myPlant.imageUrl as File),
          Text('Nickname: ${widget.myPlant.nickname}'),
          Text('Date: ${widget.myPlant.date}'),
          // Add more details as needed
        ],
      ),
    );
  }
}
