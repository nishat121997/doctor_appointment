import 'package:flutter/material.dart';
import 'package:appointment_diary/Screens/PatientList/patientTable.dart';
import 'package:appointment_diary/Screens/DoctorScreen/Fee.dart';

class HelloDScreen extends StatefulWidget {
  @override
  _HelloDScreenState createState() => _HelloDScreenState();
}

class _HelloDScreenState extends State<HelloDScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.blue[900],
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
              child: TextFormField(
                onChanged: (value) {
                  //Do something with the user input.
                },
                decoration: InputDecoration(
                  icon: Icon(Icons.calendar_today),
                  hintText: 'Select Date',
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
                ),
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
              child: TextFormField(
                onChanged: (value) {
                  //Do something with the user input.
                },
                decoration: InputDecoration(
                  icon: Icon(Icons.calendar_today),
                  hintText: 'Select Date',
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
                ),
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
