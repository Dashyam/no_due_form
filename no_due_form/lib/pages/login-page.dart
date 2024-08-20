import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  login() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (email.isNotEmpty && password.isNotEmpty) {
      try {
        final credential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);
        print("User Sign in with : Email: $email | Password: $password");
        print("Credential: $credential");
        print("UID: ${credential.user!.uid}");

        Navigator.of(context).pushReplacementNamed("/noduepage");
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          print("No user found for that email");
        } else if (e.code == 'wrong-password') {
          print("wrong password");
        }
      } catch (e) {
        print(e);
      }
      print("Details email: $email | password: $password");
    }
  }

  styleTextField(String hintText) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: const TextStyle(color: Colors.black),
      contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.blue, width: 2)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text(
          "LOGIN",
          style: TextStyle(color: Colors.black),
        )),
        body: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [Color.fromARGB(255, 112, 173, 223), Colors.white],
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft)),
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "WELCOME",
                style: TextStyle(color: Colors.black, fontSize: 24),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: emailController,
                decoration: styleTextField("Email"),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: passwordController,
                decoration: styleTextField("Password"),
                obscureText: true,
              ),
              const SizedBox(height: 15),
              ElevatedButton(
                onPressed: () {
                  login();
                },
                child: const Text(
                  "LOGIN",
                  style: TextStyle(color: Colors.black),
                ),
              ),
              const SizedBox(height: 12),
              TextButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, "/register");
                },
                child: const Text(
                  "New User? Register Here",
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
        ));
  }
}
