import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String _type = 'man';

  void _handleRadio(e) => setState(() {
        _type = e;
      });

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passController = TextEditingController();

  final instance = FirebaseAuth.instance;
  String err_msg = '';

  Future register() async {
    final name = nameController.text;
    final email = emailController.text;
    final pass = passController.text;

    try {
      await instance
          .createUserWithEmailAndPassword(
        email: email,
        password: pass,
      )
          .then(
        (UserCredential userCredential) async {
          await userCredential.user!.updateDisplayName(name);
          await userCredential.user!.updatePhotoURL(_type);

          // 確認メール送信
          await instance.currentUser!.sendEmailVerification();

          // ログイン画面に遷移
          Navigator.pushReplacementNamed(
            context,
            '/confirm',
          );
        },
      );
    } on FirebaseAuthException catch (e) {
      final String errCode = e.code;
      switch (errCode) {
        case 'email-already-in-use':
          err_msg = 'このemailは登録済です。\nログインをお試しください。';
          break;
        case 'invalid-email':
          err_msg = 'emailの形式に誤りがあります。\n正しい形式で入力してください。';
          break;
        case 'operation-not-allowed':
          err_msg = 'Firebaseでemail/passwordが無効になっています。\n管理者に連絡してください。';
          break;
        case 'weak-password':
          err_msg = 'パスワードが短すぎます。\n6文字以上で入力してください。';
          break;
      }

      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            '新規登録',
            style: TextStyle(color: Color.fromARGB(230, 253, 252, 252)),
          ),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: CircleAvatar(
                    backgroundImage: AssetImage('assets/images/$_type.png'),
                    radius: 40.0,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      children: [
                        const Text('Man'),
                        Radio(
                          activeColor: Colors.blue,
                          value: 'man',
                          groupValue: _type,
                          onChanged: _handleRadio,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Text('Woman'),
                        Radio(
                          activeColor: Colors.blue,
                          value: 'woman',
                          groupValue: _type,
                          onChanged: _handleRadio,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Text('Kids'),
                        Radio(
                          activeColor: Colors.blue,
                          value: 'kids',
                          groupValue: _type,
                          onChanged: _handleRadio,
                        ),
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: TextField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'ユーザー名',
                      hintText: 'ユーザー名を入力',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: TextField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'メールアドレス',
                      hintText: 'メアドを入力',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: TextField(
                    controller: passController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'パスワード',
                      hintText: 'パスワードを入力',
                    ),
                    obscureText: true,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: Text(
                    err_msg,
                    style: TextStyle(
                      color: Theme.of(context).errorColor,
                    ),
                  ),
                ),
                Container(
                  width: 120,
                  height: 44,
                  margin: const EdgeInsets.only(bottom: 28),
                  child: ElevatedButton(
                      onPressed: (() {
                        register();
                      }),
                      child: const Text(
                        '登   録',
                        style: TextStyle(
                            color: Color.fromARGB(230, 253, 252, 252),
                            fontSize: 16),
                      )),
                ),
                Rich(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// リッチテキスト
class Rich extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(style: Theme.of(context).textTheme.bodyText2, children: [
        const TextSpan(text: 'ログインは'),
        TextSpan(
          text: 'こちら',
          recognizer: TapGestureRecognizer()
            ..onTap = () {
              Navigator.pushReplacementNamed(context, '/login');
            },
          style: TextStyle(
            color: Theme.of(context).primaryColor,
          ),
        ),
        const TextSpan(text: 'から'),
      ]),
    );
  }
}
