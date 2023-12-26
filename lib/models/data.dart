import 'package:cloud_firestore/cloud_firestore.dart';

class Data {
  final String id;
  final String deviceId;
  final int value;
  final DateTime timestamp;

  Data({
    required this.id,
    required this.deviceId,
    required this.value,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'deviceId': deviceId,
      'value': value,
      'timestamp': timestamp,
    };
  }

  factory Data.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    return Data(
      id: snapshot.id,
      deviceId: snapshot.data()?['deviceID'] ?? '',
      value: snapshot.data()?['value'] ?? 0,
      timestamp: snapshot.data()?['timestamp'].toDate(),
    );
  }
}