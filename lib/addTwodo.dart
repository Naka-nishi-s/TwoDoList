import 'package:flutter/material.dart';

class AddTwodo extends StatelessWidget {
  AddTwodo({super.key});
  final addcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Color.fromARGB(230, 253, 252, 252)),
        title: const Text(
          'リストに追加',
          style: TextStyle(color: Color.fromARGB(230, 253, 252, 252)),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: RichText(
                    text: TextSpan(
                        style: Theme.of(context).textTheme.bodyText2,
                        children: [
                      const TextSpan(text: '今日は'),
                      TextSpan(
                          text: '何',
                          style: TextStyle(
                            fontSize: 18,
                            color: Theme.of(context).primaryColor,
                          )),
                      const TextSpan(text: 'する??'),
                    ])),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                child: TextField(
                  controller: addcontroller,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: (() async {
                  final String todo = addcontroller.text;
                  Navigator.of(context).pop(todo);
                }),
                child: const Text(
                  '追 加',
                  style: TextStyle(color: Color.fromARGB(230, 253, 252, 252)),
                ),
              ),
              TextButton(
                onPressed: (() {
                  Navigator.of(context).pop();
                }),
                child: const Text('キャンセル'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
