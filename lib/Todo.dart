import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'Setting/UserAuth.dart';

class TodoScreen extends StatefulWidget {
  TodoScreen({Key? key}) : super(key: key);

  @override
  _TodoScreenState createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  DateTime selectedDay = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );

  DateTime focusedDay = DateTime.now();

  Map<DateTime, List<Todo>> _events = {};

  Future<List<Todo>> fetchUserTodos(String date) async {
    String? userId = await UserAuthManager.getUserId();
    final response = await http.get(
      Uri.parse('http://143.248.192.43:3000/userTodos/$userId/$date'),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> userTodosData = data['userTodos'];
      return userTodosData.map((item) => Todo.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load user todos');
    }
  }

  Future<void> addTodo(String date, String text) async {
    String? userId = await UserAuthManager.getUserId();
    final response = await http.post(
      Uri.parse('http://143.248.192.43:3000/addTodo'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'UserId': userId,
        'date': date,
        'text': text,
        'isDone': false,
      }),
    );

    if (response.statusCode == 200) {
      print('Todo added successfully');
    } else {
      throw Exception('Failed to add todo');
    }
  }

  @override
  void initState() {
    super.initState();
    _loadUserTodos();
  }

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

          Align(
            alignment: Alignment.center,
            child: Container(
              margin: EdgeInsets.only(top: 30, left: 20, right: 20),
              width: 300,
              height: 392,
              child: TableCalendar(
                locale: 'ko_KR',
                firstDay: DateTime.utc(2021, 10, 16),
                lastDay: DateTime.utc(2030, 3, 14),
                focusedDay: focusedDay,
                eventLoader: (DateTime day) {
                  return _events[day] ?? [];
                },
                onDaySelected: (DateTime selectedDay, DateTime focusedDay) {
                  setState(() {
                    this.selectedDay = selectedDay;
                    this.focusedDay = focusedDay;
                  });
                  _loadUserTodos(); // 날짜가 선택되면 해당 날짜의 Todo를 서버에서 불러옴
                },
                selectedDayPredicate: (DateTime day) {
                  return isSameDay(selectedDay, day);
                },

              ),
            ),
          ),

          // Event display section
          Positioned(
            bottom: 40.0,
            left: 35.0,
            right: 20.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 150.0,
                  child: FutureBuilder<List<Todo>>(
                    future: fetchUserTodos(selectedDay.toString()),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return SpinKitFadingCircle(
                          color: Color(0xff169384),
                          size: 50.0,
                        );
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        return ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (BuildContext context, int index) {
                            Todo todo = snapshot.data![index];
                            return Container(
                              margin: EdgeInsets.symmetric(vertical: 4.0),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: ListTile(
                                title: Text(
                                  todo.title,
                                  style: TextStyle(
                                    decoration: todo.isDone
                                        ? TextDecoration.lineThrough
                                        : null,
                                  ),
                                ),
                                leading: Checkbox(
                                  value: todo.isDone,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      todo.isDone = value ?? false;
                                    });
                                    _updateTodo(todo); // Checkbox 상태가 변경될 때 서버로 업데이트
                                  },
                                ),
                              ),
                            );
                          },
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),

          // + 버튼 추가
          Positioned(
            bottom: 16.0,
            right: 16.0,
            child: FloatingActionButton(
              onPressed: () {
                // + 버튼을 누를 때 Todo 입력 Dialog 띄우기
                _showAddTodoDialog();
              },
              backgroundColor: Color(0xFF74B9B5),
              child: Icon(Icons.add,color: Colors.white,),
            ),
          ),
        ],
      ),
    );
  }

  // 선택한 날짜에 Todo를 추가하는 함수
  void addTodoForSelectedDay(Todo newTodo) {
    setState(() {
      List<Todo> eventsForSelectedDay = _events[selectedDay] ?? [];
      eventsForSelectedDay.add(newTodo);
      _events[selectedDay] = eventsForSelectedDay;
    });
  }

  // 현재 선택한 날짜의 모든 이벤트를 삭제하는 함수
  void deleteAllEventsForSelectedDay() {
    setState(() {
      _events[selectedDay] = [];
    });
  }

  // Todo 입력 Dialog 표시
  void _showAddTodoDialog() async {
    String newTodoText = '';
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('To-do 입력'),
          content: TextField(
            onChanged: (text) {
              newTodoText = text;
            },
            decoration: InputDecoration(hintText: 'Enter your Todo'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('취소'),
            ),
            ElevatedButton(
              onPressed: () async {
                Todo newTodo = Todo(title: newTodoText);
                addTodoForSelectedDay(newTodo);
                Navigator.pop(context);
                print('${selectedDay}');
                await addTodo(selectedDay.toString(), newTodoText);
                _loadUserTodos(); // Todo를 추가한 후 서버에서 업데이트된 데이터를 불러옴
              },
              child: Text('추가'),
            ),
          ],
        );
      },
    );
  }

  // 서버에서 사용자의 특정 날짜 Todo를 불러와 업데이트하는 함수
  Future<void> _loadUserTodos() async {
    try {
      List<Todo> userTodos = await fetchUserTodos(selectedDay.toString());

      setState(() {
        _events[selectedDay] = userTodos;
      });
    } catch (error) {
      print('Error loading user todos: $error');
    }
  }


  void _updateTodo(Todo todo) async {
    String? userId = await UserAuthManager.getUserId();
    final response = await http.put(
      Uri.parse('http://143.248.192.43:3000/updateTodo'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'UserId': userId,
        'date': selectedDay.toString(),
        'text': todo.title,
        'isDone': todo.isDone,
      }),
    );

    if (response.statusCode == 200) {
      print('Todo updated successfully');
    } else {
      throw Exception('Failed to update todo');
    }
  }

}

class Todo {
  final String title;
  bool isDone;

  Todo({required this.title, this.isDone = false});

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      title: json['text'],
      isDone: json['isDone'] ?? false,
    );
  }
}
