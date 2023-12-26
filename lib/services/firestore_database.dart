

import 'package:airsense/models/contact.dart';
import 'package:airsense/models/device.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreDatabase {
  Future<List<Contact>> getContacts() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    List<Contact> fetchedContacts = [];
    try {
      User? user = FirebaseAuth.instance.currentUser;
      QuerySnapshot querySnapshot = await firestore.collection('contacts').where('userId', isEqualTo: user?.uid).get();
      for (var doc in querySnapshot.docs) {
        Contact contact = Contact.fromSnapshot(doc as DocumentSnapshot<Map<String, dynamic>>);
        fetchedContacts.add(contact);
      }
      return fetchedContacts;
    } catch (e) {
      print('Error getting contacts: $e');
      return fetchedContacts;
    }
  }

  Future<List<Device>> getDevices() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    List<Device> fetchedDevices = [];
    try {
      // User? user = FirebaseAuth.instance.currentUser;
      // QuerySnapshot querySnapshot = await firestore.collection('devices').where('userId', isEqualTo: user?.uid).get();
      QuerySnapshot querySnapshot = await firestore.collection('devices').get();
      for (var doc in querySnapshot.docs) {
        Device device = Device.fromSnapshot(doc as DocumentSnapshot<Map<String, dynamic>>);
        fetchedDevices.add(device);
      }
      return fetchedDevices;
    } catch (e) {
      print('Error getting devices: $e');
      return fetchedDevices;
    }
  }
}