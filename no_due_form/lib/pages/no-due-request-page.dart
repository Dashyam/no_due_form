import 'package:flutter/material.dart';
import 'package:no_due_form/model/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NoDueRequestPage extends StatefulWidget {
  final String userId;

  NoDueRequestPage({required this.userId});

  @override
  _NoDueRequestPageState createState() => _NoDueRequestPageState();
}

class _NoDueRequestPageState extends State<NoDueRequestPage> {
  late Future<AppUser> _userFuture;

  Future<AppUser> _fetchUserData() async {
    // Fetch user data from Firestore
    DocumentSnapshot doc = await FirebaseFirestore.instance
        .collection('students')
        .doc(widget.userId)
        .get();
    return AppUser.fromFirestore(doc);
  }

  Future<void> _updateNoDueStatus(String department, bool status) async {
    AppUser user = await _userFuture;
    user.noDueStatus[department] = status;
    await FirebaseFirestore.instance
        .collection('students')
        .doc(widget.userId)
        .update({
      'noDueStatus': user.noDueStatus,
    });
    setState(() {
      _userFuture = Future.value(user);
    });
  }

  @override
  void initState() {
    super.initState();
    _userFuture = _fetchUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('No Due Request')),
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
            return ListView(
              children: user.noDueStatus.keys.map((department) {
                return ListTile(
                  title: Text(department),
                  trailing: Checkbox(
                    value: user.noDueStatus[department],
                    onChanged: (bool? value) {
                      _updateNoDueStatus(department, value!);
                    },
                  ),
                );
              }).toList(),
            );
          }
        },
      ),
    );
  }
}
