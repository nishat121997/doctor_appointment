import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:appointment_diary/Screens/Register/reg_screen.dart';
import 'package:appointment_diary/Screens/EnterPatient/enterPatient.dart';
import 'package:appointment_diary/Screens/recover/recoverPass.dart';
import 'package:appointment_diary/Screens/DoctorScreen/HelloDoctor.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

//enum designation { Doctor, Assistant }

class _LoginScreenState extends State<LoginScreen> {
  String designation;
  final _firestore = Firestore.instance;
  final _auth = FirebaseAuth.instance;

  String email;
  String password;
  String registerAs;
  //String d;
  final formKey = new GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  _saveForm() {
    var form = formKey.currentState;
    if (form.validate()) {
      form.save();
      setState(() {});
    }
  }

  // void checkRole() async {
  //   final users = await _firestore.collection('users').getDocuments();
  //   for (var user in users.documents) {
  //     if (document.onLoadedData['Register As'] == 'll') {}
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.blue[900],
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                //mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.fromLTRB(0, 100, 0, 0),
                    child: Text('LOG IN TO YOUR ACCOUNT',
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
                        email = value;
                        //Do something with the user input.
                      },
                      decoration: InputDecoration(
                        icon: Icon(Icons.email_outlined),
                        hintText: 'Enter your email',
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
                      obscureText: true,
                      onChanged: (value) {
                        password = value;
                        //Do something with the user input.
                      },
                      decoration: InputDecoration(
                        icon: Icon(Icons.lock),
                        hintText: 'Enter your Password',
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
                          key: formKey,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.all(16),
                                  child: DropdownButton(
                                    hint: Text('LogIn As'),
                                    onChanged: (val) {
                                      print(val);
                                      setState(() {
                                        this.designation = val;
                                      });
                                    },
                                    value: this.designation,
                                    items: [
                                      DropdownMenuItem(
                                        child: Text('Doctor'),
                                        value: 'Doctor',
                                      ),
                                      DropdownMenuItem(
                                        child: Text('Assistant'),
                                        value: 'Assistant',
                                      )
                                    ],
                                  ),
                                ),
                              ])),
                    ),
                  ),
                  SizedBox(
                    height: 40.0,
                  ),
                  Container(
                    //margin: EdgeInsets.fromLTRB(20, 550, 20, 60),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(29),
                      child: FlatButton(
                        padding:
                            EdgeInsets.symmetric(vertical: 16, horizontal: 100),
                        color: Colors.blue[700],
                        onPressed: () async {
                          try {
                            final user = await _auth.signInWithEmailAndPassword(
                                email: email, password: password);
                            if (user != null) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return EnterPatient();
                                  },
                                ),
                              );
                            }
                          } catch (e) {
                            print(e);
                          }
                        },
                        child: Text(
                          "LOG IN",
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
                    height: 20,
                  ),
                  Container(
                    //margin: EdgeInsets.fromLTRB(20, 550, 20, 60),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(29),
                      child: FlatButton(
                        padding:
                            EdgeInsets.symmetric(vertical: 16, horizontal: 50),
                        color: Colors.blue[700],
                        onPressed: () async {
                          final user = await _auth.signInWithEmailAndPassword(
                              email: email, password: password);

                          if (user != null) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return HelloDScreen();
                                },
                              ),
                            );
                          }
                        },
                        child: Text(
                          "DOCTOR LOG IN",
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
                    height: 10,
                  ),
                  Container(
                    child: Container(
                      //margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: Row(children: <Widget>[
                        Text(
                          'Do not have an Account?',
                          style: TextStyle(
                              fontFamily: 'Source Sans Pro',
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                        FlatButton(
                          padding: EdgeInsets.symmetric(
                              vertical: 20, horizontal: 20),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return RegistrationScreen();
                                },
                              ),
                            );
                          },
                          child: Text(
                            "REGISTER",
                            style: TextStyle(
                                fontFamily: 'Source Sans Pro',
                                fontSize: 20,
                                color: Colors.blue[700],
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ]),
                    ),
                  ),
                  Container(
                    child: Container(
                      //margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: Row(children: <Widget>[
                        Text(
                          'Forgotten password?',
                          style: TextStyle(
                              fontFamily: 'Source Sans Pro',
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                        FlatButton(
                          padding: EdgeInsets.symmetric(
                              vertical: 20, horizontal: 20),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return RecoverPassScreen();
                                },
                              ),
                            );
                          },
                          child: Text(
                            "RECOVER",
                            style: TextStyle(
                                fontFamily: 'Source Sans Pro',
                                fontSize: 20,
                                color: Colors.blue[700],
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ]),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
