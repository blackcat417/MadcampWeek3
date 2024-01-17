import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

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
              margin: EdgeInsets.only(top:30, left: 20, right: 20),
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
                  child: ListView.builder(
                    itemCount: _events[selectedDay]?.length ?? 0,
                    itemBuilder: (BuildContext context, int index) {
                      Todo todo = _events[selectedDay]![index];
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
                              decoration: todo.isDone ? TextDecoration.lineThrough : null,
                            ),
                          ),
                          leading: Checkbox(
                            value: todo.isDone,
                            onChanged: (bool? value) {
                              setState(() {
                                todo.isDone = value ?? false;
                              });
                            },
                          ),
                        ),
                      );
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
              child: Icon(Icons.add),
            ),
          ),

          Positioned(
            bottom: 80.0,
            right: 16.0,
            child: FloatingActionButton(
              onPressed: () {
                // 현재 선택한 날짜의 모든 이벤트 삭제
                deleteAllEventsForSelectedDay();
              },
              child: Icon(Icons.remove),
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
          title: Text('Add Todo'),
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
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Todo newTodo = Todo(title: newTodoText);
                addTodoForSelectedDay(newTodo);
                Navigator.pop(context);
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }
}

class Todo {
  final String title;
  bool isDone;

  Todo({required this.title, this.isDone = false});

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'isDone': isDone,
    };
  }
}
