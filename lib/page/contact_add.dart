import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class ContactAdd extends StatefulWidget {
  const ContactAdd({Key? key}) : super(key: key);

  @override
  _ContactAddState createState() => _ContactAddState();
}

class _ContactAddState extends State<ContactAdd> {
  late TextEditingController _namecontroller, _numbercontroller;
  late DatabaseReference _ref;

  @override
  void initState() {
    super.initState();
    _namecontroller = TextEditingController();
    _numbercontroller = TextEditingController();
    _ref = FirebaseDatabase.instance.reference().child('Contacts');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Contact"),
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
                  "Save Contact",
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

  void save() {
    String name = _namecontroller.text;
    String num = _numbercontroller.text;
    if (name == "" || num == "") {
      final snackbar= SnackBar(content: Text("Please enter name and number!"));
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    } else {
      Map<String, String> contact = {'name': name, 'number': num};
      _ref.push().set(contact).then((value) => Navigator.pop(context));
    }
  }
}
