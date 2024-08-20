import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:no_due_form/util/util.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  register() async {
    print("~~~~");
    String name = nameController.text.trim();
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    print("$name");

    if (email.isNotEmpty && password.isNotEmpty) {
      print("jj");
      try {
        // 1. Create user in Firebase Authentication Module
        UserCredential credential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        // 2. Get the UID of the newly created user
        String uid = credential.user!.uid;
        Util.UID = uid;

        print("User Created with : Email: $email | Password: $password");
        print("Credential: $credential");
        print("UID: $uid");

        // 3. Create the data as Map, which you wish to store in database
        Map<String, dynamic> userData = {
          "name": name,
          "email": email,
          "createdOn": DateTime.now()
        };

        // 4. Use Firebase Firestore to create a new Document in the users collection
        await FirebaseFirestore.instance
            .collection("users")
            .doc(uid)
            .set(userData);

        // 5. Navigate to the teacherDashboard screen
        Navigator.of(context).pushReplacementNamed("/mainPage");
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          print('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          print('The account already exists for that email.');
        }
      } catch (e) {
        print(e);
      }
    } else {
      print("Missing Details: Email: $email | Password: $password");
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
          "REGISTER",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color.fromARGB(255, 112, 173, 223), Colors.white],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
          ),
        ),
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
              controller: nameController,
              decoration: styleTextField("Name"),
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
              onPressed: register,
              child: const Text(
                "REGISTER",
                style: TextStyle(color: Colors.black),
              ),
            ),
            const SizedBox(height: 12),
            TextButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, "/login");
              },
              child: const Text(
                "Existing User? Login Here",
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
