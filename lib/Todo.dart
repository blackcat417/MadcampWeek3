import 'package:flutter/material.dart';

class TodoScreen extends StatelessWidget {
  const TodoScreen({Key? key}) : super(key: key);

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

          // Overlayed button
          Positioned(
            bottom: 50.0,
            child: ElevatedButton(
              onPressed: () {
                // Handle button press
              },
              child: Text('To do'),
            ),
          ),
        ],
      ),
    );
  }
}
