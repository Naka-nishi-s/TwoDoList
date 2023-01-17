import 'dart:math';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TwodoList extends StatefulWidget {
  const TwodoList({super.key});

  @override
  State<TwodoList> createState() => _TwodoListState();
}

class _TwodoListState extends State<TwodoList> {
  List<String> todoList = [];

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
  }

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height / 3;

    return Scaffold(
      appBar: AppBar(
        iconTheme:
            const IconThemeData(color: Color.fromARGB(230, 253, 252, 252)),
        title: const Text(
          "TwoDoリスト",
          style: TextStyle(color: Color.fromARGB(230, 253, 252, 252)),
        ),
      ),
      drawer: const Menu(
        text: "Todoリスト",
        route: "/todolist",
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
}

/// ハンバーガーメニュー
class Menu extends StatelessWidget {
  final String text;
  final String route;

  const Menu({
    required String this.text,
    required String this.route,
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
              decoration:
                  const BoxDecoration(border: Border(bottom: BorderSide())),
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
          ],
        ),
      ),
    );
  }
}
