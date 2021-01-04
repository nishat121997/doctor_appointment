import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PatientInfoScreen extends StatefulWidget {
  @override
  _PatientInfoScreenState createState() => _PatientInfoScreenState();
}

class _PatientInfoScreenState extends State<PatientInfoScreen> {
  final _firestore = Firestore.instance;
  final _auth = FirebaseAuth.instance;
  FirebaseUser user;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: Text('Patient Information'),
      ),
      body: StreamBuilder(
          stream: Firestore.instance.collection('patients').snapshots(),
          builder:
              // ignore: missing_return
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView(
                children: snapshot.data.documents
                    .map((DocumentSnapshot documentSnapshot) {
              return Center(
                child: Card(
                  //width: MediaQuery.of(context).size.width / 1.2,
                  //height: MediaQuery.of(context).size.height / 6,
                  child: Column(
                    children: [
                      Text(
                          'Date:' +
                              (documentSnapshot.data()['date'].toString()),
                          style: TextStyle(
                              fontFamily: 'Source Sans Pro',
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.bold)),
                      Text(
                          'time:' +
                              (documentSnapshot.data()['time'].toString()),
                          style: TextStyle(
                              fontFamily: 'Source Sans Pro',
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.bold)),
                      Text(
                          'Serial:' +
                              (documentSnapshot.data()['sl no'].toString()),
                          style: TextStyle(
                              fontFamily: 'Source Sans Pro',
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.bold)),
                      Text(
                          'Name:' +
                              (documentSnapshot.data()['name'].toString()),
                          style: TextStyle(
                              fontFamily: 'Source Sans Pro',
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.bold)),
                      Text('Age:' + (documentSnapshot.data()['age'].toString()),
                          style: TextStyle(
                              fontFamily: 'Source Sans Pro',
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.bold)),
                      Text(
                          'Gender:' +
                              (documentSnapshot.data()['gender'].toString()),
                          style: TextStyle(
                              fontFamily: 'Source Sans Pro',
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.bold)),
                      Text(
                          'Purpose:' +
                              (documentSnapshot.data()['purpose'].toString()),
                          style: TextStyle(
                              fontFamily: 'Source Sans Pro',
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.bold)),
                      Text('Fee:' + (documentSnapshot.data()['fee'].toString()),
                          style: TextStyle(
                              fontFamily: 'Source Sans Pro',
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.bold)),
                      Text(
                          'Phone No:' +
                              (documentSnapshot.data()['phone'].toString()),
                          style: TextStyle(
                              fontFamily: 'Source Sans Pro',
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              );
            }).toList());
          }),
    );
  }
}
