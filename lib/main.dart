import 'package:contact_liat/pages/contact_deteals.dart';
import 'package:contact_liat/pages/contact_list.dart';
import 'package:contact_liat/pages/new_contact.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  var box = await Hive.openBox('contant-box');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: ContactList.routeName,
      routes: {
        ContactList.routeName: (context) => ContactList(),
        NewContactPage.routeName: (context) => NewContactPage(),
        ContactDetels.routeName: (context) => ContactDetels(),
      },
    );
  }
}
