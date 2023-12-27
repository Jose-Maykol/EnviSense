

import 'package:airsense/models/data.dart';
import 'package:airsense/providers/device_provider.dart';
import 'package:airsense/services/firestore_database.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dataLastWeekProvider = FutureProvider.autoDispose<List<Data>>((ref) async {
  final deviceId = ref.watch(deviceIdProvider.notifier).state; 
  final dynamic listData = await FirestoreDatabase().getDataLastWeek(deviceId);
  return listData;
});

final dataLastHoursProvider = FutureProvider.autoDispose<List<Data>>((ref) async {
  final deviceId = ref.watch(deviceIdProvider.notifier).state; 
  final dynamic listData = await FirestoreDatabase().getDataLast8Hours(deviceId);
  return listData;
});