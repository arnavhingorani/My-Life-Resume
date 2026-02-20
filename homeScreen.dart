import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_life_resume/profileScreen.dart';
import 'package:my_life_resume/searchScreen.dart';

class HomeScreen extends StatelessWidget {
  // const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:Color(0xFFFF4F5A),
        actions: [
          RaisedButton(
            //padding: EdgeInsets.only(right: 200),
            color: Colors.white,
              child: Text("Share",style:TextStyle(color:Color(0xFFFF4F5A)),),
              onPressed: (){
              Text("Feature under Development");
              }),
          RaisedButton(

              color: Colors.white,
              child: Text("Network",style:TextStyle(color:Color(0xFFFF4F5A)),),
              onPressed: (){}),
          IconButton(
            iconSize: 40,
            padding: EdgeInsets.all(0),
            icon: CircleAvatar(
              backgroundColor: Colors.grey.shade300,
              child: CircleAvatar(
                  radius: 16,
                  backgroundImage: NetworkImage(
                      "https://cdn.onlinewebfonts.com/svg/img_87237.png")),
            ),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => ProfileScreen(),
                ),
              );
            },
          ),
        ],
        automaticallyImplyLeading: false,
      ),
      body: Container(child: SearchScreen()),
    );
  }
}
