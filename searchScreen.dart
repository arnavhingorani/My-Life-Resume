import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_life_resume/add.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List names = [
    "Qualified for National Math Contest",
    "Sang in School Choir",
    "Played in 2 National Tennis Tournaments",
    "Volunteered at Children's Hospital",
    "2nd Degree Black Belt in Taekwondo",
    "1st Place in Spelling Bee",
    "Moved to Houston"
  ];
  List occupations = [
    "Academics",
    "Art",
    "Sports",
    "Volunteer",
    "Sports",
    "Academics",
    "Fun",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemCount: names.length,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) => Container(

                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                child: Card(
                  color: Color(0xFFFF4F5A),
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            // Container(
                            //   width: 55.0,
                            //   height: 55.0,
                            //   child: CircleAvatar(
                            //     backgroundColor: Color(0xFFff5722),
                            //     foregroundColor: Color(0xFFff5722),
                            //     backgroundImage: NetworkImage(
                            //         "https://images.unsplash.com/photo-1614036417651-efe5912149d8?ixid=MnwxMjA3fDB8MHxzZWFyY2h8NHx8dHJvcGh5fGVufDB8fDB8fA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60"),
                            //   ),
                            // ),
                            SizedBox(
                              width: 10.0,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(names[index],
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold)),
                                Text(occupations[index],
                                    style: TextStyle(color: Colors.white)),
                              ],
                            ),
                          ],
                        ),
                        Container(),
                      ],
                    ),
                  ),
                ),
              )),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        child: Text(
          "+",
          style:
          TextStyle(fontSize: 40,color:Color(0xFFFF4F5A)),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => Add(),
            ),
          );
        },
        tooltip: "Add Event",
      ),

    );
  }
}
