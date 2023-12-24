import 'package:airsense/constant/colors.dart';
import 'package:airsense/models/Contact.dart';
import 'package:airsense/widgets/headers/user_header.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ContactsView extends StatefulWidget {
  const ContactsView({Key? key}) : super(key: key);

  @override
  State<ContactsView> createState() => _ContactsViewState();
}

class _ContactsViewState extends State<ContactsView> {

  List<Contact> contacts = [];

  @override
  void initState() {
    super.initState();
    getContactsFromFirestore();
  }

  void getContactsFromFirestore() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    List<Contact> fetchedContacts = [];

    try {
      print('Getting contacts...');
      QuerySnapshot querySnapshot = await firestore.collection('contacts').get();
      print(querySnapshot.docs.length);
      querySnapshot.docs.forEach((doc) {
        Contact contact = Contact.fromSnapshot(doc as DocumentSnapshot<Map<String, dynamic>>);
        fetchedContacts.add(contact);
        print(contact.name);
      });

      setState(() {
        contacts = fetchedContacts;

      });
    } catch (e) {
      print('Error getting contacts: $e');
    }
  }






  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget> [
            const UserHeader(),
            const SizedBox(height: 20),
            const Text(
              'Mis contactos',
              style: TextStyle(
                fontSize: 16,
                color: AppColor.blue500,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.left,              
            ),
            //const SizedBox(height: 10),
            ListView.builder(
              shrinkWrap: true,
              itemCount: contacts.length,
              itemBuilder: (BuildContext context, int index) {
                if (contacts.isEmpty) {
                  return const Center(
                    child: Text('No hay contactos'),
                  );
                } else {
                  return ListTile(
                    isThreeLine: true,
                    dense: true,
                    title: Text(contacts[index].name),
                    subtitle: Text(contacts[index].email),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () {
                            print('Edit contact');
                          },
                          icon: const Icon(Icons.edit),
                        ),
                        IconButton(
                          onPressed: () {
                            print('Delete contact');
                          },
                          icon: const Icon(Icons.delete),
                        ),
                      ],
                    ),
                  );
                }
              },
            ),
          ] 
        )
      )
    );
  }
}