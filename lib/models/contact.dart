import 'package:cloud_firestore/cloud_firestore.dart';

class Contact {
  final String id;
  final String name;
  final String email;

  Contact({
    required this.id,
    required this.name,
    required this.email,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
    };
  }

  factory Contact.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    return Contact(
      id: snapshot.id,
      name: snapshot.data()?['name'] ?? '',
      email: snapshot.data()?['email'] ?? '',
    );
  }
}
