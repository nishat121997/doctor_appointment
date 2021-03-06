import 'package:flutter/material.dart';
import 'package:appointment_diary/Screens/PatientList/patientTable.dart';
import 'package:appointment_diary/Screens/EnterPatient/enterPatient.dart';
import 'package:appointment_diary/Screens/Login/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AssistantDrawer extends StatefulWidget {
  @override
  _AssistantDrawerState createState() => _AssistantDrawerState();
}

class _AssistantDrawerState extends State<AssistantDrawer> {
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 50,
            ),
            ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return PatientTableScreen();
                    },
                  ),
                );
              },
              title: Text(
                'See Patient List',
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.blue[900],
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return EnterPatient();
                    },
                  ),
                );
              },
              title: Text(
                'Add to the List',
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.blue[900],
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 50,
            ),
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
