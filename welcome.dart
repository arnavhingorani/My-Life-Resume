import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_life_resume/homeScreen.dart';
import 'package:my_life_resume/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:flutter_ui_challenges/core/presentation/res/assets.dart';
//import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'auth_service.dart';

class WelcomeScreen extends StatefulWidget {
  static final String path = "lib/src/pages/login/auth3.dart";

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  //final String backImg = 'images/welcome.jpg';
  late bool formVisible;
  int? _formsIndex;

  @override
  void initState() {
    super.initState();
    formVisible = false;
    _formsIndex = 1;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('images/welcome.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: <Widget>[
          Container(
            color: Colors.black12,
            child: Column(
              children: <Widget>[
                const SizedBox(height: kToolbarHeight + 40),
                Expanded(
                  child: Column(
                    children: <Widget>[
                      Text(
                        "Welcome",
                        style: TextStyle(
                          color: Color(0xffFF4F5A),
                          fontWeight: FontWeight.w500,
                          fontSize: 30.0,
                        ),
                      ),
                      const SizedBox(height: 10.0),
                    ],
                  ),
                ),
                const SizedBox(height: 10.0),
                Row(
                  children: <Widget>[
                    const SizedBox(width: 10.0),
                    Expanded(
                      child: RaisedButton(
                        color: Color(0xffFF4F5A),
                        textColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Text("Login"),
                        onPressed: () {
                          setState(() {
                            formVisible = true;
                            _formsIndex = 1;
                          });
                        },
                      ),
                    ),
                    const SizedBox(width: 10.0),
                    Expanded(
                      child: RaisedButton(
                        color: Colors.white,
                        textColor: Color(0xffFF4F5A),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Text("Sign up"),
                        onPressed: () {
                          setState(() {
                            formVisible = true;
                            _formsIndex = 2;
                          });
                        },
                      ),
                    ),
                    const SizedBox(width: 10.0),
                  ],
                ),
                const SizedBox(height: 40.0),
                const SizedBox(height: 20.0),
              ],
            ),
          ),
          AnimatedSwitcher(
            duration: Duration(milliseconds: 200),
            child: (!formVisible)
                ? null
                : Container(
                    color: Colors.black54,
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            RaisedButton(
                              textColor: _formsIndex == 1
                                  ? Colors.white
                                  : Color(0xffFF4F5A),
                              color: _formsIndex == 1
                                  ? Color(0xffFF4F5A)
                                  : Colors.white,
                              child: Text("Login"),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0)),
                              onPressed: () {
                                setState(() {
                                  _formsIndex = 1;
                                });
                              },
                            ),
                            const SizedBox(width: 10.0),
                            RaisedButton(
                              textColor: _formsIndex == 2
                                  ? Colors.white
                                  : Color(0xffFF4F5A),
                              color: _formsIndex == 2
                                  ? Color(0xffFF4F5A)
                                  : Colors.white,
                              child: Text("Sign up"),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0)),
                              onPressed: () {
                                setState(() {
                                  _formsIndex = 2;
                                });
                              },
                            ),
                            const SizedBox(width: 10.0),
                            IconButton(
                              color: Colors.white,
                              icon: Icon(Icons.clear),
                              onPressed: () {
                                setState(() {
                                  formVisible = false;
                                });
                              },
                            )
                          ],
                        ),
                        Container(
                          child: AnimatedSwitcher(
                            duration: Duration(milliseconds: 300),
                            child:
                                _formsIndex == 1 ? LoginForm() : SignupForm(),
                          ),
                        )
                      ],
                    ),
                  ),
          )
        ],
      ),
    ));
  }
}

class LoginForm extends StatelessWidget {
  final emailLoginController = TextEditingController();
  final passwordLoginController = TextEditingController();
  // const LoginForm({
  //   Key? key,
  // }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);

    return Container(
      margin: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.all(16.0),
        children: <Widget>[
          TextField(
            keyboardType: TextInputType.emailAddress,
            controller: emailLoginController,
            decoration: InputDecoration(
              hintText: "Email",
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 10.0),
          TextField(
            obscureText: true,
            controller: passwordLoginController,
            decoration: InputDecoration(
              hintText: "Password",
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 10.0),
          RaisedButton(
            color: Color(0xffFF4F5A),
            textColor: Colors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Text("Login"),
            onPressed: () async {
              await authService.signInWithEmailAndPassword(
                  emailLoginController.text, passwordLoginController.text);
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => HomeScreen()));
              print("Successfully Registered");
            },
          ),
        ],
      ),
    );
  }
}

class SignupForm extends StatefulWidget {
  SignupForm({Key? key}) : super(key: key);

  @override
  _SignupFormState createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final _formKey = GlobalKey<FormState>();

  var email = "";
  var password = "";
  var confirmPassword = "";
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final addressController = TextEditingController();
  final phoneController = TextEditingController();
  final dateController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  registration() async {}
  // const SignupForm({
  //   Key? key,
  // }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);

    return Container(
      margin: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: SingleChildScrollView(
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.all(16.0),
          children: <Widget>[
            TextFormField(
              keyboardType: TextInputType.name,
              controller: nameController,
              decoration: InputDecoration(
                hintText: "Name",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10.0),
            TextFormField(
              keyboardType: TextInputType.number,
              controller: phoneController,
              decoration: InputDecoration(
                hintText: "Phone Number",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10.0),
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              controller: emailController,
              decoration: InputDecoration(
                hintText: "Email",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10.0),
            TextFormField(
              keyboardType: TextInputType.streetAddress,
              controller: addressController,
              decoration: InputDecoration(
                hintText: "Address",
                border: OutlineInputBorder(),
              ),
            ),
            // const SizedBox(height: 10.0),
            // TextFormField(
            //   keyboardType: TextInputType.datetime,
            //   controller: dateController,
            //   decoration: InputDecoration(
            //     hintText: "Date of Birth",
            //     border: OutlineInputBorder(),
            //   ),
            // ),
            const SizedBox(height: 10.0),
            TextFormField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                hintText: "Password",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10.0),
            RaisedButton(
              color: Color(0xffFF4F5A),
              textColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Text("Sign up"),
              onPressed: () async {
                final user = await authService.createUserWithEmailAndPassword(
                    emailController.text, passwordController.text);
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => HomeScreen()));
                print("Successfully Registered");
                //Navigator.pop(context);
                print("Successfully Registered");
                print(user!.uid);
                CollectionReference users =
                    FirebaseFirestore.instance.collection('users');
                return users.doc(user.uid).set({
                  'name': nameController.text,
                  'phone': phoneController.text,
                  'email': emailController.text,
                  'address': addressController.text,
                  'dob': dateController.text
                }).then(
                  (value) {
                    Fluttertoast.showToast(
                        msg: "User Created Successfully!",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM);
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => HomeScreen()));
                    print("Successfully Registered");
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
