import 'package:flutter/material.dart';
import 'package:appointment_diary/Screens/DoctorScreen/HelloDoctor.dart';
import 'package:appointment_diary/Screens/PatientList/PatientDetail.dart';
import 'package:appointment_diary/Screens/EnterPatient/table.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PatientTableScreen extends StatefulWidget {
  @override
  _PatientTableScreenState createState() => _PatientTableScreenState();
}

class _PatientTableScreenState extends State<PatientTableScreen> {
  final _firestore = Firestore.instance;
  final _auth = FirebaseAuth.instance;
  String sl;
  String name;
  String age;
  String gender;
  String myDoctor;

  @override
  void initState() {
    super.initState();
  }

  void messagesStream() async {
    await for (var snapshot in _firestore.collection('patients').snapshots())
      for (var patient in snapshot.documents) {
        print(patient.data());
      }
  }

  fetchDoctorId(String email) async {
    QuerySnapshot result =
        await FirebaseFirestore.instance.collection('Doctor').get();
    List<DocumentSnapshot> documents = result.docs;
    documents.forEach((doc) {
      if (doc.data()['Email'] == email) {
        print(doc.id);
        myDoctor = doc.id;
      }
    });
    return myDoctor;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: Center(
          child: Text(
            'Patient List',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: ListView(
          //mainAxisSize: MainAxisSize.min,
          //mainAxisAlignment: MainAxisAlignment.center,
          //scrollDirection: Axis.horizontal,

          children: <Widget>[
            StreamBuilder(
              stream: _firestore
                  .collection('Doctor')
                  .doc(myDoctor)
                  .collection('dd')
                  .doc()
                  .collection('patients')
                  .orderBy('sl no', descending: false)
                  .snapshots(),
              // ignore: missing_return
              builder: (context, snapshot) {
                if (!snapshot.hasData) return new Text('Loading...');
                return new DataTable(
                  columns: <DataColumn>[
                    new DataColumn(
                      label: Text('Sl'),
                    ),
                    new DataColumn(label: Text('Name')),
                    new DataColumn(label: Text('Age')),
                    new DataColumn(label: Text('')),
                  ],
                  rows: _createRows(snapshot.data),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  List<DataRow> _createRows(QuerySnapshot snapshot) {
    List<DataRow> newList =
        snapshot.docs.map((DocumentSnapshot documentSnapshot) {
      return new DataRow(cells: [
        DataCell(Text(documentSnapshot.data()['sl no'].toString())),
        DataCell(FlatButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return PatientInfoScreen();
                },
              ),
            );
          },
          child: (Text(documentSnapshot.data()['name'].toString())),
        )),
        DataCell(Text(documentSnapshot.data()['age'].toString())),
        // DataCell(FlatButton(
        //   onPressed: () {
        //     Navigator.push(
        //       context,
        //       MaterialPageRoute(
        //         builder: (context) {
        //           return HelloDScreen();
        //         },
        //       ),
        //     );
        //   },
        //   child: (Text(documentSnapshot.data()['age'].toString())),
        // )),
        DataCell(
          IconButton(
            icon: Icon(
              Icons.delete,
              color: Colors.red,
            ),
            onPressed: () {
              _firestore
                  .collection('patients')
                  .document(documentSnapshot.documentID)
                  .delete();
            },
          ),
        )

        //DataCell(Text(documentSnapshot.data()['gender'].toString())),
      ]);
    }).toList();
    return newList;
  }
}
