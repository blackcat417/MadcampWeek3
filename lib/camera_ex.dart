import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';

class CameraExample extends StatefulWidget {
  @override
  _CameraExampleState createState() => _CameraExampleState();
}

class _CameraExampleState extends State<CameraExample> {
  File? _image;
  List? _outputs;

  // 앱이 실행될 때 loadModel 호출
  @override
  void initState() {
    super.initState();
    loadModel();
  }

  // 모델과 label.txt를 가져온다.
  Future<void> loadModel() async {
    try {
      await Tflite.loadModel(
        model: "assets/model_unquant.tflite",
        labels: "assets/labels.txt",
      );
    } catch (e) {
      print('Error loading model: $e');
    }
  }

  // 비동기 처리를 통해 카메라와 갤러리에서 이미지를 가져온다.
  Future getImage(ImageSource imageSource) async {
    final image = await ImagePicker().pickImage(source: imageSource);

    setState(() {
      _image = File(image!.path);
    });
    await classifyImage(File(image!.path));
  }

  // 이미지 분류
  Future<void> classifyImage(File image) async {
    print("Image path: ${image.path}");
    var output = await Tflite.runModelOnImage(
      path: image.path,
      imageMean: 0.0,
      imageStd: 255.0,
      numResults: 1,
      threshold: 0.0,
      asynch: true,
    );
    print("Output: $output");
    setState(() {
      _outputs = output;
    });

    // 결과 다이얼로그 표시
    recycleDialog();
  }

  // 이미지를 보여주는 위젯
  Widget showImage() {
    return Container(
      color: const Color(0xffd0cece),
      margin: EdgeInsets.only(left: 95, right: 95),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.width,
      child: Center(
        child: _image == null
            ? Text('No image selected.')
            : Image.file(File(_image!.path)),
      ),
    );
  }

  // 결과 다이얼로그
  void recycleDialog() {
    if (_outputs != null) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Class: ${_outputs![0]['label']}',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15.0,
                    background: Paint()..color = Colors.white,
                  ),
                ),
                Text(
                  'Confidence: ${( _outputs![0]['confidence'] * 100).toStringAsFixed(2)}%',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15.0,
                    background: Paint()..color = Colors.white,
                  ),
                ),
              ],
            ),
            actions: <Widget>[
              Center(
                child: new MaterialButton(
                  child: new Text("Ok"),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              )
            ],
          );
        },
      );
    } else {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  "데이터가 없거나 잘못된 이미지 입니다.",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15.0,
                  ),
                ),
              ],
            ),
            actions: <Widget>[
              Center(
                child: new MaterialButton(
                  child: new Text("Ok"),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              )
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

    return Scaffold(
      backgroundColor: const Color(0xfff4f3f9),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Classify',
            style: TextStyle(fontSize: 25, color: const Color(0xff1ea271)),
          ),
          SizedBox(height: 25.0),
          showImage(),
          SizedBox(
            height: 50.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              FloatingActionButton(
                child: Icon(Icons.add_a_photo),
                tooltip: 'Pick Image',
                onPressed: () async {
                  await getImage(ImageSource.camera);
                },
              ),
              FloatingActionButton(
                child: Icon(Icons.wallpaper),
                tooltip: 'Pick Image',
                onPressed: () async {
                  await getImage(ImageSource.gallery);
                },
              ),
            ],
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    Tflite.close();
    super.dispose();
  }
}
