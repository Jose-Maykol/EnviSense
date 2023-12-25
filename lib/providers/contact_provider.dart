import 'package:airsense/models/contact.dart';
import 'package:airsense/services/firestore_database.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod/riverpod.dart';

final contactProvider = FutureProvider.autoDispose<List<Contact>>((ref) async {
  final dynamic listContacts = await FirestoreDatabase().getContacts();
  return listContacts;
});