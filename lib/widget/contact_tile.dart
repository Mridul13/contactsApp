
import 'package:contacts_page/page/contact_edit.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class ContactTile extends StatelessWidget {
  late final Map<dynamic, dynamic> contact;
  ContactTile(Map<dynamic, dynamic> cnt) {
    contact = cnt;
  }

  DatabaseReference reference =
      FirebaseDatabase.instance.reference().child("Contacts");

  _deleteDialog(Map contact, context) {
    showDialog(
      context: context,
      builder: (context) { 
        return AlertDialog(
          title: Text("Delete ${contact['name']}"),
          content: Text("Do you want to permanetly delete the contact?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Cancel"),
            ),
            TextButton(
                onPressed: () {
                  reference
                      .child(contact['key'])
                      .remove()
                      .whenComplete(() => Navigator.pop(context));
                },
                child: Text("Delete")),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 70,
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CircleAvatar(
                // backgroundColor: Colors.blue.shade500,
                child: Text(
                  contact['name'][0],
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
                ),
              ),
              SizedBox(width: 20),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    contact['name'],
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 6),
                  Text(
                    contact['number'],
                    style: TextStyle(fontSize: 15),
                  ),
                ],
              ),
            ],
          ),
          Row(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ContactEdit(contact['key']),
                    ),
                  );
                  // print(contact['key']);
                },
                icon: Icon(Icons.edit, color: Colors.blue),
              ),
              IconButton(
                onPressed: () {
                  _deleteDialog(contact, context);
                },
                icon: Icon(Icons.delete, color: Colors.red),
              ),
            ],
          )
        ],
      ),
    );
  }
}
