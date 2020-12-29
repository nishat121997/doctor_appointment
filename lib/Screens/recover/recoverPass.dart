import 'package:flutter/material.dart';
import 'package:appointment_diary/Screens/Login/login_screen.dart';

class RecoverPassScreen extends StatefulWidget {
  @override
  _RecoverPassScreenState createState() => _RecoverPassScreenState();
}

class _RecoverPassScreenState extends State<RecoverPassScreen> {
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
              child: Text('RESET YOUR PASSWORD',
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
              color: Colors.white,
              child: TextFormField(
                onChanged: (value) {
                  //Do something with the user input.
                },
                decoration: InputDecoration(
                  icon: Icon(Icons.drive_file_rename_outline),
                  hintText: 'ENTER A NEW PASSWORD',
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
                ),
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Container(
              color: Colors.white,
              child: TextFormField(
                onChanged: (value) {
                  //Do something with the user input.
                },
                decoration: InputDecoration(
                  icon: Icon(Icons.beenhere_outlined),
                  hintText: 'CONFIRM YOUR PASSWORD',
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
                ),
              ),
            ),
            SizedBox(
              height: 50.0,
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
                          return LoginScreen();
                        },
                      ),
                    );
                  },
                  child: Text(
                    "DONE!",
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
