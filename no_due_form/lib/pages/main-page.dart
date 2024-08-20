import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:no_due_form/model/user.dart';
import 'package:no_due_form/pages/profile-page.dart';
import 'package:no_due_form/pages/status-page.dart';
import 'package:no_due_form/pages/student-form-page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:no_due_form/util/util.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'No Due Form',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainPage(UserID: Util.UID), // Replace with actual UserID
    );
  }
}

class MainPage extends StatefulWidget {
  final String UserID;

  MainPage({required this.UserID});

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  late List<Widget> _widgetOptions;

  @override
  void initState() {
    super.initState();
    _widgetOptions = <Widget>[
      StudentFormPage(),
      ProfilePage(userId: widget.UserID),
      StatusPage(userId: widget.UserID),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('No Due Form'),
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment),
            label: 'No Due Form',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.check_circle),
            label: 'Status',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }
}
