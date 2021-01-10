import 'package:flutter/material.dart';
import 'package:appointment_diary/Screens/PatientList/patientTable.dart';
import 'package:appointment_diary/Screens/DoctorScreen/Fee.dart';
import 'package:appointment_diary/Screens/EnterPatient/assistantDrawer.dart';
import 'package:appointment_diary/Screens/PatientList/PatientDetail.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HelloDScreen extends StatefulWidget {
  @override
  _HelloDScreenState createState() => _HelloDScreenState();
}

class _HelloDScreenState extends State<HelloDScreen> {
  DateTime _dateTime;
  final userId = FirebaseAuth.instance.currentUser.uid;
  final _firestore = Firestore.instance;
  final _auth = FirebaseAuth.instance;
  final collections = Firestore.instance.collection('patients');
  @override
  void initState() {
    super.initState();
  }

  var total;
  Future findTotalFee() async {
    int myTotal = 0;
    QuerySnapshot result =
        await FirebaseFirestore.instance.collection('patients').get();
    List<DocumentSnapshot> documents = result.docs;
    documents.forEach((doc) {
      print(doc.data());
      print(doc.data()['fee']);
      String tempo = doc.data()['fee'];
      print(tempo);
      if (tempo != null) {
        print('inside if');
        print(tempo);
        int total = int.parse('$tempo');
        myTotal = total + myTotal;
        print('total is $myTotal');
      }
    });
    this.total = myTotal;
    return this.total;
  }

  seeTodayPatient(DateTime dateTime) async {
    String date =
        '${dateTime.day}/${dateTime.month}/${dateTime.year}'.toString();
    print(date);
    QuerySnapshot result =
        await FirebaseFirestore.instance.collection('patients').get();
    List<DocumentSnapshot> documents = result.docs;
    documents.forEach((doc) {
      if (doc.data()['docid'] == userId) {
        if (doc.data()['date'] == date) {
          print('hello');
          print(doc.data());
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.blue[900],
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: Text(
          'HELLO DOCTOR',
          textAlign: TextAlign.center,
        ),
      ),
      drawer: AssistantDrawer(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: ListView(
          children: [
            Column(
              //mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  color: Colors.white,
                  child: Column(
                    children: <Widget>[
                      RaisedButton(
                        child: Text('Select a date'),
                        onPressed: () {
                          showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2000),
                                  lastDate: DateTime(3000))
                              .then((date) {
                            setState(() {
                              _dateTime = date;
                            });
                          });
                        },
                      ),
                      SizedBox(height: 10),
                      Text(
                        _dateTime == null
                            ? 'Nothing has been selected'
                            : '${_dateTime.day}/${_dateTime.month}/${_dateTime.year}',
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 18,
                ),
                Container(
                  width: 50,
                  //margin: EdgeInsets.fromLTRB(20, 550, 20, 60),
                  child: FlatButton(
                    minWidth: 50,
                    padding: EdgeInsets.symmetric(vertical: 16, horizontal: 50),
                    color: Colors.blue[700],
                    onPressed: () {
                      setState(() {
                        seeTodayPatient(_dateTime);
                        findTotalFee();
                      });
                    },
                    child: Text(
                      "GO",
                      style: TextStyle(
                          fontFamily: 'Source Sans Pro',
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  //alignment: Alignment.center,
                  //margin: EdgeInsets.fromLTRB(0, 120, 0, 0),
                  child: Text('Total fee: $total BDT',
                      style: TextStyle(
                          fontFamily: 'Source Sans Pro',
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold)),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    'Patients List',
                    style: TextStyle(
                        fontFamily: 'Source Sans Pro',
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  child: StreamBuilder(
                    stream: _firestore
                        .collection('patients')
                        .orderBy('sl no', descending: false)
                        .snapshots(),
                    // ignore: missing_return
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) return new Text('Loading...');
                      return new DataTable(
                        columns: <DataColumn>[
                          new DataColumn(
                            label: Text(
                              'Sl',
                              style: TextStyle(
                                  fontFamily: 'Source Sans Pro',
                                  //fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          new DataColumn(
                              label: Text(
                            'Name',
                            style: TextStyle(
                                fontFamily: 'Source Sans Pro',
                                //fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          )),
                          new DataColumn(
                              label: Text(
                            'Age',
                            style: TextStyle(
                                fontFamily: 'Source Sans Pro',
                                //fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          )),
                          new DataColumn(label: Text('')),
                        ],
                        rows: _createRows(snapshot.data),
                      );
                    },
                  ),
                ),
              ],
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
