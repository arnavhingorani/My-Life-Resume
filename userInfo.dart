import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_life_resume/auth_service.dart';
import 'package:provider/provider.dart';

class UserInfo extends StatefulWidget {
  @override
  _UserInfoState createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  ScrollController? _scrollController;
  @override
  void initState(){

    super.initState();
    _scrollController=ScrollController();
    _scrollController!.addListener(() {setState(() {
      print("Line 75");
    });});
    print("Line 77");
    getData();

  }
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? _uid;
  String? _name;
  String? _email;
  String? _phone;

  void getData() async{
    User? user = _auth.currentUser;
    _uid=user!.uid;
    print('user.email ${user.email}');
    final DocumentSnapshot userDoc =
    await FirebaseFirestore.instance.collection('users').doc(_uid).get();
    setState(() {
      _email=userDoc.get('email');
      _phone=userDoc.get('phone');
    });
    print(_email);

  }
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(left: 8.0, bottom: 4.0),
            alignment: Alignment.topLeft,
            child: Text(
              "User Information",
              style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Card(
            child: Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.all(15),
              child: Column(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      ...ListTile.divideTiles(
                        color: Colors.grey,
                        tiles: [
                          // ListTile(
                          //   contentPadding: EdgeInsets.symmetric(
                          //       horizontal: 12, vertical: 4),
                          //   leading: Icon(Icons.my_location),
                          //   title: Text("Date of Birth"),
                          //   subtitle: Text("11/11/2008"),
                          // ),
                          ListTile(
                            leading: Icon(Icons.email),
                            title: Text("Email"),
                            subtitle: Text('$_email'),
                          ),
                          ListTile(
                            leading: Icon(Icons.phone),
                            title: Text("Phone"),
                            subtitle: Text('$_phone'),
                          ),

                          RaisedButton(
                            onPressed: () async {
                              await authService.signOut();
                              Navigator.pop(context);
                            },
                            child: Text("Log Out"),
                          )
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}