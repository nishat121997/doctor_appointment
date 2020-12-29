import 'package:appointment_diary/Screens/Login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:appointment_diary/Screens/Welcome/components/background.dart';
//import 'package:appointment_diary/constants.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //  Size size = MediaQuery.of(context).size;
    // This size provide us total height and width of our screen
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 90.0,
              width: 150.0,
            ),
            Text('APPOINTMENT DIARY',
                style: TextStyle(
                    fontFamily: 'Source Sans Pro',
                    fontSize: 30,
                    letterSpacing: 2.5,
                    color: Colors.white,
                    fontWeight: FontWeight.bold)),
            SizedBox(
              height: 90.0,
              width: 150.0,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(29),
              child: FlatButton(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 110),
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
                  "START",
                  style: TextStyle(
                      fontFamily: 'Source Sans Pro',
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
