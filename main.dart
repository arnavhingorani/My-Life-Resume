//@dart=2.9

import 'package:flutter/material.dart';
import 'package:my_life_resume/add.dart';
import 'package:my_life_resume/splashScreen.dart';
import 'package:my_life_resume/profileScreen.dart';
import 'homeScreen.dart';
import 'package:my_life_resume/welcome.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:my_life_resume/auth_service.dart';
import 'package:my_life_resume/wrapper.dart';
import 'package:my_life_resume/onboard_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthService>(
          create: (_) => AuthService(),
        ),
      ],
      child: MaterialApp(
        home: SplashScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
