import 'package:airsense/constant/colors.dart';
import 'package:airsense/models/device.dart';
import 'package:airsense/providers/device_provider.dart';
import 'package:airsense/view/device/device_view.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DeviceCard extends ConsumerWidget {

  final Device device;
  final DatabaseReference _deviceRef;

  DeviceCard({
    super.key, 
    required this.device,
  }): 
    _deviceRef = FirebaseDatabase.instance.ref().child(device.id);
  @override
  Widget build(BuildContext context, WidgetRef ref) {

    ref.watch(deviceIdProvider.notifier).state;
    
    return StreamBuilder(
      stream: _deviceRef.onValue,
      builder: (context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.data!.snapshot.value == null) {
          return const Center(child: Text('Error'));
        }
        if (snapshot.hasData) {
          final deviceData = snapshot.data!.snapshot.value;
          final value = deviceData['value'];
          final category = deviceData['category'];

          return GestureDetector(
            onTap: () {
              Navigator.push(
                context, 
                MaterialPageRoute(
                  builder: (context) => DeviceView(device: device, color: device.type == 'Humedad' ? AppColor.skyblue500 : AppColor.red400),
                ),
              );
              ref.read(deviceIdProvider.notifier).state = device.id;
            },
            child: Container(
              // height: 150,
              margin: const EdgeInsets.symmetric(vertical: 5),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                color: device.type == 'Humedad' ? AppColor.skyblue500 : AppColor.red400,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          device.name,
                          style: const TextStyle(
                            fontSize: 18,
                            color: AppColor.white,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        Text(
                          device.type,
                          style: const TextStyle(
                            fontSize: 14,
                            color: AppColor.white,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: 75,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            category ?? '',
                            style: const TextStyle(
                              fontSize: 14,
                              color: AppColor.white,
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 2),
                          Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: value.toString(),
                                  style: const TextStyle(
                                    fontSize: 30,
                                    color: AppColor.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                TextSpan(
                                  text: device.unit,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: AppColor.white,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
