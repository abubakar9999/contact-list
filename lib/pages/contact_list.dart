import 'package:contact_liat/Model/model.dart';
import 'package:contact_liat/pages/contact_deteals.dart';
import 'package:contact_liat/pages/new_contact.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ContactList extends StatefulWidget {
  static const String routeName = "/";
  ContactList({Key? key}) : super(key: key);

  @override
  State<ContactList> createState() => _ContactListState();
}

class _ContactListState extends State<ContactList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Contact List"),
        ),
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () => Navigator.of(context)
                    .pushNamed(NewContactPage.routeName)
                    .then((value) {
                  setState(() {});
                })),
        body: ValueListenableBuilder(
            valueListenable: Hive.box("contant-box").listenable(),
            builder: (context, box, widget) {
              return ListView.builder(
                  itemCount: contactBox!.keys.toList().length,
                  itemBuilder: (context, index) {
                    final contact = contactBox!.getAt(index);
                    return Card(
                        child: ListTile(
                            onTap: () {
                              Navigator.of(context).pushNamed(
                                  ContactDetels.routeName,
                                  arguments: contact);
                            },
                            leading: CircleAvatar(
                              child: Text(contact.name.substring(0, 2)),
                            ),
                            title: Text(contactBox!.getAt(index))));
                  });
            }));
  }
}
