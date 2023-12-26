

import 'package:cloud_firestore/cloud_firestore.dart';

class Device {
  final String id;
  final String mac;
  final String type;
  final String userId;

  Device({
    required this.id,
    required this.mac,
    required this.type,
    required this.userId,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'mac': mac,
      'type': type,
      'userId': userId,
    };
  }

  factory Device.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    return Device(
      id: snapshot.id,
      mac: snapshot.data()?['mac'] ?? '',
      type: snapshot.data()?['type'] ?? '',
      userId: snapshot.data()?['userId'] ?? '',
    );
  }

}