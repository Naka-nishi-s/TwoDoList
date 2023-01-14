import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_renkei_test/addTodo.dart';
import 'package:firebase_renkei_test/addTwodo.dart';
import 'package:firebase_renkei_test/confirm.dart';
import 'package:firebase_renkei_test/firebase_options.dart';
import 'package:firebase_renkei_test/login.dart';
import 'package:firebase_renkei_test/mypage.dart';
import 'package:firebase_renkei_test/register.dart';
import 'package:firebase_renkei_test/todolist.dart';
import 'package:firebase_renkei_test/twodolist.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => Home(),
        '/register': (context) => const Register(),
        '/confirm': (context) => const Confirm(),
        '/login': (context) => const Login(),
        '/todolist': (context) => const TodoList(),
        '/addTodo': (context) => AddTodo(),
        '/mypage': (context) => const Mypage(),
        '/twodolist': (context) => const TwodoList(),
        '/addTwodo': (context) => AddTwodo(),
      },
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: customSwatch),
    );
  }
}

class Home extends StatelessWidget {
  final userInfo = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    if (userInfo == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Text(
              'ホーム',
              style: TextStyle(color: Color.fromARGB(230, 253, 252, 252)),
            ),
          ),
        ),
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 200,
                  margin: const EdgeInsets.only(bottom: 40),
                  child: Image.asset("assets/images/home.png"),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  width: 120,
                  height: 42,
                  child: ElevatedButton(
                    onPressed: (() {
                      Navigator.pushReplacementNamed(context, '/register');
                    }),
                    child: const Text(
                      '新規登録',
                      style:
                          TextStyle(color: Color.fromARGB(230, 253, 252, 252)),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  width: 120,
                  height: 42,
                  child: ElevatedButton(
                    onPressed: (() {
                      Navigator.pushReplacementNamed(context, '/login');
                    }),
                    child: const Text(
                      'ログイン',
                      style:
                          TextStyle(color: Color.fromARGB(230, 253, 252, 252)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

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
