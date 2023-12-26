import 'package:airsense/models/device.dart';
import 'package:airsense/services/firestore_database.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final deviceProvider = FutureProvider.autoDispose<List<Device>>((ref) async {
  final dynamic listDevices = await FirestoreDatabase().getDevices();
  return listDevices;
});

final deviceIdProvider = StateProvider<String>((ref) => '');