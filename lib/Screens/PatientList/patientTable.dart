import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:appointment_diary/Screens/EnterPatient/assistantDrawer.dart';

class PatientTableScreen extends StatefulWidget {
  @override
  _PatientTableScreenState createState() => _PatientTableScreenState();
}

class _PatientTableScreenState extends State<PatientTableScreen> {
  DateTime _dateTime;

  final userId = FirebaseAuth.instance.currentUser.uid;
  final _firestore = Firestore.instance;
  final _auth = FirebaseAuth.instance;
  final collections = Firestore.instance.collection('patients');
  String myDoctor;
  String docEmail;
  String docName;
  //String dateId;
  User loggedInUser;
  String todayDate;
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

  fetchDoctorId(String email) async {
    QuerySnapshot result =
        await FirebaseFirestore.instance.collection('Doctor').get();
    List<DocumentSnapshot> documents = result.docs;
    documents.forEach((doc) {
      if (doc.data()['Email'] == email) {
        //print(doc.id);
        //print(doc.data()['User Name']);
        myDoctor = doc.id;
        docEmail = email;
        docName = doc.data()['User Name'];
      }
      //print('$docEmail');
    });
    return Text('$docEmail');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.blue[900],
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: Text(
          'Assistant Page',
          //textAlign: TextAlign.center,
        ),
      ),
      drawer: AssistantDrawer(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
        child: ListView(
          //scrollDirection: Axis.vertical,
          children: [
            Column(
              //mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  color: Colors.white,
                  child: TextFormField(
                    onChanged: (value) {
                      docEmail = value;
                      //Do something with the user input.
                    },
                    decoration: InputDecoration(
                      icon: Icon(Icons.person_outline),
                      hintText: 'Enter doctor email',
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 20.0, horizontal: 20.0),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 0, horizontal: 100),
                  child: FlatButton(
                    height: 50,
                    color: Colors.blue[700],
                    onPressed: () {
                      setState(() {
                        fetchDoctorId(docEmail);
                      });
                    },
                    child: Text(
                      "Done",
                      style: TextStyle(
                          fontFamily: 'Source Sans Pro',
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
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
                SizedBox(
                  height: 20,
                ),
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    'Patients List for $docName',
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
                          .doc(myDoctor)
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
                            new DataColumn(label: Text('')),
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
                        .doc(myDoctor)
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
