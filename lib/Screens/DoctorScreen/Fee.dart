import 'package:flutter/material.dart';
import 'package:appointment_diary/Screens/Register/regSuccess.dart';
import 'package:appointment_diary/Screens/EnterPatient/assistantDrawer.dart';

class FeeScreen extends StatefulWidget {
  @override
  _FeeScreenState createState() => _FeeScreenState();
}

class _FeeScreenState extends State<FeeScreen> {
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
              margin: EdgeInsets.fromLTRB(0, 60, 0, 0),
              child: Text('SEE YOUR UPDATE',
                  style: TextStyle(
                      fontFamily: 'Source Sans Pro',
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold)),
            ),
            SizedBox(
              height: 40,
            ),
            Container(
              //alignment: Alignment.center,
              margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: Text('TOTAL PATIENT:',
                  style: TextStyle(
                      fontFamily: 'Source Sans Pro',
                      fontSize: 15,
                      color: Colors.white,
                      fontWeight: FontWeight.bold)),
            ),
            SizedBox(
              height: 8,
            ),
            Container(
              color: Colors.white,
              child: TextFormField(
                onChanged: (value) {
                  //Do something with the user input.
                },
                decoration: InputDecoration(
                  icon: Icon(Icons.people_alt_outlined),
                  //hintText: 'User Name',
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
                ),
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Container(
              //alignment: Alignment.center,
              margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: Text('CONSULTANCY:',
                  style: TextStyle(
                      fontFamily: 'Source Sans Pro',
                      fontSize: 15,
                      color: Colors.white,
                      fontWeight: FontWeight.bold)),
            ),
            SizedBox(
              height: 8,
            ),
            Container(
              color: Colors.white,
              child: TextFormField(
                onChanged: (value) {
                  //Do something with the user input.
                },
                decoration: InputDecoration(
                  icon: Icon(Icons.people_alt_outlined),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
                ),
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Container(
              //alignment: Alignment.center,
              margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: Text('FOLLOW UP:',
                  style: TextStyle(
                      fontFamily: 'Source Sans Pro',
                      fontSize: 15,
                      color: Colors.white,
                      fontWeight: FontWeight.bold)),
            ),
            SizedBox(
              height: 8,
            ),
            Container(
              color: Colors.white,
              child: TextFormField(
                onChanged: (value) {
                  //Do something with the user input.
                },
                decoration: InputDecoration(
                  icon: Icon(Icons.people_alt_outlined),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
                ),
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Container(
              //alignment: Alignment.center,
              margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: Text('REPORT:',
                  style: TextStyle(
                      fontFamily: 'Source Sans Pro',
                      fontSize: 15,
                      color: Colors.white,
                      fontWeight: FontWeight.bold)),
            ),
            SizedBox(
              height: 8,
            ),
            Container(
              color: Colors.white,
              child: TextFormField(
                onChanged: (value) {
                  //Do something with the user input.
                },
                decoration: InputDecoration(
                  icon: Icon(Icons.people_alt_outlined),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
                ),
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Container(
              //alignment: Alignment.center,
              margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: Text('TOTAL AMOUNT:',
                  style: TextStyle(
                      fontFamily: 'Source Sans Pro',
                      fontSize: 15,
                      color: Colors.white,
                      fontWeight: FontWeight.bold)),
            ),
            SizedBox(
              height: 8,
            ),
            Container(
              color: Colors.white,
              child: TextFormField(
                onChanged: (value) {
                  //Do something with the user input.
                },
                decoration: InputDecoration(
                  icon: Icon(Icons.money_outlined),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
