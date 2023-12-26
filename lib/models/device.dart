

import 'package:cloud_firestore/cloud_firestore.dart';

class Device {
  final String id;
  final String mac;
  final String name;
  final String type;
  final String unit;
  final String userId;

  Device({
    required this.id,
    required this.mac,
    required this.name,
    required this.type,
    required this.unit,
    required this.userId,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'mac': mac,
      'name': name,
      'type': type,
      'unit': unit,
      'userId': userId,
    };
  }

  factory Device.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    return Device(
      id: snapshot.id,
      mac: snapshot.data()?['deviceMAC'] ?? '',
      name: snapshot.data()?['deviceName'] ?? '',
      type: snapshot.data()?['deviceType'].substring(0, 1).toUpperCase() + snapshot.data()?['deviceType'].substring(1) ?? '',
      unit: snapshot.data()?['deviceUnit'] ?? '',
      userId: snapshot.data()?['userId'] ?? '',
    );
  }

}