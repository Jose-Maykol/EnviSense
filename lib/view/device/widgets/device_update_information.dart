import 'package:airsense/constant/colors.dart';
import 'package:airsense/utils/date.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';


class DeviceUpdateInformation extends StatelessWidget {

  final DatabaseReference _deviceRef;
  final String deviceId;

  DeviceUpdateInformation({
    super.key,
    required this.deviceId,
  }):
    _deviceRef = FirebaseDatabase.instance.ref().child('devices/$deviceId');

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _deviceRef.onValue,
      builder: (context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData) {
          final deviceData = snapshot.data!.snapshot.value;
          final timestamp = deviceData['timestamp'];
          String time = getFormattedTime(timestamp);
          String date = getFormattedDate(timestamp);

          return SizedBox(
            width: MediaQuery.of(context).size.width * 0.45,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget> [
                const Text(
                  'Ultima actualización',
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColor.grey500,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  time,
                  style: const TextStyle(
                    fontSize: 60,
                    color: AppColor.grey400,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  date,
                  style: const TextStyle(
                    fontSize: 16,
                    color: AppColor.grey200,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}