import 'package:flutter/material.dart';
import 'package:appointment_diary/Screens/Register/regSuccess.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  String designation;
  final _firestore = Firestore.instance;
  final _auth = FirebaseAuth.instance;
  String username;
  String email;
  String password;
  String registerAs;
  String Doctor;
  String Assistant;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.blue[900],
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Form(
          key: _formkey,
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.fromLTRB(0, 100, 0, 0),
                child: Text('CREATE YOUR ACCOUNT',
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
                  validator: (String value) {
                    if (value.isEmpty) {
                      return "Field cannot be empty";
                    }

                    return null;
                  },
                  onChanged: (value) {
                    username = value;
                    //Do something with the user input.
                  },
                  decoration: InputDecoration(
                    icon: Icon(Icons.person_outline),
                    hintText: 'User Name',
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
                  validator: (String value) {
                    if (value.isEmpty) {
                      return "Field cannot be empty";
                    }
                    if (!RegExp('^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]+.[com]')
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
                    icon: Icon(Icons.mail_outline),
                    hintText: 'Enter your email',
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
                  validator: (String value) {
                    if (value.isEmpty) {
                      return "Field cannot be empty";
                    }
                    if (value.length < 6) {
                      return "Minimum 6 Digits required";
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
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
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
                                hint: Text('Register As'),
                                onChanged: (val) {
                                  registerAs = val;
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
                height: 50.0,
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
                      if (_formkey.currentState.validate()) {
                        try {
                          var newUser = _auth
                              .createUserWithEmailAndPassword(
                                  email: email, password: password)
                              .then((newUser) => _firestore
                                      .collection('$designation')
                                      .doc(newUser.user.uid)
                                      .set({
                                    'Email': email,
                                    'Register As': registerAs,
                                    'User Name': username
                                  }));
                          if (newUser != null) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return RegSuccessScreen();
                                },
                              ),
                            );
                          }
                        } catch (e) {
                          print(e);
                        }
                      }
                    },
                    child: Text(
                      "REGISTER",
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
      ),
    );
  }
}
