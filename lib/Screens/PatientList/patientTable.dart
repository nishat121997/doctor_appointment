import 'package:flutter/material.dart';
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

  //DataTable dataBody() {
  // return DataTable(
  //   columns: [
  //     DataColumn(
  //         label: Text('Sl No'), numeric: false, tooltip: 'THIS IS Serial No'),
  //     DataColumn(label: Text('NAME'), numeric: false, tooltip: 'THIS NAME'),
  //     DataColumn(
  //         label: Text('GENDER'), numeric: false, tooltip: 'THIS IS Age'),
  //     DataColumn(label: Text('AGE'), numeric: false, tooltip: 'THIS IS age'),
  //   ],
  //   rows: users
  //       .map(
  //         (user) => DataRow(cells: [
  //           DataCell(
  //             Text(user.SerialNo),
  //           ),
  //           DataCell(
  //             Text(user.lastName),
  //           ),
  //           DataCell(
  //             Text(user.gender),
  //           ),
  //           DataCell(
  //             Text(user.age),
  //           ),
  //         ]),
  //       )
  //       .toList(),
  // );
  //}

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
              stream: _firestore.collection('patients').snapshots(),
              // ignore: missing_return
              builder: (context, snapshot) {
                if (!snapshot.hasData) return new Text('Loading...');
                return new DataTable(
                  columns: <DataColumn>[
                    new DataColumn(
                      label: Text('Sl no'),
                    ),
                    new DataColumn(label: Text('Name')),
                    new DataColumn(label: Text('Age')),
                    //new DataColumn(label: Text('gender')),
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
        DataCell(Text(documentSnapshot.data()['name'].toString())),
        DataCell(Text(documentSnapshot.data()['age'].toString())),
        //DataCell(Text(documentSnapshot.data()['gender'].toString())),
      ]);
    }).toList();
    return newList;
  }
}
