import 'package:flutter/material.dart';
import 'package:no_due_form/model/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:no_due_form/pages/teacher-dashboard.dart';

class StudentFormPage extends StatefulWidget {
  @override
  _StudentFormPageState createState() => _StudentFormPageState();
}

class _StudentFormPageState extends State<StudentFormPage> {
  final _formKey = GlobalKey<FormState>();
  AppUser user = AppUser.getEmptyAppUser();

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      // Save the user data to Firestore
      await FirebaseFirestore.instance.collection('students').add(user.toMap());
      // Navigate to Teacher Dashboard
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => TeacherDashboard()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Student Form')),
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color.fromARGB(255, 112, 173, 223), Colors.white],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                const SizedBox(height: 20),
                TextFormField(
                  decoration:
                      const InputDecoration(labelText: "Enter your name"),
                  onSaved: (value) {
                    user.name = value!;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(
                      labelText: "Enter your father's name"),
                  onSaved: (value) {
                    user.fatherName = value!;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(
                      labelText: "Enter your joining year"),
                  keyboardType: TextInputType.number,
                  onSaved: (value) {
                    user.joiningYear = int.parse(value!);
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(
                      labelText: "Enter your passing year"),
                  keyboardType: TextInputType.number,
                  onSaved: (value) {
                    user.passingYear = int.parse(value!);
                  },
                ),
                DropdownButtonFormField<String>(
                  value: user.branch.isEmpty ? null : user.branch,
                  decoration: const InputDecoration(labelText: 'Select Branch'),
                  items: [
                    'Information Technology',
                    'Civil Engineering',
                    'Electrical Engineering',
                    'Mechanical & Production Engineering',
                    'Electronics & Communications Engineering',
                    'Computer Science & Engineering'
                  ]
                      .map((label) => DropdownMenuItem(
                            value: label,
                            child: Text(label),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      user.branch = value!;
                    });
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(
                      labelText: "Enter your college roll number"),
                  keyboardType: TextInputType.number,
                  onSaved: (value) {
                    user.collegeRollNo = int.parse(value!);
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(
                      labelText: "Enter your university roll number"),
                  keyboardType: TextInputType.number,
                  onSaved: (value) {
                    user.uniRollNo = int.parse(value!);
                  },
                ),
                TextFormField(
                  decoration:
                      const InputDecoration(labelText: "Enter your address"),
                  onSaved: (value) {
                    user.address = value!;
                  },
                ),
                DropdownButtonFormField<String>(
                  value: user.studentCategory.isEmpty
                      ? null
                      : user.studentCategory,
                  decoration:
                      const InputDecoration(labelText: 'Student Category'),
                  items: ['SC Eligible', 'Not Eligible']
                      .map((label) => DropdownMenuItem(
                            value: label,
                            child: Text(label),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      user.studentCategory = value!;
                    });
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(
                      labelText: "Enter your phone number"),
                  keyboardType: TextInputType.phone,
                  onSaved: (value) {
                    user.phoneNo = value!;
                  },
                ),
                TextFormField(
                  decoration:
                      const InputDecoration(labelText: "Enter your email"),
                  keyboardType: TextInputType.emailAddress,
                  onSaved: (value) {
                    user.email = value!;
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _submitForm,
                  child: const Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
