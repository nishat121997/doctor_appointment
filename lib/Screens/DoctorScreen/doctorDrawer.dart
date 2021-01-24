import 'package:flutter/material.dart';
import 'package:appointment_diary/Screens/PatientList/patientTable.dart';
import 'package:appointment_diary/Screens/Login/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DoctorDrawer extends StatefulWidget {
  @override
  _DoctorDrawerState createState() => _DoctorDrawerState();
}

class _DoctorDrawerState extends State<DoctorDrawer> {
  final userId = FirebaseAuth.instance.currentUser.uid;
  final _firestore = Firestore.instance;
  final _auth = FirebaseAuth.instance;
  final collections = Firestore.instance.collection('patients');
  String myDoctor;
  String docEmail;
  String docName;
  //String dateId;
  User loggedInUser;
  @override
  void initState() {
    super.initState();
    getCurrentUser();
    //fetchDoctorId(docEmail);
  }

  getCurrentUser() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        loggedInUser = user;

        //print(loggedInUser.uid);
        //print(loggedInUser.email);
      }
    } catch (e) {
      print('Fail');
    }
  }

  // fetchDoctorId(String email) async {
  //   QuerySnapshot result =
  //       await FirebaseFirestore.instance.collection('Doctor').get();
  //   List<DocumentSnapshot> documents = result.docs;
  //   documents.forEach((doc) {
  //     if (doc.data()['Email'] == email) {
  //       //print(doc.id);
  //       //print(doc.data()['User Name']);
  //       myDoctor = doc.id;
  //       docEmail = email;
  //       docName = doc.data()['User Name'];
  //     }
  //     //print('$docEmail');
  //   });
  //   return Text('$docName');
  // }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 30,
            ),
            Container(
              child: Image.asset(
                "images/p2.png",
                width: 80,
                height: 50,
              ),
            ),
            Container(
              child: Text(loggedInUser.email),
            ),
            SizedBox(height: 50),
            Container(
              alignment: Alignment.center,
              child: Center(
                child: SizedBox(
                  height: 50,
                  width: 150,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    elevation: 10,
                    color: Colors.blue[900],
                    splashColor: Colors.white,
                    child: Text(
                      'Sign Out',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: () {
                      _auth.signOut();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return LoginScreen();
                          },
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
