import 'package:flutter/material.dart';
import 'package:no_due_form/model/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Stream<List<AppUser>> getStudents() {
    return _db.collection('students').snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => AppUser.fromFirestore(doc)).toList());
  }
}

class TeacherDashboard extends StatelessWidget {
  final FirestoreService _firestoreService = FirestoreService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Teacher Dashboard')),
      body: StreamBuilder<List<AppUser>>(
        stream: _firestoreService.getStudents(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No student forms available'));
          }

          List<AppUser> students = snapshot.data!;

          return ListView.builder(
            itemCount: students.length,
            itemBuilder: (context, index) {
              AppUser student = students[index];
              return ListTile(
                title: Text(student.name),
                subtitle: Text('University Roll No: ${student.uniRollNo}'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          StudentDetailsPage(student: student),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}

class StudentDetailsPage extends StatelessWidget {
  final AppUser student;

  StudentDetailsPage({required this.student});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('${student.name} Details')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            ListTile(
              title: Text('Name'),
              subtitle: Text(student.name),
            ),
            ListTile(
              title: Text('Father Name'),
              subtitle: Text(student.fatherName),
            ),
            ListTile(
              title: Text('Joining Year'),
              subtitle: Text(student.joiningYear.toString()),
            ),
            ListTile(
              title: Text('Passing Year'),
              subtitle: Text(student.passingYear.toString()),
            ),
            ListTile(
              title: Text('Branch'),
              subtitle: Text(student.branch),
            ),
            ListTile(
              title: Text('College Roll No'),
              subtitle: Text(student.collegeRollNo.toString()),
            ),
            ListTile(
              title: Text('University Roll No'),
              subtitle: Text(student.uniRollNo.toString()),
            ),
            ListTile(
              title: Text('Address'),
              subtitle: Text(student.address),
            ),
            ListTile(
              title: Text('Student Category'),
              subtitle: Text(student.studentCategory),
            ),
            ListTile(
              title: Text('Phone No'),
              subtitle: Text(student.phoneNo),
            ),
            ListTile(
              title: Text('Email'),
              subtitle: Text(student.email),
            ),
          ],
        ),
      ),
    );
  }
}
