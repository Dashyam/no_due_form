import 'package:flutter/material.dart';
import 'package:no_due_form/model/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfilePage extends StatefulWidget {
  final String userId;

  ProfilePage({required this.userId});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late Future<AppUser> _userFuture;

  Future<AppUser> _fetchUserData() async {
    DocumentSnapshot doc = await FirebaseFirestore.instance
        .collection('students')
        .doc(widget.userId)
        .get();
    return AppUser.fromFirestore(doc);
  }

  @override
  void initState() {
    super.initState();
    _userFuture = _fetchUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Profile')),
      body: FutureBuilder<AppUser>(
        future: _userFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return Center(child: Text('User not found'));
          } else {
            AppUser user = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                children: [
                  ListTile(
                    title: Text('Name'),
                    subtitle: Text(user.name),
                  ),
                  ListTile(
                    title: Text('Father Name'),
                    subtitle: Text(user.fatherName),
                  ),
                  ListTile(
                    title: Text('Joining Year'),
                    subtitle: Text(user.joiningYear.toString()),
                  ),
                  ListTile(
                    title: Text('Passing Year'),
                    subtitle: Text(user.passingYear.toString()),
                  ),
                  ListTile(
                    title: Text('Branch'),
                    subtitle: Text(user.branch),
                  ),
                  ListTile(
                    title: Text('College Roll No'),
                    subtitle: Text(user.collegeRollNo.toString()),
                  ),
                  ListTile(
                    title: Text('University Roll No'),
                    subtitle: Text(user.uniRollNo.toString()),
                  ),
                  ListTile(
                    title: Text('Address'),
                    subtitle: Text(user.address),
                  ),
                  ListTile(
                    title: Text('Student Category'),
                    subtitle: Text(user.studentCategory),
                  ),
                  ListTile(
                    title: Text('Phone No'),
                    subtitle: Text(user.phoneNo),
                  ),
                  ListTile(
                    title: Text('Email'),
                    subtitle: Text(user.email),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
