import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class ContactEdit extends StatefulWidget {
  // late final Map<dynamic, dynamic> oldContact;
  late final String contactKey;
  ContactEdit(String cnt) {
    contactKey = cnt;
  }

  @override
  _ContactEditState createState() => _ContactEditState();
}

class _ContactEditState extends State<ContactEdit> {
  late TextEditingController _namecontroller, _numbercontroller;
  late DatabaseReference _ref;

  @override
  void initState() {
    super.initState();
    _namecontroller = TextEditingController();
    _numbercontroller = TextEditingController();
    _ref = FirebaseDatabase.instance.reference().child('Contacts');
    getContact();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Update Contact"),
      ),
      body: Container(
        margin: EdgeInsets.only(top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: _namecontroller,
              decoration: InputDecoration(
                hintText: "Name",
                contentPadding: EdgeInsets.all(8),
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: _numbercontroller,
              decoration: InputDecoration(
                hintText: "Phone Number",
                contentPadding: EdgeInsets.all(8),
              ),
            ),
            SizedBox(height: 30),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Colors.blue,
                    padding: EdgeInsets.symmetric(vertical: 10)),
                child: Text(
                  "Update Contact",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
                onPressed: () {
                  save();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  getContact() async {
    DataSnapshot snapshot = await _ref.child(widget.contactKey).once();
    Map contact = snapshot.value;

    _namecontroller.text = contact['name'];
    _numbercontroller.text = contact['number'];
  }

  void save() {
    String name = _namecontroller.text;
    String num = _numbercontroller.text;
    if (name == "" || num == "") {
      final snackbar = SnackBar(content: Text("Please enter name and number!"));
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    } else {
      Map<String, String> contact = {'name': name, 'number': num};
      _ref
          .child(widget.contactKey)
          .update(contact)
          .then((value) => Navigator.pop(context));
    }
  }
}
