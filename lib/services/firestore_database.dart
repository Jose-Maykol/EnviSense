

import 'package:airsense/models/contact.dart';
import 'package:airsense/models/data.dart';
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
        print(doc.data());
        fetchedDevices.add(device);
      }
      return fetchedDevices;
    } catch (e) {
      print('Error getting devices: $e');
      return fetchedDevices;
    }
  }

  Future<List<Data>> getDataLastWeek(deviceId) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    List<Data> fetchedData = [];
    DateTime now = DateTime.now();
    DateTime lastWeek = now.subtract(const Duration(days: 8));

    try {
      QuerySnapshot querySnapshot = await firestore.collection('data-history')
        .where('deviceID', isEqualTo: deviceId)
        .where('timestamp', isGreaterThan: lastWeek)
        .get();
      for (var doc in querySnapshot.docs) {
        Data data = Data.fromSnapshot(doc as DocumentSnapshot<Map<String, dynamic>>);
        fetchedData.add(data);
      }
      return fetchedData;
    } catch (e) {
      return fetchedData;
    }
  }

  Future<List<Data>> getDataLast8Hours(deviceId) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    List<Data> fetchedData = [];
    DateTime now = DateTime.now();
    DateTime last8Hours = now.subtract(const Duration(hours: 8));

    try {
      QuerySnapshot querySnapshot = await firestore.collection('data-history')
        .where('deviceID', isEqualTo: deviceId)
        .where('timestamp', isGreaterThan: last8Hours)
        .get();
      for (var doc in querySnapshot.docs) {
        Data data = Data.fromSnapshot(doc as DocumentSnapshot<Map<String, dynamic>>);
        fetchedData.add(data);
      }
      return fetchedData;
    } catch (e) {
      return fetchedData;
    }
  }
}