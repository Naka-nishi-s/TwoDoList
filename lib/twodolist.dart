import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TwodoList extends StatefulWidget {
  const TwodoList({super.key});

  @override
  State<TwodoList> createState() => _TwodoListState();
}

class _TwodoListState extends State<TwodoList> {
  List<String> todoList = [];
  var user;

  final iconList = [
    Icons.smart_toy_outlined,
    Icons.accessibility,
    Icons.ac_unit
  ];

  /// 端末に保存する処理
  Future savePrefs() async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setStringList("twodo", todoList);
  }

  /// 端末から取り出す処理
  Future getPrefs() async {
    var prefs = await SharedPreferences.getInstance();
    if (prefs.getStringList("twodo") == null) {
      return;
    } else {
      todoList = prefs.getStringList("twodo")!;
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getPrefs();
    getUser();
  }

  /// ユーザー取得処理
  Future getUser() async {
    user = FirebaseAuth.instance.currentUser;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height / 3;

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Color.fromARGB(230, 253, 252, 252)),
        title: const Text(
          "TwoDoリスト",
          style: TextStyle(color: Color.fromARGB(230, 253, 252, 252)),
        ),
        actions: [HumanIcon()],
      ),
      drawer: Menu(
        text: "Todoリスト",
        route: "/todolist",
        instance: FirebaseAuth.instance,
      ),
      body: SafeArea(
        child: ListView.builder(
            itemCount: todoList.length,
            itemBuilder: (context, index) {
              return SizedBox(
                height: (deviceHeight),
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  margin: const EdgeInsets.fromLTRB(14, 20, 14, 14),
                  elevation: 10,
                  child: Center(
                    child: ListTile(
                      leading: Icon(
                        iconList[Random().nextInt(3)],
                        size: 34,
                        color: const Color.fromARGB(255, 190, 222, 248),
                      ),
                      title: Text(
                        todoList[index],
                        style: const TextStyle(
                            fontSize: 30,
                            color: Color.fromARGB(255, 66, 66, 61)),
                      ),
                      trailing: IconButton(
                        icon: const Icon(
                          Icons.delete_forever_outlined,
                          size: 36,
                          color: Color.fromARGB(255, 240, 154, 148),
                        ),
                        onPressed: () {
                          setState(() {
                            todoList.removeAt(index);
                            savePrefs();
                          });
                        },
                      ),
                    ),
                  ),
                ),
              );
            }),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: todoList.length >= 2
            ? null
            : (() async {
                final text = await Navigator.pushNamed(context, '/addTwodo');
                if (text != "" && text != null) {
                  setState(() {
                    todoList.add(text.toString());
                    savePrefs();
                  });
                }
              }),
        backgroundColor: (todoList.length >= 2)
            ? const Color.fromARGB(255, 163, 161, 154)
            : Theme.of(context).primaryColor,
        child: const Icon(Icons.add, color: Color.fromARGB(230, 253, 252, 252)),
      ),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return StreamBuilder(
  //     stream: FirebaseAuth.instance.authStateChanges(),
  //     builder: ((context, snapshot) {
  //       if (snapshot.connectionState != ConnectionState.active) {
  //         print("Not Active");
  //         print("Not Active");
  //         return Center(child: CircularProgressIndicator());
  //       } else {
  //         print("a");
  //         print("b");
  //       }

  //       print(snapshot);

  //       if (snapshot.hasData) {
  //         print(snapshot.data);
  //         if (snapshot.data == null) {
  //           print("No");
  //           // return Home();
  //         }
  //         return Scaffold(
  //           appBar: AppBar(
  //             iconTheme:
  //                 IconThemeData(color: Color.fromARGB(230, 253, 252, 252)),
  //             title: Text(
  //               "TwoDoリスト",
  //               style: TextStyle(color: Color.fromARGB(230, 253, 252, 252)),
  //             ),
  //             actions: [HumanIcon()],
  //           ),
  //           drawer: Menu(
  //             text: "Todoリスト",
  //             route: "/todolist",
  //             instance: FirebaseAuth.instance,
  //             signOut: FirebaseAuth.instance.signOut(),
  //           ),
  //           body: SafeArea(
  //             child: ListView.builder(
  //                 itemCount: todoList.length,
  //                 itemBuilder: (context, index) {
  //                   return SizedBox(
  //                     height: (deviceHeight),
  //                     child: Card(
  //                       shape: RoundedRectangleBorder(
  //                           borderRadius: BorderRadius.circular(10)),
  //                       margin: EdgeInsets.fromLTRB(14, 20, 14, 14),
  //                       elevation: 10,
  //                       child: Center(
  //                         child: ListTile(
  //                           leading: Icon(
  //                             iconList[Random().nextInt(3)],
  //                             size: 34,
  //                             color: Color.fromARGB(255, 190, 222, 248),
  //                           ),
  //                           title: Text(
  //                             todoList[index],
  //                             style: TextStyle(
  //                                 fontSize: 30,
  //                                 color: Color.fromARGB(255, 66, 66, 61)),
  //                           ),
  //                           trailing: IconButton(
  //                             icon: Icon(
  //                               Icons.delete_forever_outlined,
  //                               size: 36,
  //                               color: Color.fromARGB(255, 240, 154, 148),
  //                             ),
  //                             onPressed: () {
  //                               setState(() {
  //                                 todoList.removeAt(index);
  //                                 savePrefs();
  //                               });
  //                             },
  //                           ),
  //                         ),
  //                       ),
  //                     ),
  //                   );
  //                 }),
  //           ),
  //           floatingActionButtonLocation:
  //               FloatingActionButtonLocation.centerFloat,
  //           floatingActionButton: FloatingActionButton(
  //             onPressed: todoList.length >= 2
  //                 ? null
  //                 : (() async {
  //                     final text =
  //                         await Navigator.pushNamed(context, '/addTwodo');
  //                     if (text != "" && text != null) {
  //                       setState(() {
  //                         todoList.add(text.toString());
  //                         savePrefs();
  //                       });
  //                     }
  //                   }),
  //             backgroundColor: (todoList.length >= 2)
  //                 ? Color.fromARGB(255, 163, 161, 154)
  //                 : Theme.of(context).primaryColor,
  //             child: Icon(Icons.add, color: Color.fromARGB(230, 253, 252, 252)),
  //           ),
  //         );
  //       }

  //       return Text("A");
  //     }),
  //   );
  // }
}

/// マイページ遷移用の人型アイコン
class HumanIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: (() {
        Navigator.pushNamed(context, "/mypage");
      }),
      icon: Lottie.asset(
        "assets/lottie/people.json",
        repeat: true,
      ),
      iconSize: 60,
    );
  }
}

/// ハンバーガーメニュー
class Menu extends StatelessWidget {
  final String text;
  final String route;
  final instance;

  const Menu({
    required this.text,
    required this.route,
    required this.instance,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Theme.of(context).secondaryHeaderColor,
        child: ListView(
          children: [
            SizedBox(
              height: 100,
              child: DrawerHeader(
                decoration:
                    BoxDecoration(color: Theme.of(context).primaryColor),
                child: const Text(
                  "メニュー",
                  style: TextStyle(
                    fontSize: 22,
                  ),
                ),
              ),
            ),
            Container(
              decoration: const BoxDecoration(border: Border(bottom: BorderSide())),
              child: ListTile(
                leading: const Icon(Icons.done_outline),
                title: Text(
                  text,
                  style: const TextStyle(fontSize: 16),
                ),
                onTap: () {
                  Navigator.pushReplacementNamed(context, route);
                },
              ),
            ),
            Container(
              decoration: const BoxDecoration(border: Border(bottom: BorderSide())),
              child: ListTile(
                leading: const Icon(Icons.logout),
                title: const Text(
                  'ログアウト',
                  style: TextStyle(fontSize: 16),
                ),
                onTap: () {
                  FirebaseAuth.instance.signOut();
                  print("LogOut!");
                  Navigator.pushReplacementNamed(context, '/');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
