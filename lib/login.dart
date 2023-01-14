import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final emailController = TextEditingController();
  final passController = TextEditingController();

  final instance = FirebaseAuth.instance;
  var err_msg = '';

  Future login() async {
    final email = emailController.text;
    final pass = passController.text;

    try {
      await instance
          .signInWithEmailAndPassword(email: email, password: pass)
          .then((UserCredential userCredential) async {
        final ok = instance.currentUser!.emailVerified;

        // メール認証終わってなかったらサインアウト
        if (!ok) {
          instance.signOut();
          setState(() {
            err_msg = 'メール認証が終わっていません。';
          });
        } else {
          // 問題無かったらtwodolistに遷移
          Navigator.pushReplacementNamed(context, '/twodolist');
        }
      });
    } on FirebaseAuthException catch (e) {
      final errCode = e.code;

      switch (errCode) {
        case 'invalid-email':
          err_msg = 'emailかpasswordに誤りがあります';
          break;
        case 'user-disabled':
          err_msg = 'そのemailは無効化されています';
          break;
        case 'user-not-found':
          err_msg = 'このメールアドレスは登録されていません';
          break;
        case 'wrong-password':
          err_msg = 'passwordが違います';
          break;
        case 'too-many-requests':
          err_msg = 'ログインの試行回数が制限を超えました。';
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
            'ログイン',
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
                Container(
                  height: 80,
                  margin: const EdgeInsets.only(bottom: 36),
                  child: Image.asset("assets/images/login.png"),
                ),
                InputEmail(emailController: emailController),
                InputPassword(passController: passController),
                Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: ErrorText(err_msg: err_msg),
                ),
                Container(
                  width: 120,
                  height: 44,
                  margin: const EdgeInsets.only(bottom: 28),
                  child: ElevatedButton(
                    onPressed: (() {
                      login();
                    }),
                    child: const Text(
                      'ログイン',
                      style: TextStyle(
                          color: Color.fromARGB(230, 253, 252, 252),
                          fontSize: 16),
                    ),
                  ),
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
      text: TextSpan(
        style: Theme.of(context).textTheme.bodyText2,
        children: [
          const TextSpan(text: '登録は'),
          TextSpan(
            text: 'こちら',
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                Navigator.pushReplacementNamed(context, '/register');
              },
            style: TextStyle(
              color: Theme.of(context).primaryColor,
            ),
          ),
          const TextSpan(text: 'から'),
        ],
      ),
    );
  }
}

/// emeilのインプット
class InputEmail extends StatelessWidget {
  final emailController;

  const InputEmail({this.emailController});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
      child: TextField(
        controller: emailController,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'メールアドレス',
          hintText: 'メアドを入力',
        ),
      ),
    );
  }
}

/// パスワードのインプット
class InputPassword extends StatelessWidget {
  final passController;
  const InputPassword({this.passController});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
      child: TextField(
        obscureText: true,
        controller: passController,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'パスワード',
          hintText: 'パスワードを入力',
        ),
      ),
    );
  }
}

/// エラーメッセージがあれば表示
class ErrorText extends StatelessWidget {
  final String err_msg;
  const ErrorText({required this.err_msg});

  @override
  Widget build(BuildContext context) {
    return (err_msg != '')
        ? Text(
            err_msg,
            style: TextStyle(
              color: Theme.of(context).errorColor,
            ),
          )
        : const Text('');
  }
}

/// 登録ボタン
class NavigateRegisterButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: (() {
          Navigator.pushReplacementNamed(context, '/register');
        }),
        child: const Text('登録画面へ'));
  }
}
