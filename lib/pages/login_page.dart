import 'package:firebase_auth/firebase_auth.dart';
import './home_page.dart';
import '../controllers/user_controller.dart';
import 'signup_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String email = "";
  String senha = "";

  // Estados
  String error = "";

  late final userController = Provider.of<UserController>(
    context,
    listen: false,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Column(
        children: [
          Image.asset("logo2.jpeg"),
          Form(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Email'),
                    onChanged: (texto) => email = texto,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Senha'),
                    obscureText: true,
                    onChanged: (texto) => senha = texto,
                  ),
                  SizedBox(height: 12),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFFF2622E),
                      minimumSize: Size(150, 50),
                    ),
                    onPressed: () async {
                      try {
                        await userController.login(email, senha);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomePage()));
                      } on FirebaseAuthException catch (e) {
                        var msg = "";

                        if (e.code == "wrong-password") {
                          msg = "A senha est?? incorreta";
                        } else if (e.code == "invalid-email") {
                          msg = "Email inv??lido";
                        } else {
                          msg = "Ocorreu um erro";
                        }

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(msg),
                          ),
                        );
                      }
                    },
                    child: Text("Login"),
                  ),
                  SizedBox(height: 12),
                  OutlinedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SignupPage(),
                        ),
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(
                        width: 2.0,
                        color: Color(0xFFF2622E),
                        style: BorderStyle.solid,
                      ),
                    ),
                    child: Text("Criar conta",
                        style: TextStyle(color: Color(0xFFF2622E))),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
