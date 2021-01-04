import 'package:flutter/material.dart';
import 'package:appointment_diary/Screens/PatientList/patientTable.dart';
import 'package:appointment_diary/Screens/DoctorScreen/Fee.dart';
import 'package:appointment_diary/Screens/EnterPatient/assistantDrawer.dart';

class HelloDScreen extends StatefulWidget {
  @override
  _HelloDScreenState createState() => _HelloDScreenState();
}

class _HelloDScreenState extends State<HelloDScreen> {
  DateTime _dateTime;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.blue[900],
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: Text(''),
      ),
      drawer: AssistantDrawer(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.fromLTRB(0, 100, 0, 0),
              child: Text('HELLO DOCTOR!!',
                  style: TextStyle(
                      fontFamily: 'Source Sans Pro',
                      fontSize: 25,
                      color: Colors.white,
                      fontWeight: FontWeight.bold)),
            ),
            SizedBox(
              height: 50,
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
              //margin: EdgeInsets.fromLTRB(20, 550, 20, 60),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(29),
                child: FlatButton(
                  padding: EdgeInsets.symmetric(vertical: 16, horizontal: 100),
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
                    "See Patient List",
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
              height: 40,
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
              //margin: EdgeInsets.fromLTRB(20, 550, 20, 60),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(29),
                child: FlatButton(
                  padding: EdgeInsets.symmetric(vertical: 16, horizontal: 100),
                  color: Colors.blue[700],
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return FeeScreen();
                        },
                      ),
                    );
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
          ],
        ),
      ),
    );
  }
}
