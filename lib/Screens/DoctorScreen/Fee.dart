import 'package:flutter/material.dart';
import 'package:appointment_diary/Screens/Register/regSuccess.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FeeScreen extends StatefulWidget {
  @override
  _FeeScreenState createState() => _FeeScreenState();
}

class _FeeScreenState extends State<FeeScreen> {
  final _firestore = Firestore.instance;
  final _auth = FirebaseAuth.instance;
  final collections = Firestore.instance.collection('patients');
  @override
  void initState() {
    super.initState();
  }

  var total;

  Future findTotalFee() async {
    int myTotal = 0;
    QuerySnapshot result =
        await FirebaseFirestore.instance.collection('patients').get();
    List<DocumentSnapshot> documents = result.docs;
    documents.forEach((doc) {
      print(doc.data());
      print(doc.data()['fee']);
      String tempo = doc.data()['fee'];
      print(tempo);
      if (tempo != null) {
        print('inside if');
        print(tempo);
        int total = int.parse('$tempo');
        myTotal = total + myTotal;
        print('total is $myTotal');
      }
    });
    this.total = myTotal;
    return myTotal;
  }

  @override
  Widget build(BuildContext context) {
    print(findTotalFee());
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.blue[900],
      body: FutureBuilder(
          future: findTotalFee(),
          builder: (BuildContext context, snapshot) {
            if (!snapshot.hasData)
              return CircularProgressIndicator();
            else
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  //mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.fromLTRB(0, 70, 0, 0),
                      child: Text('SEE YOUR UPDATE',
                          style: TextStyle(
                              fontFamily: 'Source Sans Pro',
                              fontSize: 25,
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                    ),
                    Container(
                      //alignment: Alignment.center,
                      margin: EdgeInsets.fromLTRB(0, 120, 0, 0),
                      child: Text('Total fee: $total BDT',
                          style: TextStyle(
                              fontFamily: 'Source Sans Pro',
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              );
          }),
    );
  }
}
