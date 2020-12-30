import 'package:flutter/material.dart';
import 'package:appointment_diary/Screens/EnterPatient/enterPatient.dart';
import 'package:appointment_diary/Screens/PatientList/patientTable.dart';
import 'package:appointment_diary/Screens/EnterPatient/assistantDrawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SuccessScreen extends StatefulWidget {
  @override
  _SuccessScreenState createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen> {
  final _firestore = Firestore.instance;
  final _auth = FirebaseAuth.instance;
  @override
  void initState() {
    super.initState();
  }

  // void getPatientDetail() async {
  //   final patients = await _firestore.collection('patients').getDocuments();
  //   for (var patient in patients.documents) {
  //     print(patient.data());
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: Text(''),
      ),
      drawer: AssistantDrawer(),
      body: Container(
        width: double.infinity,
        height: size.height,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Card(
                color: Colors.blue[400],
                margin: EdgeInsets.symmetric(vertical: 40.0, horizontal: 25.0),
                child: Padding(
                  padding: EdgeInsets.all(100),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          'Patient successfully added to the list!!!',
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Source Sans Pro',
                            fontWeight: FontWeight.bold,
                            fontSize: 30.0,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              FlatButton(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 60),
                color: Colors.blue[700],
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return PatientTableScreen();
                      },
                    ),
                  );
                },
                child: Text(
                  "See Patient list",
                  style: TextStyle(
                      fontFamily: 'Source Sans Pro',
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              FlatButton(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 60),
                color: Colors.blue[700],
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return EnterPatient();
                      },
                    ),
                  );
                },
                child: Text(
                  "Add to the list",
                  style: TextStyle(
                      fontFamily: 'Source Sans Pro',
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ]),
      ),
    );
  }
}
