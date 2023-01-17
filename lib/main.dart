import 'package:firebase_renkei_test/addTodo.dart';
import 'package:firebase_renkei_test/addTwodo.dart';
import 'package:firebase_renkei_test/todolist.dart';
import 'package:firebase_renkei_test/twodolist.dart';
import 'package:flutter/material.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => Home(),
        '/todolist': (context) => const TodoList(),
        '/addTodo': (context) => AddTodo(),
        '/twodolist': (context) => const TwodoList(),
        '/addTwodo': (context) => AddTwodo(),
      },
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: customSwatch),
    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const TodoList();
  }
}

/// メインの色を変える
const MaterialColor customSwatch = MaterialColor(
  0xFFe8ae62,
  <int, Color>{
    50: Color(0xFFfdf9f2),
    100: Color(0xFFfbf0de),
    200: Color(0xFFf9e6c8),
    300: Color(0xFFf6dcb2),
    400: Color(0xFFf4d5a2),
    500: Color(0xFFf2cd91),
    600: Color(0xFFf0c889),
    700: Color(0xFFeec17e),
    800: Color(0xFFecba74),
    900: Color(0xFFe8ae62),
  },
);
