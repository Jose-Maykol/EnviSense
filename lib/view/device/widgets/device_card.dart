import 'package:airsense/constant/colors.dart';
import 'package:airsense/models/device.dart';
import 'package:airsense/providers/device_provider.dart';
import 'package:airsense/view/device/device_view.dart';
import 'package:airsense/view/device/widgets/device_switch.dart';
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
    _deviceRef = FirebaseDatabase.instance.ref().child('devices/${device.id}');

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    ref.watch(deviceIdProvider.notifier).state;
    
    return StreamBuilder(
      stream: _deviceRef.onValue,
      builder: (context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData) {
          final deviceData = snapshot.data!.snapshot.value;
          final value = deviceData['value'];
          // final category = deviceData['category'];

          return GestureDetector(
            onTap: () {
              Navigator.push(
                context, 
                MaterialPageRoute(
                  builder: (context) => DeviceView(
                    device: device,
                    color: device.getColor()
                  ),
                ),
              );
              ref.read(deviceIdProvider.notifier).state = device.id;
            },
            child: Container(
              height: 190,
              width: MediaQuery.of(context).size.width * 0.4,
              margin: const EdgeInsets.symmetric(vertical: 5),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                color: device.getColor(),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          device.getIcon(),
                          size: 30,
                          color: AppColor.white,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          device.name,
                          style: const TextStyle(
                            fontSize: 18,
                            color: AppColor.white,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.left,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Expanded(
                      child: Center(
                        child: Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: value.toString(),
                                style: const TextStyle(
                                  fontSize: 45,
                                  color: AppColor.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextSpan(
                                text: ' ${device.unit}',
                                style: const TextStyle(
                                  fontSize: 20,
                                  color: AppColor.white,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    DeviceSwitch(device: device),
                  ],
                ),
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return Container(
            height: 190,
            width: MediaQuery.of(context).size.width * 0.40,
            margin: const EdgeInsets.symmetric(vertical: 5),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: AppColor.red100,
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  'Lo sentimos, el dispositivo ${device.name} no está disponible 😢',
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColor.white,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            )
          );
        } else {
          return SizedBox(
            height: 190,
            width: MediaQuery.of(context).size.width * 0.40,
            child: const Center(
              child: CircularProgressIndicator()
            )
          );
        }
      },
    );
  }
}

