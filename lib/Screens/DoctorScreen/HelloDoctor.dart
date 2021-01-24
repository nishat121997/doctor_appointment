import 'package:flutter/material.dart';
import 'package:appointment_diary/Screens/DoctorScreen/doctorDrawer.dart';
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
  String myDoctor;
  //String dateId;
  User loggedInUser;
  String todayDate;
  bool approveCondition = false;
  @override
  void initState() {
    super.initState();
    getCurrentUser();
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

  var total;
  Future findTotalFee(String today) async {
    int myTotal = 0;

    QuerySnapshot result = await FirebaseFirestore.instance
        .collection('Doctor')
        .doc(loggedInUser.uid)
        .collection('patients')
        .get();
    List<DocumentSnapshot> documents = result.docs;

    documents.forEach((doc) {
      bool now = true;
      today == doc.data()['date'] ? now = true : now = false;
      if (doc.data()['date'] == today) {
        print('inside createROws if condition');
        print('inside if date is${doc.data()['date']}');

        now = true;
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
      }
      this.total = myTotal;
      return new Text(now ? '$total' : '');
    });
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
      backgroundColor: Colors.blue[900],
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: Text(
          'HELLO DOCTOR',
          textAlign: TextAlign.center,
        ),
      ),
      drawer: DoctorDrawer(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: ListView(
          //scrollDirection: Axis.vertical,
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

                              todayDate =
                                  "${_dateTime.day.toString().padLeft(2, '0')}/${_dateTime.month.toString().padLeft(2, '0')}/${_dateTime.year.toString()}";
                            });
                          });
                        },
                      ),
                      SizedBox(height: 10),
                      Text(
                        _dateTime == null
                            ? 'Nothing has been selected'
                            : '${_dateTime.day.toString().padLeft(2, '0')}/${_dateTime.month.toString().padLeft(2, '0')}/${_dateTime.year.toString()}',
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
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(29),
                    child: FlatButton(
                      minWidth: 50,
                      padding:
                          EdgeInsets.symmetric(vertical: 20, horizontal: 110),
                      color: Colors.blue[700],
                      onPressed: () {
                        setState(() {
                          //fetchDateId();
                          //seeTodayPatient(_dateTime);
                          findTotalFee(todayDate);
                        });
                      },
                      child: Text(
                        "Total fee",
                        style: TextStyle(
                            fontFamily: 'Source Sans Pro',
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  height: 50,
                  color: Colors.white,
                  alignment: Alignment.center,
                  //margin: EdgeInsets.fromLTRB(0, 120, 0, 0),
                  child: Text('Total fee: $total BDT',
                      style: TextStyle(
                          fontFamily: 'Source Sans Pro',
                          fontSize: 20,
                          color: Colors.blue[900],
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
                SizedBox(
                  height: 10,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Container(
                    color: Colors.white,
                    child: StreamBuilder(
                      stream: _firestore
                          .collection('Doctor')
                          .doc(loggedInUser.uid)
                          .collection('patients')
                          .orderBy('sl no', descending: false)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) return new Text('Loading...');
                        if (todayDate == null) {
                          return Text('Please Select the Date',
                              style: TextStyle(
                                  fontFamily: 'Source Sans Pro',
                                  fontSize: 20,
                                  color: Colors.blue[900],
                                  fontWeight: FontWeight.bold));
                        }
                        // todayDate = snapshot.data()['date'];
                        return new DataTable(
                          columns: <DataColumn>[
                            new DataColumn(
                                label: Text(
                              'Done',
                              style: TextStyle(
                                  fontFamily: 'Source Sans Pro',
                                  fontSize: 15,
                                  color: Colors.blue[900],
                                  fontWeight: FontWeight.bold),
                            )),
                            new DataColumn(
                              label: Text(
                                'Sl',
                                style: TextStyle(
                                    fontFamily: 'Source Sans Pro',
                                    fontSize: 15,
                                    color: Colors.blue[900],
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            new DataColumn(
                                label: Text(
                              'Name',
                              style: TextStyle(
                                  fontFamily: 'Source Sans Pro',
                                  fontSize: 15,
                                  color: Colors.blue[900],
                                  fontWeight: FontWeight.bold),
                            )),
                            new DataColumn(
                                label: Text(
                              'purpose',
                              style: TextStyle(
                                  fontFamily: 'Source Sans Pro',
                                  fontSize: 15,
                                  color: Colors.blue[900],
                                  fontWeight: FontWeight.bold),
                            )),
                            new DataColumn(
                                label: Text(
                              'Time',
                              style: TextStyle(
                                  fontFamily: 'Source Sans Pro',
                                  fontSize: 15,
                                  color: Colors.blue[900],
                                  fontWeight: FontWeight.bold),
                            )),
                            new DataColumn(
                                label: Text(
                              'Gender',
                              style: TextStyle(
                                  fontFamily: 'Source Sans Pro',
                                  fontSize: 15,
                                  color: Colors.blue[900],
                                  fontWeight: FontWeight.bold),
                            )),
                            new DataColumn(
                                label: Text(
                              'Age',
                              style: TextStyle(
                                  fontFamily: 'Source Sans Pro',
                                  fontSize: 15,
                                  color: Colors.blue[900],
                                  fontWeight: FontWeight.bold),
                            )),
                            new DataColumn(
                                label: Text(
                              'Fee',
                              style: TextStyle(
                                  fontFamily: 'Source Sans Pro',
                                  fontSize: 15,
                                  color: Colors.blue[900],
                                  fontWeight: FontWeight.bold),
                            )),
                            new DataColumn(
                                label: Text(
                              'Phone',
                              style: TextStyle(
                                  fontFamily: 'Source Sans Pro',
                                  fontSize: 15,
                                  color: Colors.blue[900],
                                  fontWeight: FontWeight.bold),
                            )),
                            new DataColumn(
                                label: Text(
                              'Cancel',
                              style: TextStyle(
                                  fontFamily: 'Source Sans Pro',
                                  fontSize: 15,
                                  color: Colors.blue[900],
                                  fontWeight: FontWeight.bold),
                            )),
                          ],
                          rows: _createRows(snapshot.data, todayDate),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  List<DataRow> _createRows(QuerySnapshot snapshot, String today) {
    List<DataRow> newList =
        snapshot.docs.map((DocumentSnapshot documentSnapshot) {
      bool now = true;
      //today = '10/1/2021';
      today == documentSnapshot.data()['date'] ? now = true : now = false;
      print(
          'today is $today gloabl is $todayDate, doc is ${documentSnapshot.data()['date']}');
      if (documentSnapshot.data()['date'] == today) {
        print('inside createROws if condition');
        print('inside if date is${documentSnapshot.data()['date']}');

        now = true;
      }

      //if (documentSnapshot.data()['date'] == 'today') {
      return new DataRow(cells: [
        now
            ? DataCell(IconButton(
                onPressed: () async {
                  approveCondition = documentSnapshot.data()['isApproved'];
                  if (approveCondition == false) {
                    await FirebaseFirestore.instance
                        .collection('Doctor')
                        .doc(myDoctor)
                        .collection('patients')
                        .doc(documentSnapshot.id)
                        .update({'isApproved': true});
                  }
                  print('$approveCondition its condition');
                },
                icon: documentSnapshot.data()['isApproved']
                    ? Icon(
                        Icons.check,
                        color: Colors.green,
                        size: 30,
                      )
                    : Icon(
                        Icons.check_box_outline_blank_sharp,
                        color: Colors.blue[900],
                        size: 30,
                      ),
              ))
            : DataCell(Text('')),
        now
            ? DataCell(Text(documentSnapshot.data()['sl no'].toString(),
                style: TextStyle(
                    fontFamily: 'Source Sans Pro',
                    //fontSize: 20,
                    color: Colors.blue[900],
                    fontWeight: FontWeight.bold)))
            : DataCell(Text('')),
        now
            ? DataCell((Text(documentSnapshot.data()['name'].toString(),
                style: TextStyle(
                    fontFamily: 'Source Sans Pro',
                    //fontSize: 20,
                    color: Colors.blue[900],
                    fontWeight: FontWeight.bold))))
            : DataCell(Text('')),
        now
            ? DataCell(Text(documentSnapshot.data()['purpose'].toString(),
                style: TextStyle(
                    fontFamily: 'Source Sans Pro',
                    //fontSize: 20,
                    color: Colors.blue[900],
                    fontWeight: FontWeight.bold)))
            : DataCell(Text('')),
        now
            ? DataCell(Text(documentSnapshot.data()['time'].toString(),
                style: TextStyle(
                    fontFamily: 'Source Sans Pro',
                    //fontSize: 20,
                    color: Colors.blue[900],
                    fontWeight: FontWeight.bold)))
            : DataCell(Text('')),
        now
            ? DataCell(Text(documentSnapshot.data()['gender'].toString(),
                style: TextStyle(
                    fontFamily: 'Source Sans Pro',
                    //fontSize: 20,
                    color: Colors.blue[900],
                    fontWeight: FontWeight.bold)))
            : DataCell(Text('')),
        now
            ? DataCell(Text(documentSnapshot.data()['age'].toString(),
                style: TextStyle(
                    fontFamily: 'Source Sans Pro',
                    //fontSize: 20,
                    color: Colors.blue[900],
                    fontWeight: FontWeight.bold)))
            : DataCell(Text('')),
        now
            ? DataCell(Text(documentSnapshot.data()['fee'].toString(),
                style: TextStyle(
                    fontFamily: 'Source Sans Pro',
                    //fontSize: 20,
                    color: Colors.blue[900],
                    fontWeight: FontWeight.bold)))
            : DataCell(Text('')),
        now
            ? DataCell(Text(documentSnapshot.data()['phone'].toString(),
                style: TextStyle(
                    fontFamily: 'Source Sans Pro',
                    //fontSize: 20,
                    color: Colors.blue[900],
                    fontWeight: FontWeight.bold)))
            : DataCell(Text('')),
        now
            ? DataCell(
                IconButton(
                  icon: Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                  onPressed: () {
                    _firestore
                        .collection('Doctor')
                        .doc(loggedInUser.uid)
                        .collection('patients')
                        .document(documentSnapshot.documentID)
                        .delete();
                  },
                ),
              )
            : DataCell(Text(''))

        //DataCell(Text(documentSnapshot.data()['gender'].toString())),
      ]);
    }).toList();
    return newList;
  }
}
