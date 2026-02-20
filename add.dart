import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_life_resume/homeScreen.dart';
import 'package:image_picker/image_picker.dart';

class Add extends StatefulWidget {
  const Add({Key? key}) : super(key: key);

  @override
  _AddState createState() => _AddState();
}

class _AddState extends State<Add> {
  var formKey = GlobalKey<FormState>();
  var _options = [
    'Other',
    'Academics',
    'Sports',
    'Volunteering',
    'Fun',
    'Art',
  ];
  var nameController = TextEditingController();
  var descriptionController = TextEditingController();
  var subCategoryController = TextEditingController();
  var locationController = TextEditingController();
  File? _image;
  final picker = ImagePicker();
  DateTime currentDate = DateTime.now();
  //final DateFormat formatter = DateFormat('yyyy-MM-dd');

  final lastDate = DateTime(2030, 1);
  final firstDate = DateTime(1900, 1);
  Future getImageFromCamera() async {
    final pickedImage = await picker.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedImage != null) {
        _image = File(pickedImage.path);
      } else {
        print("No Image Selected");
      }
    });
  }

  Future getImageFromGallery() async {
    final pickedImage = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedImage != null) {
        _image = File(pickedImage.path);
      } else {
        print("No Image Selected");
      }
    });
  }

  // String name, description, date, category, subcategory, location;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add"),
        backgroundColor: Color(0xffFF4F5A),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: nameController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: "Name of Event",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0)),
                  ),
                  // validator: (text) {
                  //   if (text.isEmpty) {
                  //     return 'Name is Required';
                  //   } else {
                  //     name=String.parse(text);
                  //   }
                  // },
                ),
                SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: descriptionController,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    labelText: "Description",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0)),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                // TextFormField(
                //   keyboardType: TextInputType.text,
                //   decoration: InputDecoration(
                //     labelText: "Date",
                //     border: OutlineInputBorder(
                //         borderRadius: BorderRadius.circular(8.0)),
                //   ),
                // ),
                Text('$currentDate'.split(' ')[0]),
                ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all
                        <Color>(Color(0xffFF4F5A))),

                    onPressed: () => _openDatePicker(context),
                    child: Text("Select Date")),
                // CalendarDatePicker(
                //   initialDate: selectedDate,
                //   firstDate: firstDate,
                //   lastDate: lastDate,
                //   onDateChanged: (newDate) {
                //     selectedDate = newDate;
                //   },
                // ),
                SizedBox(
                  height: 16,
                ),


                SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: subCategoryController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: "Category",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0)),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: locationController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: "Location",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0)),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    FloatingActionButton(
                      backgroundColor: Color(0xFFFF4F5A),
                      onPressed: getImageFromCamera,
                      tooltip: "Pick image from camera",
                      child: Icon(Icons.camera),
                    ),
                    FloatingActionButton(
                      backgroundColor: Color(0xFFFF4F5A),
                      onPressed: getImageFromGallery,
                      tooltip: "Pick image from gallery",
                      child: Icon(Icons.folder),
                    ),
                  ],
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 100,
                  child: Center(
                      child: _image == null
                          ? Text(
                              "No Image Selected",
                              style: TextStyle(color: Colors.black),
                            )

                          : new Image.file(_image!),
                ),
                SizedBox(
                  height: 40,
                ),
                ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all
                        <Color>(Color(0xffFF4F5A))),
                    onPressed: () {
                      addEventData(nameController.text,descriptionController.text,currentDate,subCategoryController.text,locationController.text);

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => HomeScreen(),
                        ),
                      );
                    },
                    child: Text("Add"))
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _openDatePicker(BuildContext context) async {
    final DateTime? date = await showDatePicker(
        context: context,
        initialDate: currentDate,
        firstDate: firstDate,
        lastDate: lastDate);
    if (date != null && date != currentDate)
      setState(() {
        currentDate = date;
      });
  }
  addEventData(name,description,date,subCategory,location){
    CollectionReference users = FirebaseFirestore.instance.collection('events');
    var _uid = FirebaseAuth.instance.currentUser!.uid;
    return users.doc('$_uid')
        .set({'name of event':name,'description of event':description,'date of event':date,'subCategory of event':subCategory,'location of event':location})
        .then((value) => Fluttertoast.showToast(
        msg: "Event Added Successfully!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM));
  }
}
