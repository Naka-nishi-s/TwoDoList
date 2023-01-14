import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Mypage extends StatefulWidget {
  const Mypage({super.key});

  @override
  State<Mypage> createState() => _MypageState();
}

class _MypageState extends State<Mypage> {
  var user;
  String userName = "";
  String userMail = "";

  @override
  void initState() {
    super.initState();
    getUser();
  }

  Future getUser() async {
    user = FirebaseAuth.instance.currentUser;
    userName = await user.displayName;
    userMail = await user.email;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController(text: userName);
    final mailController = TextEditingController(text: userMail);

    /// ユーザー名更新
    void updateData() {
      if (nameController.text != "") {
        user.updateDisplayName(nameController.text);
        Navigator.pushNamed(context, '/twodolist');
      }
    }

    /// ユーザー削除
    void deleteData() async {
      await user.delete();
      Navigator.pushNamedAndRemoveUntil(
          context, "/", (Route<dynamic> route) => false);
    }

    deleteUser() {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("ユーザー削除"),
          content: const Text("本当に削除しますか？"),
          actions: [
            TextButton(
              onPressed: (() {
                Navigator.of(context).pop();
              }),
              child: const Text(
                "閉じる",
                style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
              ),
            ),
            TextButton(
              onPressed: (() {
                deleteData();
              }),
              child: const Text(
                "削除",
                style: TextStyle(color: Color.fromARGB(255, 240, 154, 148)),
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
          iconTheme: const IconThemeData(color: Color.fromARGB(230, 253, 252, 252)),
          title: const Text(
            'マイページ',
            style: TextStyle(color: Color.fromARGB(230, 253, 252, 252)),
          )),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(10, 20, 20, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Expanded(
                    flex: 1,
                    child: Text(
                      "ユーザー名",
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      margin: const EdgeInsets.only(left: 10),
                      child: TextField(
                        textAlign: TextAlign.center,
                        controller: nameController,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(10, 20, 20, 40),
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Expanded(
                    flex: 1,
                    child: Text(
                      "メールアドレス",
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      margin: const EdgeInsets.only(left: 10),
                      child: TextField(
                        enabled: false,
                        textAlign: TextAlign.center,
                        controller: mailController,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 120,
              height: 40,
              margin: const EdgeInsets.only(bottom: 20),
              child: ElevatedButton(
                onPressed: (() {
                  updateData();
                }),
                child: const Text(
                  'ユーザー更新',
                  style: TextStyle(color: Color.fromARGB(230, 253, 252, 252)),
                ),
              ),
            ),
            SizedBox(
              width: 120,
              height: 40,
              child: OutlinedButton(
                onPressed: () async {
                  deleteUser();

                  // deleteData();
                },
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(
                      width: 2, color: Color.fromARGB(255, 240, 154, 148)),
                ),
                child: const Text(
                  'ユーザー削除',
                  style: TextStyle(color: Color.fromARGB(255, 240, 154, 148)),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}



    // final nameController = TextEditingController(text: user.displayname);

      // body: SafeArea(
      //   child: ListView(
      //     children: [
      //       Card(
      //         child: ListTile(
      //           title: Text('ユーザー名: ${user.displayName}'),
      //         ),
      //       ),
      //       Card(
      //         child: ListTile(
      //           title: Text('メールアドレス: ${user.email}'),
      //         ),
      //       ),
      //       Card(
      //         child: ListTile(
      //           title: Text('ユーザー名: ${user.displayName}'),
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
