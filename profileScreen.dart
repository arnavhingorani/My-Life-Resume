//import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_life_resume/auth_service.dart';
import 'package:my_life_resume/splashScreen.dart';
import 'package:provider/provider.dart';
import 'package:my_life_resume/homeScreen.dart';
import 'package:my_life_resume/welcome.dart';

//import 'package:flutter_ui_challenges/core/presentation/res/assets.dart';
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  static final String path = "lib/src/pages/profile/profile8.dart";
  void initState() {
    super.initState();
    UserInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade100,
        extendBodyBehindAppBar: true,
        extendBody: true,
        appBar: AppBar(
          backgroundColor: Color(0xFFFF4F5A),
          elevation: 0,
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back),
            onPressed: () => Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => HomeScreen())),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              ProfileHeader(
                avatar: NetworkImage(
                    "https://cdn.onlinewebfonts.com/svg/img_87237.png"),
                coverImage: NetworkImage(
                    "https://www.freepik.com/free-vector/character-illustration-people-holding-user-account-icons_3226077.htm#page=1&query=profile%20icon&position=3"),
                title: "User Information",
                //subtitle: "Paradise Valley, AZ, USA",
                actions: <Widget>[],
              ),
              const SizedBox(height: 10.0),
              UserInfo(),
            ],
          ),
        ));
  }
}

class UserInfo extends StatefulWidget {
  @override
  _UserInfoState createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  ScrollController? _scrollController;
  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController!.addListener(() {
      setState(() {
        print("Line 75");
      });
    });
    print("Line 77");
    getData();
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? _uid;
  String? _name;
  String? _email;
  String? _phone;
  String? _address;

  void getData() async {
    User? user = _auth.currentUser;
    _uid = user!.uid;
    print('user.email ${user.email}');
    final DocumentSnapshot userDoc =
        await FirebaseFirestore.instance.collection('users').doc(_uid).get();
    setState(() {
      _name = userDoc.get('name');
      _email = userDoc.get('email');
      _phone = userDoc.get('phone');
      _address = userDoc.get('address');
    });

    print(_email);
  }

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final authService = Provider.of<AuthService>(context);
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(left: 8.0, bottom: 4.0),
            alignment: Alignment.topLeft,
            child: Text(
              "",
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
                        color: Color(0xFFFF4F5A),
                        tiles: [
                          // ListTile(
                          //   contentPadding: EdgeInsets.symmetric(
                          //       horizontal: 12, vertical: 4),
                          //   leading: Icon(Icons.my_location),
                          //   title: Text("Date of Birth"),
                          //   subtitle: Text("11/11/2008"),
                          // ),
                          ListTile(
                            leading: Icon(Icons.person),
                            title: Text(
                              "Name",
                              style: TextStyle(color: Color(0xFFFF4F5A)),
                            ),
                            subtitle: Text(
                              '$_name',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                          ListTile(
                            leading: Icon(Icons.email),
                            title: Text(
                              "Email",
                              style: TextStyle(color: Color(0xFFFF4F5A)),
                            ),
                            subtitle: Text(
                              '$_email',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                          ListTile(
                            leading: Icon(Icons.phone),
                            title: Text(
                              "Phone",
                              style: TextStyle(color: Color(0xFFFF4F5A)),
                            ),
                            subtitle: Text(
                              '$_phone',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                          ListTile(
                            leading: Icon(Icons.home),
                            title: Text(
                              "Address",
                              style: TextStyle(color: Color(0xFFFF4F5A)),
                            ),
                            subtitle: Text(
                              '$_address',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          RaisedButton(
                            color: Color(0xFFFF4F5A),
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => SplashScreen(),
                                ),
                              );
                            },
                            child: Text("Log Out",
                                style: TextStyle(color: Colors.white)),
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

class ProfileHeader extends StatelessWidget {
  final ImageProvider<dynamic> coverImage;
  final ImageProvider<dynamic> avatar;
  final String title;
  final String? subtitle;
  final List<Widget>? actions;

  const ProfileHeader(
      {Key? key,
      required this.coverImage,
      required this.avatar,
      required this.title,
      this.subtitle,
      this.actions})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Ink(
          height: 200,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: coverImage as ImageProvider<Object>, fit: BoxFit.cover),
          ),
        ),
        Ink(
          height: 200,
          decoration: BoxDecoration(
            color: Colors.black38,
          ),
        ),
        if (actions != null)
          Container(
            width: double.infinity,
            height: 200,
            padding: const EdgeInsets.only(bottom: 0.0, right: 0.0),
            alignment: Alignment.bottomRight,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: actions!,
            ),
          ),
        Container(
          width: double.infinity,
          margin: const EdgeInsets.only(top: 160),
          child: Column(
            children: <Widget>[
              Avatar(
                image: avatar,
                radius: 40,
                backgroundColor: Colors.white,
                borderColor: Colors.grey.shade300,
                borderWidth: 4.0,
              ),
              Text(
                title,
                style: Theme.of(context).textTheme.title,
              ),
              if (subtitle != null) ...[
                const SizedBox(height: 5.0),
                Text(
                  subtitle!,
                  style: Theme.of(context).textTheme.subtitle,
                ),
              ]
            ],
          ),
        )
      ],
    );
  }
}

class Avatar extends StatelessWidget {
  final ImageProvider<dynamic> image;
  final Color borderColor;
  final Color? backgroundColor;
  final double radius;
  final double borderWidth;

  const Avatar(
      {Key? key,
      required this.image,
      this.borderColor = Colors.grey,
      this.backgroundColor,
      this.radius = 30,
      this.borderWidth = 5})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius + borderWidth,
      backgroundColor: borderColor,
      child: CircleAvatar(
        radius: radius,
        backgroundColor: backgroundColor != null
            ? backgroundColor
            : Theme.of(context).primaryColor,
        child: CircleAvatar(
          radius: radius - borderWidth,
          backgroundImage: image as ImageProvider<Object>?,
        ),
      ),
    );
  }
}
