import 'package:flutter/material.dart';

import '../model/contact.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController contactController = TextEditingController();

  List<Contact> contacts = List.empty(growable: true);
  int selectIndex = -1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Contacts"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                  hintText: "Contact Name",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)))),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: contactController,
              keyboardType: TextInputType.number,
              maxLength: 10,
              decoration: InputDecoration(
                hintText: "contact",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    String name = nameController.text.trim();
                    String contact = contactController.text.trim();
                    if (name.isNotEmpty && contact.isNotEmpty) {
                      setState(() {
                        nameController.text = '';
                        contactController.text = '';
                        contacts.add(Contact(name: name, contace: contact));
                      });
                    }
                  },
                  child: Text("Save"),
                ),
                ElevatedButton(
                  onPressed: () {
                    String name = nameController.text.trim();
                    String contact = contactController.text.trim();
                    if (name.isNotEmpty && contact.isNotEmpty) {
                      setState(() {
                        nameController.text = '';
                        contactController.text = '';

                        contacts[selectIndex].name = name;
                        contacts[selectIndex].contace = contact;
                        print(contacts[selectIndex].name);
                        print( contacts[selectIndex].contace);
                        selectIndex = -1;
                      });
                    }
                  },
                  child: Text("Update"),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            contacts.isEmpty
                ? Text(
                    'No contect..',
                    style: TextStyle(fontSize: 20),
                  )
                : Expanded(
                    child: ListView.builder(
                      itemCount: contacts.length,
                      itemBuilder: (context, index) => getRow(index),
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  Widget getRow(int index) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: index % 2 == 0 ? Colors.red : Colors.green,
          foregroundColor: Colors.white,
          child: Text(
            contacts[index].name[0],
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              contacts[index].name,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(contacts[index].contace),
          ],
        ),
        trailing: SizedBox(
          width: 70,
          child: Row(children: [
            InkWell(
              onTap: () {
                nameController.text = contacts[index].name;
                contactController.text = contacts[index].contace;
                setState(() {
                  print("icon update" + index.toString());
                  selectIndex = index;
                });
                print("icon update selectIndex" + selectIndex.toString());
              },
              child: Icon(Icons.edit),
            ),
            InkWell(
              onTap: () {
                setState(() {
                  contacts.removeAt(index);
                });
              },
              child: Icon(Icons.delete),
            ),
          ]),
        ),
      ),
    );
  }
}
