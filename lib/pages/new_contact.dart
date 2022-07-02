import 'dart:io';

import 'package:contact_liat/Model/model.dart';
import 'package:contact_liat/pages/contact_list.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class NewContactPage extends StatefulWidget {
  static const String routeName = "/newContactPage";
  NewContactPage({Key? key}) : super(key: key);

  @override
  State<NewContactPage> createState() => _NewContactPageState();
}

Box? contactBox;

class _NewContactPageState extends State<NewContactPage> {
  final nameControler = TextEditingController();

  final phoneControler = TextEditingController();

  final emailControler = TextEditingController();

  final webControler = TextEditingController();

  final loctionControler = TextEditingController();
  String? dob;
  String? imgpath;
  String? genderGroupvalue = "Male";
  ImageSource imgsorce = ImageSource.camera;

  @override
  void initState() {
    contactBox = Hive.box('contant-box');
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    nameControler.dispose();
    emailControler.dispose();
    webControler.dispose();
    loctionControler.dispose();
    phoneControler.dispose();

    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("New Contact Page"),
        actions: [IconButton(onPressed: saveData, icon: Icon(Icons.save))],
      ),
      body: ListView(padding: const EdgeInsets.all(16.0), children: [
        TextField(
          keyboardType: TextInputType.name,
          controller: nameControler,
          decoration: InputDecoration(
              filled: true,
              fillColor: Colors.indigo[50],
              labelText: "Enter your Name",
              hintText: "Your name",
              prefixIcon: Icon(Icons.person),
              border: OutlineInputBorder(
                  gapPadding: 5,
                  borderRadius: BorderRadius.circular(
                    10,
                  ))),
        ),
        SizedBox(
          height: 12,
        ),
        TextField(
          keyboardType: TextInputType.phone,
          controller: phoneControler,
          decoration: InputDecoration(
              filled: true,
              fillColor: Colors.indigo[50],
              labelText: "Enter your phone",
              hintText: "Your phone",
              prefixIcon: Icon(Icons.call),
              border: OutlineInputBorder(
                  gapPadding: 5,
                  borderRadius: BorderRadius.circular(
                    10,
                  ))),
        ),
        SizedBox(
          height: 12,
        ),
        TextField(
          keyboardType: TextInputType.emailAddress,
          controller: emailControler,
          decoration: InputDecoration(
              filled: true,
              fillColor: Colors.indigo[50],
              labelText: "Enter your Email",
              hintText: "Your Email",
              prefixIcon: Icon(Icons.email),
              border: OutlineInputBorder(
                  gapPadding: 5,
                  borderRadius: BorderRadius.circular(
                    10,
                  ))),
        ),
        SizedBox(
          height: 12,
        ),
        TextField(
          keyboardType: TextInputType.url,
          controller: webControler,
          decoration: InputDecoration(
              filled: true,
              fillColor: Colors.indigo[50],
              labelText: "Enter your Url",
              hintText: "Your Url",
              prefixIcon: Icon(Icons.link),
              border: OutlineInputBorder(
                  gapPadding: 5,
                  borderRadius: BorderRadius.circular(
                    10,
                  ))),
        ),
        SizedBox(
          height: 12,
        ),
        TextField(
          keyboardType: TextInputType.text,
          controller: loctionControler,
          decoration: InputDecoration(
              filled: true,
              fillColor: Colors.indigo[50],
              labelText: "Enter your Name",
              hintText: "Your name",
              prefixIcon: Icon(Icons.location_on),
              border: OutlineInputBorder(
                  gapPadding: 5,
                  borderRadius: BorderRadius.circular(
                    10,
                  ))),
        ),
        SizedBox(
          height: 12,
        ),
        Card(
          elevation: 10,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text('Select Your Gender'),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Radio<String>(
                      value: "Male",
                      groupValue: genderGroupvalue,
                      onChanged: (value) {
                        setState(() {
                          genderGroupvalue = value;
                        });
                      }),
                  const Text("Male"),
                  SizedBox(
                    width: 7,
                  ),
                  Radio<String>(
                      value: "Female",
                      groupValue: genderGroupvalue,
                      onChanged: (value) {
                        setState(() {
                          genderGroupvalue = value;
                        });
                      }),
                  const Text("Female")
                ],
              )
            ],
          ),
        ),
        SizedBox(
          height: 12,
        ),
        Row(
          children: <Widget>[
            TextButton(
                onPressed: _ShowDateTime,
                child: const Text("Select Date of Birth")),
            Chip(label: Text(dob == null ? "No Date Time Chosen" : dob!))
          ],
        ),
        SizedBox(
          height: 12,
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Card(
              elevation: 10,
              child: imgpath == null
                  ? Image.asset(
                      "assets/person.png",
                      height: 100,
                      width: 100,
                      fit: BoxFit.cover,
                    )
                  : Image.file(
                      File(imgpath!),
                      height: 100,
                      width: 100,
                      fit: BoxFit.cover,
                    ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextButton.icon(
                    onPressed: () {
                      _pickimg();
                      imgsorce = ImageSource.camera;
                    },
                    icon: const Icon(Icons.camera),
                    label: const Text("Camera")),
                TextButton.icon(
                    onPressed: () {
                      imgsorce = ImageSource.gallery;
                      _pickimg();
                    },
                    icon: const Icon(Icons.photo),
                    label: const Text("Gallary")),
              ],
            )
          ],
        )
      ]),
    );
  }

  void _ShowDateTime() async {
    DateTime? datertime = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1922),
        lastDate: DateTime.now());

    if (datertime != null) {
      setState(() {
        dob = DateFormat('dd/MM/ yyyy').format(datertime);
      });
    }
  }

  void _pickimg() async {
    final pickimg = await ImagePicker()
        .pickImage(source: imgsorce, preferredCameraDevice: CameraDevice.front);
    if (pickimg != null) {
      setState(() {
        imgpath = pickimg.path;
      });
    }
  }

  void saveData() {
    final contact = ContactModel(
      mobile: phoneControler.text,
      name: nameControler.text,
      email: emailControler.text,
      wibsite: webControler.text,
      streetLocation: loctionControler.text,
      img: imgpath,
      gender: genderGroupvalue,
      dob: dob,
    );
    contactBox!.add(contact);
    Navigator.pop(context);
  }
}
