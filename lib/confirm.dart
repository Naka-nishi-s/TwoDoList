import 'package:flutter/material.dart';

class Confirm extends StatelessWidget {
  const Confirm({super.key});
  final String confirmText =
      "ご入力いただいたメールアドレスに\n確認メールを送付いたしました。\n\nメール内リンクをタップして\n認証をお願いいたします。\n\n認証後、以下からログインしてください。";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 60,
              margin: const EdgeInsets.only(bottom: 30),
              child: Image.asset("assets/images/mail.png"),
            ),
            Container(
                margin: const EdgeInsets.only(bottom: 32),
                child: Text(
                  confirmText,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 16),
                )),
            SizedBox(
              width: 120,
              height: 44,
              child: ElevatedButton(
                  onPressed: (() {
                    Navigator.pushReplacementNamed(context, "/login");
                  }),
                  child: const Text(
                    "ログイン",
                    style: TextStyle(
                        color: Color.fromARGB(230, 253, 252, 252),
                        fontSize: 18),
                  )),
            )
          ],
        ),
      )),
    );
  }
}
