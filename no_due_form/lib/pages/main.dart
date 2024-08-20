import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:no_due_form/firebase_options.dart';
import 'package:no_due_form/pages/login-page.dart';
import 'package:no_due_form/pages/no-due-form.dart';
import 'package:no_due_form/pages/no-due-request-page.dart';
import 'package:no_due_form/pages/register-page.dart';
import 'package:no_due_form/pages/splash.dart';
import 'package:no_due_form/pages/teacher-dashboard.dart';
import 'package:no_due_form/pages/main-page.dart';
import 'package:no_due_form/util/util.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "NO DUE FORM",
      theme: ThemeData(fontFamily: 'Montserrat'),
      initialRoute: "/",
      routes: {
        "/": (context) => const Splash(),
        "/login": (context) => const LoginPage(),
        "/register": (context) => const RegisterPage(),
        "/mainPage": (context) => MainPage(
              UserID: Util.UID,
            ),
        "/teacherDashboard": (context) => TeacherDashboard(),
        "/noduepage": (context) => NoDueRequestPage(userId: Util.UID)
      },
    );
  }
}
