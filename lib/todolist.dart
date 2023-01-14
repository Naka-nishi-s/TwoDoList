import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_renkei_test/twodolist.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TodoList extends StatefulWidget {
  const TodoList({super.key});

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  List<String> todoList = [];

  /// 端末に保存する処理
  Future savePrefs() async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setStringList("todo", todoList);
  }

  /// 端末から取り出す処理
  Future getPrefs() async {
    var prefs = await SharedPreferences.getInstance();
    if (prefs.getStringList("todo") == null) {
      return;
    } else {
      todoList = prefs.getStringList("todo")!;
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
    final instance = FirebaseAuth.instance;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Todoリスト",
          style: TextStyle(color: Color.fromARGB(230, 253, 252, 252)),
        ),
        iconTheme: const IconThemeData(color: Color.fromARGB(230, 253, 252, 252)),
        actions: [HumanIcon()],
      ),
      drawer: Menu(
        text: "TwoDoリスト",
        route: "/twodolist",
        instance: instance,
      ),
      body: SafeArea(
        child: ListView.builder(
            itemCount: todoList.length,
            itemBuilder: (context, index) {
              return Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                margin: const EdgeInsets.fromLTRB(14, 10, 14, 4),
                elevation: 6,
                child: ListTile(
                  title: Text(todoList[index]),
                  trailing: IconButton(
                    icon: const Icon(
                      Icons.delete_forever_outlined,
                      color: Color.fromARGB(255, 255, 193, 123),
                    ),
                    onPressed: () {
                      setState(() {
                        todoList.removeAt(index);
                        savePrefs();
                      });
                    },
                  ),
                ),
              );
            }),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final text = await Navigator.pushNamed(context, '/addTodo');
          if (text != "" && text != null) {
            setState(() {
              todoList.add(text.toString());
              savePrefs();
            });
          }
        },
        child: const Icon(Icons.add, color: Color.fromARGB(230, 253, 252, 252)),
      ),
    );
  }
}
