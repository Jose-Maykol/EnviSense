
import 'package:airsense/constant/colors.dart';
import 'package:airsense/models/device.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class DeviceSwitch extends StatelessWidget {
  const DeviceSwitch({
    Key? key,
    required this.device,
  }) : super(key: key);

  final Device device;

  @override
  Widget build(BuildContext context) {
    final DatabaseReference commandRef =
        FirebaseDatabase.instance.ref().child('commandsManager/${device.id}');

    return StreamBuilder(
      stream: commandRef.onValue,
      builder: (context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData && snapshot.data != null) {
          final commandData = snapshot.data!.snapshot.value;
          final bool isDeviceOn = commandData['command'] == 'on';

          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                isDeviceOn ? 'ON' : 'OFF',
                style: const TextStyle(
                  fontSize: 16,
                  color: AppColor.white,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.left,
              ),
              Switch(
                value: isDeviceOn,
                onChanged: (value) {
                  final newCommand = value ? 'on' : 'off';
                  commandRef.update({'command': newCommand});
                },
                activeTrackColor: AppColor.white,
                activeColor: device.getColor(),
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
            ],
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}