

import 'package:airsense/models/contact.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreDatabase {
  Future<List<Contact>> getContacts() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    List<Contact> fetchedContacts = [];

    try {
      print('Getting contacts...');
      User? user = FirebaseAuth.instance.currentUser;
      QuerySnapshot querySnapshot = await firestore.collection('contacts').where('userId', isEqualTo: user?.uid).get();
      print(querySnapshot.docs.length);
      querySnapshot.docs.forEach((doc) {
        Contact contact = Contact.fromSnapshot(doc as DocumentSnapshot<Map<String, dynamic>>);
        fetchedContacts.add(contact);
        print(contact.id );
      });
      return fetchedContacts;
    } catch (e) {
      print('Error getting contacts: $e');
      return fetchedContacts;
    }
  }
}