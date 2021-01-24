import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:appointment_diary/Screens/Register/reg_screen.dart';
import 'package:appointment_diary/Screens/EnterPatient/enterPatient.dart';
import 'package:appointment_diary/Screens/recover/recoverPass.dart';
import 'package:appointment_diary/Screens/DoctorScreen/HelloDoctor.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  String designation;
  final _firestore = Firestore.instance;
  final _auth = FirebaseAuth.instance;
  FirebaseUser loggedInUser;

  String email;
  String password;
  String registerAs;
  //String d;
  final formKey = new GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
        print(loggedInUser.email);
      }
    } catch (e) {
      print('User Not created');
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
        //scrollDirection: Axis.horizontal,
        child: Column(
          children: [
            Form(
              key: _formkey,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  //mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.fromLTRB(0, 150, 0, 0),
                      child: Text('LOG IN TO YOUR ACCOUNT',
                          style: TextStyle(
                              fontFamily: 'Source Sans Pro',
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                    ),
                    SizedBox(
                      height: 60,
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
                      height: 15,
                    ),
                    Container(
                      color: Colors.white,
                      child: TextFormField(
                        validator: (String value) {
                          if (value.isEmpty) {
                            return "Field cannot be empty";
                          }

                          return null;
                        },
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
                      height: 50.0,
                    ),
                    Container(
                      //margin: EdgeInsets.fromLTRB(20, 550, 20, 60),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(29),
                        child: FlatButton(
                          padding: EdgeInsets.symmetric(
                              vertical: 16, horizontal: 100),
                          color: Colors.blue[700],
                          onPressed: () async {
                            if (_formkey.currentState.validate()) {
                              try {
                                final user =
                                    await _auth.signInWithEmailAndPassword(
                                        email: email, password: password);
                                final value = FirebaseFirestore.instance
                                    .collection('Doctor')
                                    .doc(user.user.uid)
                                    .get()
                                    .then((value) {
                                  if (value.exists) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return HelloDScreen();
                                        },
                                      ),
                                    );
                                  } else {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return EnterPatient();
                                        },
                                      ),
                                    );
                                  }
                                });
                              } catch (e) {
                                String errorMessage;
                                if (e.hashCode == 505284406) {
                                  errorMessage = 'User Not Found';
                                } else if (e.hashCode == 185768934) {
                                  errorMessage = 'Wrong Password';
                                } else if (e.hashCode == 38947693 ||
                                    e.hashCode == 286357906) {
                                  errorMessage =
                                      'Check Your Internet Connection';
                                } else {
                                  errorMessage = 'Please try after sometime';
                                }
                                return showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: Center(
                                            child: Text('$errorMessage')),
                                        actions: [
                                          FlatButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: Text('Try Again'))
                                        ],
                                      );
                                    });
                              }
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
            ),
          ],
        ),
      ),
    );
  }
}
