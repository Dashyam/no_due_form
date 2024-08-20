import 'package:cloud_firestore/cloud_firestore.dart';

class AppUser {
  String name;
  String fatherName;
  int joiningYear;
  int passingYear;
  String branch;
  int collegeRollNo;
  int uniRollNo;
  String address;
  String studentCategory;
  String phoneNo;
  String email;
  Map<String, bool> noDueStatus;

  AppUser({
    required this.name,
    required this.fatherName,
    required this.joiningYear,
    required this.passingYear,
    required this.branch,
    required this.collegeRollNo,
    required this.uniRollNo,
    required this.address,
    required this.studentCategory,
    required this.phoneNo,
    required this.email,
    required this.noDueStatus,
  });

  // Initialize an empty AppUser with all departments set to false for no dues
  static AppUser getEmptyAppUser() {
    return AppUser(
      name: '',
      fatherName: '',
      joiningYear: 0,
      passingYear: 0,
      branch: '',
      collegeRollNo: 0,
      uniRollNo: 0,
      address: '',
      studentCategory: '',
      phoneNo: '',
      email: '',
      noDueStatus: {
        'HOD_Dept': false,
        'Dept_Library': false,
        'Advisor': false,
        'Dean_Hostels': false,
        'Secy_SAF': false,
        'Uni_Extn_Lib': false,
        'College_Library': false,
        'Care_Taker': false,
        'TPO': false,
        'Mess_Accountant': false,
        'Record_Keeper': false,
        'Security_Officer': false,
        'College_Acctt': false,
        'Fee_Clerk': false,
        'Academic_Clerk': false,
      },
    );
  }

  // Convert Firestore document to AppUser
  factory AppUser.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map;
    return AppUser(
      name: data['name'] ?? '',
      fatherName: data['fatherName'] ?? '',
      joiningYear: data['joiningYear'] ?? 0,
      passingYear: data['passingYear'] ?? 0,
      branch: data['branch'] ?? '',
      collegeRollNo: data['collegeRollNo'] ?? 0,
      uniRollNo: data['uniRollNo'] ?? 0,
      address: data['address'] ?? '',
      studentCategory: data['studentCategory'] ?? '',
      phoneNo: data['phoneNo'] ?? '',
      email: data['email'] ?? '',
      noDueStatus: Map<String, bool>.from(data['noDueStatus'] ?? {}),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'fatherName': fatherName,
      'joiningYear': joiningYear,
      'passingYear': passingYear,
      'branch': branch,
      'collegeRollNo': collegeRollNo,
      'uniRollNo': uniRollNo,
      'address': address,
      'studentCategory': studentCategory,
      'phoneNo': phoneNo,
      'email': email,
      'noDueStatus': noDueStatus,
    };
  }
}
