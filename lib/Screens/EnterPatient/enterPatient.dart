import 'package:flutter/material.dart';
import 'package:appointment_diary/Screens/Success/successfullyAdded.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:appointment_diary/Screens/EnterPatient/assistantDrawer.dart';
import 'dart:io';

class EnterPatient extends StatefulWidget {
  @override
  _EnterPatientState createState() => _EnterPatientState();
}

class _EnterPatientState extends State<EnterPatient> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final _firestore = Firestore.instance;
  final _auth = FirebaseAuth.instance;
  TimeOfDay time;
  TimeOfDay picked;

  User loggedInUser;
  String email;

  String timee;
  String sl;
  String name;
  String dob;
  String age;
  String gender;
  String phone;
  String purpose;
  String date;
  String doctorEmail;
  String fee;
  var selectedYear;
  String myDoctor;
  final formKey = new GlobalKey<FormState>();
  final formKeyy = new GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    getCurrentUser();
    time = TimeOfDay.now();
  }

  Future<Null> selectTime(BuildContext context) async {
    picked = await showTimePicker(context: context, initialTime: time);
    if (picked != null) {
      setState(() {
        time = picked;
      });
    }
  }

  getCurrentUser() async {
    try {
      final user = await _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
        print(loggedInUser.uid);
        print(loggedInUser.email);
      }
    } catch (e) {
      print('Fail');
    }
  }

  void getPatientDetail() async {
    final patients = await _firestore.collection('patients').getDocuments();
    for (var patient in patients.docs) {
      print(patient.data());
    }
  }

  void _showPicker() {
    showDatePicker(
            context: context,
            firstDate: new DateTime(1900),
            initialDate: new DateTime.now(),
            lastDate: DateTime.now())
        .then((DateTime dt) {
      selectedYear = dt.year;
      calculateAge();
    });
  }

  void calculateAge() {
    setState(() {
      age = (2021 - selectedYear).toString();
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
    DateTime now = new DateTime.now();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.blue[900],
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: Text(''),
      ),
      drawer: AssistantDrawer(),
      body: Form(
        key: _formkey,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: SingleChildScrollView(
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.fromLTRB(0, 100, 0, 0),
                  child: Text('ENTER PATIENT DETAIL',
                      style: TextStyle(
                          fontFamily: 'Source Sans Pro',
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold)),
                ),
                SizedBox(
                  height: 50,
                ),
                Container(
                  child: Row(
                    children: [
                      Text(
                        'Date:',
                        style: TextStyle(
                            fontFamily: 'Source Sans Pro',
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        date =
                            "${now.day.toString().padLeft(2, '0')}/${now.month.toString().padLeft(2, '0')}/${now.year.toString()}",
                        style: TextStyle(
                            fontFamily: 'Source Sans Pro',
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                Container(
                  color: Colors.white,
                  child: TextFormField(
                    validator: (String value) {
                      if (value.isEmpty) {
                        return "Field cannot be empty";
                      }

                      if (!RegExp(
                              '^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]+.[com]')
                          .hasMatch(value)) {
                        return "example@gmail.com";
                      }
                      return null;
                    },
                    onChanged: (value) {
                      doctorEmail = value;
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
                SizedBox(
                  height: 12,
                ),
                Container(
                  color: Colors.white,
                  child: Row(
                    children: [
                      Icon(Icons.alarm),
                      SizedBox(width: 5),
                      Text('Time:'),
                      FlatButton(
                        onPressed: () {
                          selectTime(context);
                          print(time);
                        },
                        child: Text(timee =
                            '${time.hour.toString()}:${time.minute.toString()}'),

                        // onChanged: (value) {
                        //   time = value;
                        //   //Do something with the user input.
                        // },
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                Container(
                  color: Colors.white,
                  child: TextFormField(
                    validator: (String value) {
                      if (value.isEmpty) {
                        return "Field cannot be empty";
                      }
                      if (!RegExp('^[0-9]').hasMatch(value)) {
                        return "Only digit";
                      }
                      return null;
                    },
                    onChanged: (value) {
                      sl = value;
                      //Do something with the user input.
                    },
                    decoration: InputDecoration(
                      icon: Icon(Icons.confirmation_number),
                      hintText: 'Serial No',
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 20.0, horizontal: 20.0),
                    ),
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                Container(
                  color: Colors.white,
                  child: TextFormField(
                    validator: (String value) {
                      if (value.isEmpty) {
                        return "Field cannot be empty";
                      }
                      if (!RegExp('^[a-zA-Z]').hasMatch(value)) {
                        return "example:John";
                      }
                      return null;
                    },
                    onChanged: (value) {
                      name = value;
                      //Do something with the user input.
                    },
                    decoration: InputDecoration(
                      icon: Icon(Icons.person),
                      hintText: 'Patient Name',
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 20.0, horizontal: 20.0),
                    ),
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                Container(
                  //color: Colors.white,
                  child: Column(
                    children: <Widget>[
                      OutlineButton(
                        child: Text(
                          selectedYear != null
                              ? selectedYear.toString()
                              : "Select year of birth",
                          style: TextStyle(color: Colors.white),
                        ),
                        borderSide:
                            new BorderSide(color: Colors.white, width: 3.0),
                        color: Colors.white,
                        onPressed: _showPicker,
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                Container(
                  height: 55,
                  color: Colors.white,
                  child: Row(
                    children: [
                      Text(
                        'Age:',
                        style: TextStyle(
                            fontFamily: 'Source Sans Pro',
                            fontSize: 20,
                            //color: Colors.black12,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        age = '${age.toString()}',
                        style: TextStyle(
                            fontFamily: 'Source Sans Pro',
                            fontSize: 20,
                            //color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                Container(
                  child: Container(
                    //padding: EdgeInsets.all(8),
                    color: Colors.white,
                    //margin: EdgeInsets.fromLTRB(20, 130, 20, 50),
                    child: Form(
                        key: formKey,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.all(16),
                                child: DropdownButton(
                                  hint: Text('Gender'),
                                  onChanged: (val) {
                                    print(val);
                                    setState(() {
                                      this.gender = val;
                                    });
                                  },
                                  value: this.gender,
                                  items: [
                                    DropdownMenuItem(
                                      child: Text('Male'),
                                      value: 'Male',
                                    ),
                                    DropdownMenuItem(
                                      child: Text('Female'),
                                      value: 'Female',
                                    )
                                  ],
                                ),
                              ),
                            ])),
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                Container(
                  color: Colors.white,
                  child: TextFormField(
                    validator: (String value) {
                      if (value.isEmpty) {
                        return "Field cannot be empty";
                      }
                      if (!RegExp('^[0-9]').hasMatch(value)) {
                        return "Only digit";
                      }
                      return null;
                    },
                    onChanged: (value) {
                      phone = value;
                      //Do something with the user input.
                    },
                    decoration: InputDecoration(
                      icon: Icon(Icons.phone_android),
                      hintText: 'Phone No',
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 20.0, horizontal: 20.0),
                    ),
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                Container(
                  child: Container(
                    //padding: EdgeInsets.all(8),
                    color: Colors.white,
                    //margin: EdgeInsets.fromLTRB(20, 130, 20, 50),
                    child: Form(
                        key: formKeyy,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.all(16),
                                child: DropdownButton(
                                  hint: Text('Purpose'),
                                  onChanged: (val) {
                                    print(val);
                                    setState(() {
                                      this.purpose = val;
                                    });
                                  },
                                  value: this.purpose,
                                  items: [
                                    DropdownMenuItem(
                                      child: Text('Consultancy'),
                                      value: 'Consultancy',
                                    ),
                                    DropdownMenuItem(
                                      child: Text('Follow up'),
                                      value: 'Follow up',
                                    ),
                                    DropdownMenuItem(
                                      child: Text('Report'),
                                      value: 'Report',
                                    )
                                  ],
                                ),
                              ),
                            ])),
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                Container(
                  color: Colors.white,
                  child: TextFormField(
                    validator: (String value) {
                      if (value.isEmpty) {
                        return "Field cannot be empty";
                      }
                      if (!RegExp('^[0-9]').hasMatch(value)) {
                        return "Only digit";
                      }
                      return null;
                    },
                    onChanged: (value) {
                      fee = value;
                      // String test0 = value;
                      // fee = test0 as num;
                      //Do something with the user input.
                    },
                    decoration: InputDecoration(
                      icon: Icon(Icons.money_outlined),
                      hintText: 'Fee',
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 20.0, horizontal: 20.0),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  child: Container(
                    //margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(29),
                      child: FlatButton(
                        padding:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 50),
                        color: Colors.blue[700],
                        onPressed: () async {
                          if (_formkey.currentState.validate()) {
                            await fetchDoctorId(doctorEmail);
                            final newC = await _firestore
                                .collection('Doctor')
                                .doc(myDoctor)
                                //.collection('date')
                                //.add({'date': date});
                                .collection('patients')
                                .add({
                              'date': date,
                              'time': timee,
                              'sl no': sl,
                              'name': name,
                              'dob': dob,
                              'age': age,
                              'gender': gender,
                              'phone': phone,
                              'purpose': purpose,
                              'fee': fee,
                              'docid': myDoctor,
                              'isApproved': false,
                            });
                            if (newC != null) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return SuccessScreen();
                                  },
                                ),
                              );
                            }
                          }
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
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
