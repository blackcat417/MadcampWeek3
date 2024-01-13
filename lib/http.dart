import 'dart:convert';
import 'package:http/http.dart' as http;

class MyHttpClient {
  static Future<void> fetchData() async {
    final response = await http.get(Uri.parse('http://localhost:3000/api/data'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      print(data['message']);
    } else {
      print('Failed to load data');
    }
  }
}