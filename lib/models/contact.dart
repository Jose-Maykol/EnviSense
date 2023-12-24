import 'package:cloud_firestore/cloud_firestore.dart';

class Contact {
  final String name;
  final String email;

  Contact({
    required this.name,
    required this.email,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
    };
  }

  factory Contact.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    return Contact(
      name: snapshot.data()?['name'] ?? '',
      email: snapshot.data()?['email'] ?? '',
    );
  }
}
